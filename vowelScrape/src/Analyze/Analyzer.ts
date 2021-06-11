import '../String.extensions';
import { Cache } from '../Cache/Cache';

import { IAnalyzer } from './IAnalyzer';
import { IAnalyzeCallback } from './IAnalyzeCallback';
import { AnalyzedData } from './AnalyzedData';

import { ScrapedData } from '../Scrape/ScrapedData';


import { JSDOM } from 'jsdom';



class Analyzer implements IAnalyzer
{
    cache_filename : string = 'analyzed.lua';
    analyzed_data : AnalyzedData = new AnalyzedData();
    cache : Cache = new Cache(this.cache_filename);

    async analyze(
        html : ScrapedData,
        cache_filename : string,
        callback : IAnalyzeCallback
    ) : Promise<AnalyzedData>
    {
        if (!cache_filename && this.cache_filename) {
            cache_filename = this.cache_filename;
        }

        if (!cache_filename) { throw Error('Scraper.scrape : Invalid cache filename'); }

/*    // don't load analyze data cache because want to definitely process execution every time
        // analyze start when failed load cache file
        try {
            await this.loadCache(cache_filename);
        } catch (err) {
            // throw err;    // キャシュがロード出来なくても処理は問題ないので握りつぶしてOK
        }

        if (this.analyzed_data.value) {
            return this.analyzed_data;
        }
*/

        try {
            const dom = new JSDOM(html.value);
            const document = dom.window.document;
            this.analyzed_data = await callback(document, this.analyzed_data);
        } catch (err) {
            throw err;
        }

        if (this.analyzed_data.value) {
            this.saveCache(cache_filename, this.analyzed_data.value);
        }

        return this.analyzed_data;
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