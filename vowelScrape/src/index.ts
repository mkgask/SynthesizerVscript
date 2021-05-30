import './String.extensions';

import IScraper from './Scrape/IScraper';
import Scraper from './Scrape/Scraper';
import ScrapedData from './Scrape/ScrapedData';



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
    async exec(scraper : IScraper) {

        const scraped : ScrapedData = await scraper.scrape();
        console.log('Controller.exec : scraped : ' + scraped.value.truncate(100))

        // TODO

    }
}



const scraper = new Scraper();
const controller = new Controller();
controller.exec(scraper)
