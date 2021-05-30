import '../String.extensions';

import IScraper from './IScraper';
import ScrapedData from './ScrapedData';

import fetch from 'node-fetch';
import { access, readFile, writeFile } from 'fs/promises';
import { constants } from 'fs';
import { exception } from 'console';

const utf8 : BufferEncoding = 'utf8';



class Scraper implements IScraper {
    url : string = 'https://www.coscom.co.jp/hiragana-katakana/kanatable-j.html';
    cache_filepath : string = './src/Scrape/scraped.html';
    scraped_html : ScrapedData = new ScrapedData();

    async scrape (url?: string) : Promise<ScrapedData> {
        if (!url && this.url) { url = this.url; }
        if (!url) { throw exception('Scraper.scrape : Invalid url'); }

        // scraping start when failed load cache file
        try {
            await this.loadCache(this.cache_filepath);
        } catch (err) {
            throw err;
        }

        if (!this.scraped_html.value) {
            try {
                this.scraped_html.value = await (await fetch(url)).text();
            } catch (err) {
                throw err;
            }

            if (this.scraped_html) {
                this.saveCache(this.cache_filepath, this.scraped_html.value);
            }
        }

        return this.scraped_html;
    }

    async loadCache(cache_filepath : string) : Promise<ScrapedData> {
        if (!cache_filepath && this.cache_filepath) { cache_filepath = this.cache_filepath; }
        if (!cache_filepath) throw exception('Scraper.loadCache : Invalid cache_filepath');

        try {
            await access(cache_filepath, constants.R_OK);
        } catch (err) {
            throw err;
        }

        try {
            this.scraped_html.value = (await readFile(cache_filepath)).toString();
            console.log('Scraper.loadCache : this.scraped_html : ' + this.scraped_html.value.truncate_remove_blank(100));
        } catch (err) {
            throw err;
        }

        return this.scraped_html;
    }

    async saveCache(cache_filepath : string, cache_data : string) : Promise<boolean> {
        if (!cache_filepath && this.cache_filepath) { cache_filepath = this.cache_filepath; }
        if (!cache_filepath) throw exception('Scraper.saveCache : Invalid cache_filepath');

        try {
            await writeFile(cache_filepath, this.scraped_html.value);
        } catch (err) {
            throw err;
        }

        return true;
    }
}



module.exports = Scraper;
export default Scraper;