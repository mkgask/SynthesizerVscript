import '../String.extensions';
import { Cache } from '../Cache/Cache';

import { IScraper } from './IScraper';
import { ScrapedData } from './ScrapedData';

import fetch from 'node-fetch';



class Scraper implements IScraper
{
    url : string = '';
    cache_filename : string = 'scraped.html';
    scraped_html : ScrapedData = new ScrapedData();
    cache? : Cache = undefined;

    async scrape (url: string, cache_filename: string) : Promise<ScrapedData>
    {
        if (!url && this.url) { url = this.url; }
        if (!url) { throw Error('Scraper.scrape : Invalid url'); }

        if (!cache_filename && this.cache_filename) {
            cache_filename = this.cache_filename;
        }

        if (!cache_filename) { throw Error('Scraper.scrape : Invalid cache filename'); }

        this.cache = new Cache(cache_filename);

        // scraping start when failed load cache file
        try {
            await this.loadCache(cache_filename);
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
            this.saveCache(cache_filename, this.scraped_html.value);
        }

        return this.scraped_html;
    }

    async loadCache(cache_filename : string) : Promise<ScrapedData>
    {
        if (!this.cache) { throw Error('Invalid cache instance'); }

        const cache_data = await this.cache.load(cache_filename);
        this.scraped_html.value = cache_data;
        return this.scraped_html;
    }

    async saveCache(cache_filename : string, cache_data : string) : Promise<boolean>
    {
        if (!this.cache) { throw Error('Invalid cache instance'); }

        await this.cache.save(cache_data, cache_filename);
        return true;
    }
}



export { Scraper };