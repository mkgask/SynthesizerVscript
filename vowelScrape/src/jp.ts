import './String.extensions';

import { IScraper } from './Scrape/IScraper';
import { Scraper } from './Scrape/Scraper';
import { ScrapedData } from './Scrape/ScrapedData';

import { IAnalyzer } from './Analyze/IAnalyzer';
import { Analyzer } from './Analyze/Analyzer';
import { AnalyzedData } from './Analyze/AnalyzedData';



process.on('uncaughtException', (err) => {
    console.error('uncaughtException : ', err);
    process.abort();
});

process.on('unhandledRejection', (reason, promise) => {
    console.error('Unhandled Rejection at : Promise', promise);
    console.error('Unhandled Rejection at : reason:', reason);
    process.abort();
})



const language = 'jp';
const scraped_filename  = language + '.scraped.html';
const analyzed_filename = language + '.analyzed.lua';


// edit ok
const url = 'https://www.coscom.co.jp/hiragana-katakana/kanatable-j.html';



class Controller {
    async exec(scraper : IScraper, analyzer : IAnalyzer) {
        const scraped : ScrapedData = await scraper.scrape(url, scraped_filename);
        console.log('Controller.exec : scraped : ' + scraped.value.truncate_remove_blank(100))

        const analyzed : AnalyzedData = await analyzer.analyze(scraped, analyzed_filename, (document : Document, analyzed_data : AnalyzedData) : AnalyzedData => {
            // edit ok

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
                // カタカナ
                139, 140,    // ヤユヨ
                147, 148,    // ワヲン
            ];

            const space2_list = [
                // ひらがな
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
            const space2 = '            ';

            let return_string : string = 'local vowel_table = {\n' + indentspace4;
            let linefeed = 0;
            const hirakata_length = (hirakata.length - 1);

            for (let i = 0; i < hirakata_length; i += 1) {
                const hk = hirakata[i];
                const rm = romaji_list[i];
                //return_string += i + ': ["' + hk + '"] = ' + '"' + rm + '"';    // to debug run
                return_string += '["' + hk + '"] = ' + '"' + this.getVowel(rm) + '",';
                linefeed += 1;

                if (space1_list.includes(i)) {
                    return_string += space;
                    linefeed += 1;
                }

                if (space2_list.includes(i)) {
                    return_string += space2;
                    linefeed += 1;
                }

                if (linefeed % 5 == 0) {
                    return_string += "\n" + indentspace4;
                }
                else
                if (i == (hirakata_length - 1)) {
                    return_string += "\n";
                }
                else { return_string += ' '; }
            }

            return_string += '}\n';
            analyzed_data.value = return_string;
            return analyzed_data;
        });
        console.log('Controller.exec : analyzed : ' + analyzed.value.truncate_remove_blank(100))
    }



    // edit ok
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

    // edit ok
    splitHiraKata(list : string[]) : [ string[], string[] ]
    {
        const half = Math.round(list.length / 2);

        return [
            list.slice(0, half),
            list.slice(half)
        ]
    }



    // edit ok
    getVowel(phoneme: string) : string
    {
        const phoneme2 = phoneme.replace(/ \(\w+\)$/, '');
        const phoneme3 = phoneme2.substr(-1);
        return phoneme3;
    }

}



const scraper = new Scraper();
const analyzer = new Analyzer();
const controller = new Controller();
controller.exec(scraper, analyzer)
