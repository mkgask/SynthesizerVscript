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



class Controller {
    async exec(scraper : IScraper, analyzer : IAnalyzer) {

        const scraped : ScrapedData = await scraper.scrape();
        console.log('Controller.exec : scraped : ' + scraped.value.truncate_remove_blank(100))

        const analyzed : AnalyzedData = await analyzer.analyze(scraped);
        console.log('Controller.exec : analyzed : ' + analyzed.value.truncate_remove_blank(100))

    }
}



const scraper = new Scraper();
const analyzer = new Analyzer();
const controller = new Controller();
controller.exec(scraper, analyzer)
