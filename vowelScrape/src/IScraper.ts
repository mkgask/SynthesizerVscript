import ScrapedData from './ScrapedData';



interface IScraper {
    url : string;
    cache_filepath : string;
    scraped_html : ScrapedData;

    scrape(url?: string) : Promise<ScrapedData>;

    loadCache(filepath : string) : Promise<ScrapedData>;
    saveCache(filepath : string, cache_data : string) : boolean;
}



export default IScraper;