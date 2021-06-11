import { Cache } from '#/Cache/Cache';

import { IAnalyzeCallback } from './IAnalyzeCallback';
import { ScrapedData } from "#/Scrape/ScrapedData";
import { AnalyzedData } from "./AnalyzedData";



interface IAnalyzer
{
    cache_filename : string;
    analyzed_data : AnalyzedData;
    cache : Cache;

    analyze(html : ScrapedData, cache_filename : string, callback : IAnalyzeCallback) : Promise<AnalyzedData>;

    loadCache(filepath : string) : Promise<AnalyzedData>;
    saveCache(filepath : string, cache_data : string) : Promise<boolean>;
}



export { IAnalyzer };