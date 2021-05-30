import { ScrapedData } from "#/Scrape/ScrapedData";
import { AnalyzedData } from "./AnalyzedData";



interface IAnalyzer {
    cache_filepath : string;
    analyzed_data : AnalyzedData;

    analyze(html : ScrapedData) : AnalyzedData;

    loadCache(filepath : string) : Promise<ScrapedData>;
    saveCache(filepath : string, cache_data : string) : Promise<boolean>;
}



export { IAnalyzer };