import { Cache } from '#/Cache/Cache';

import { ScrapedData } from './ScrapedData';



interface IScraper
{
    url : string;
    cache_filename : string;
    scraped_html : ScrapedData;
    cache : Cache;

    scrape(url?: string) : Promise<ScrapedData>;

    loadCache(filepath : string) : Promise<ScrapedData>;
    saveCache(filepath : string, cache_data : string) : Promise<boolean>;
}



export { IScraper };