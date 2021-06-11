import '../String.extensions';
import { Cache } from '../Cache/Cache';

import { IScraper } from './IScraper';
import { ScrapedData } from './ScrapedData';

import fetch from 'node-fetch';
import { exception } from 'console';



class Scraper implements IScraper
{
    url : string = 'https://www.coscom.co.jp/hiragana-katakana/kanatable-j.html';
    cache_filename : string = 'scraped.html';
    scraped_html : ScrapedData = new ScrapedData();
    cache : Cache = new Cache(this.cache_filename);

    async scrape (url?: string) : Promise<ScrapedData>
    {
        if (!url && this.url) { url = this.url; }
        if (!url) { throw exception('Scraper.scrape : Invalid url'); }

        // scraping start when failed load cache file
        try {
            await this.loadCache(this.cache_filename);
        } catch (err) {
            // throw err;    // キャシュがロード出来なくても処理は問題ないので握りつぶしてOK
        }

        if (this.scraped_html.value) {
            return this.scraped_html;
        }

        try {
            this.scraped_html.value = await (await fetch(url)).text();
            console.log('fetch(url) access to : ' + url);
        } catch (err) {
            throw err;
        }

        if (this.scraped_html.value) {
            this.saveCache(this.cache_filename, this.scraped_html.value);
        }

        return this.scraped_html;
    }

    async loadCache(cache_filename : string) : Promise<ScrapedData>
    {
        const cache_data = await this.cache.load(cache_filename);
        this.scraped_html.value = cache_data;
        return this.scraped_html;
    }

    async saveCache(cache_filename : string, cache_data : string) : Promise<boolean>
    {
        await this.cache.save(cache_data, cache_filename);
        return true;
    }
}



export { Scraper };