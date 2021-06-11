import '../String.extensions';
import { Cache } from '../Cache/Cache';

import { IAnalyzer } from './IAnalyzer';
import { AnalyzedData } from './AnalyzedData';

import { ScrapedData } from '../Scrape/ScrapedData';


import { JSDOM } from 'jsdom';



class Analyzer implements IAnalyzer
{
    cache_filename : string = 'analyzed.lua';
    analyzed_data : AnalyzedData = new AnalyzedData();
    cache : Cache = new Cache(this.cache_filename);

    async analyze(html : ScrapedData) : Promise<AnalyzedData>
    {
/*
        // analyze start when failed load cache file
        try {
            await this.loadCache(this.cache_filename);
        } catch (err) {
            // throw err;    // キャシュがロード出来なくても処理は問題ないので握りつぶしてOK
        }
*/
        if (this.analyzed_data.value) {
            return this.analyzed_data;
        }

        try {
            await this.analyze_detail(html);
        } catch (err) {
            throw err;
        }

        if (this.analyzed_data.value) {
            this.saveCache(this.cache_filename, this.analyzed_data.value);
        }

        return this.analyzed_data;
    }

    async analyze_detail(html : ScrapedData) : Promise<AnalyzedData>
    {
        const dom = new JSDOM(html.value);
        const document = dom.window.document;

        // 各文字の要素リストを取得
        const seion_nodes = document.querySelectorAll('.seion');
        const dakuon_nodes = document.querySelectorAll('.dakuon');
        const yoon_nodes = document.querySelectorAll('.yoon');
        const yoodakuon_nodes = document.querySelectorAll('.yoodakuon');
        const romaji_nodes = document.querySelectorAll('.romaji');

        // 要素リストから必要なテキストのみをリスト化
        const seion_list = this.textList(seion_nodes);
        const dakuon_list = this.textList(dakuon_nodes);
        const yoon_list = this.textList(yoon_nodes);
        const yoodakuon_list = this.textList(yoodakuon_nodes);
        const romaji_list = this.textList(romaji_nodes);

        // ひらがなとカタカナが混ざっているので分割
        const [ seion_hira, seion_kata ]= this.splitHiraKata(seion_list);
        const [ dakuon_hira, dakuon_kata ]= this.splitHiraKata(dakuon_list);
        const [ yoon_hira, yoon_kata ]= this.splitHiraKata(yoon_list);
        const [ yoodakuon_hira, yoodakuon_kata ]= this.splitHiraKata(yoodakuon_list);

        // ひらがなだけ、カタカナだけのリストを生成して合体
        const hirakata = ([] as string[]).concat(
            seion_hira,
            dakuon_hira,
            yoon_hira,
            yoodakuon_hira,
            seion_kata,
            dakuon_kata,
            yoon_kata,
            yoodakuon_kata
        );

        // ひらがなカタカナリストとローマ字リストから目的の母音リストを生成

        const space1_list = [
            // ひらがな
             35,  36,    // やゆよ
             43,  44,    // わをん
             71,  72,    // きゃきゅきょ
             74,  75,    // しゃしゅしょ
             77,  78,    // ちゃちゅちょ
             80,  81,    // にゃにゅにょ
             83,  84,    // ひゃひゅひょ
             86,  87,    // みゃみゅみょ
             89,  90,    // りゃりゅりょ
             92,  93,    // ぎゃぎゅぎょ
             95,  96,    // じゃじゅじょ
             98,  99,    // びゃびゅびょ
            101, 102,    // ぴゃぴゅぴょ
            // カタカナ
            139, 140,    // ヤユヨ
            147, 148,    // ワヲン
            175, 176,    // キャキュキョ
            178, 179,    // シャシュショ
            181, 182,    // チャチュチョ
            184, 185,    // ニャニュニョ
            187, 188,    // ヒャヒュヒョ
            190, 191,    // ミャミュミョ
            193, 194,    // リャリュリョ
            196, 197,    // ギャギュギョ
            199, 200,    // ジャジュジョ
            202, 203,    // ビャビュビョ
            205, 206,    // ピャピュピョ
        ];

        const indentspace4 = '    ';
        const space = '              ';

        let return_string : string = 'local vowel_table = {\n' + indentspace4;
        let linefeed = 0;

        for (let i = 0; i < hirakata.length; i += 1) {
            const hk = hirakata[i];
            const rm = romaji_list[i];    // TODO: rmから母音のみ取り出す処理が必要
            //return_string += i + ': ["' + hk + '"] = ' + '"' + rm + '"';    // TODO: index拾い終わったら先頭の i + は削除
            return_string += '["' + hk + '"] = ' + '"' + this.getVowel(rm) + '",';
            linefeed += 1;

            if (space1_list.includes(i)) {
                return_string += space;
                linefeed += 1;
            }

            if (linefeed % 5 == 0) {
                return_string += "\n" + indentspace4;
            }
            else
            if (i == hirakata.length) {
                return_string += "\n";
            }
            else { return_string += ' '; }
        }

        return_string += '}\n';
        this.analyzed_data.value = return_string;
        return this.analyzed_data;
    }

    textList(nodes : NodeListOf<Element>)
    {
        let r : string[] = [];

        for (const key in nodes) {
            const val = nodes[key];
            const text = val.textContent;

            if (!text || text == ' ' || text == '-' || text == '－') {
                continue;
            }

            r.push(text);
        }

        return r;
    }

    splitHiraKata(list : string[]) : [ string[], string[] ]
    {
        const half = Math.round(list.length / 2);

        return [
            list.slice(0, half),
            list.slice(half)
        ]
    }



    getVowel(phoneme: string) : string
    {
        const phoneme2 = phoneme.replace(/ (\w+)$/, '');
        const phoneme3 = phoneme2.substr(-1);
        return phoneme3;
    }



    async loadCache(cache_filename : string) : Promise<AnalyzedData>
    {
        const cache_data = await this.cache.load(cache_filename);
        this.analyzed_data.value = cache_data;
        return this.analyzed_data;
    }

    async saveCache(cache_filename : string, cache_data : string) : Promise<boolean>
    {
        await this.cache.save(cache_data, cache_filename);
        return true;
    }
}



export { Analyzer };