import '#/String.extensions';

import { Scraper } from "#/Scrape/Scraper";
import * as fs from 'fs/promises';
//import { access, readFile, writeFile, unlink } from 'fs/promises';
import { constants } from 'fs';
import { ScrapedData } from '#/Scrape/ScrapedData';

jest.mock('fs');

let testCaseId : string = '';

const reporter = {
    // 各testが開始されるタイミングで呼び出される
    specStarted(result: any) {
        testCaseId = result.id
    }
}

jasmine.getEnv().addReporter(reporter)



const test_cachename : string = 'scrapeTest';
const test_cachedata : string = 'scrapeTestData';

const utf8 : BufferEncoding = 'utf8';



describe('Scraper', (): void => {
    test('正常系テスト：インスタンス生成テスト', (): void => {
        const scraper = new Scraper();
        expect(typeof scraper).toBe('object');
        expect(scraper.constructor.name).toBe('Scraper');
    });

    test('正常系テスト：scrapeメソッドによるスクレイピングテスト', async (): Promise<void> => {
        // スクレイピング結果のキャッシュファイルはもう持ってて、
        // 実際にスクレイピング何度もしてしまうのは迷惑になるのでキャッシュテストのみ
        const testcase_cachename = test_cachename + testCaseId;
        const test_cachepath  = './dst/' + testcase_cachename;
        await fs.writeFile(test_cachepath, test_cachedata);
        const test_loaddata = await fs.readFile(test_cachepath, utf8);
        expect(test_loaddata).toBe(test_cachedata);

        const scraper = new Scraper();
        const loaddata = await scraper.scrape();
        expect(typeof loaddata).toBe('object');
        expect(loaddata.constructor.name).toBe('ScrapedData');

        // 後片付け
        await fs.unlink(test_cachepath);
    });

    test('正常系テスト：loadCacheメソッドによるキャッシュファイル読み込みテスト', async (): Promise<void> => {
        const testcase_cachename = 'scraped.html';
        const test_cachepath  = './dst/' + testcase_cachename;
        const scraped_value = await fs.readFile(test_cachepath, utf8);

        const scraper = new Scraper();
        const loaddata = await scraper.loadCache(testcase_cachename);
        expect(typeof loaddata).toBe('object');
        expect(loaddata.constructor.name).toBe('ScrapedData');
        expect(loaddata.value).toBe(scraped_value);
    });

    test('異常系テスト：loadCacheメソッドでキャッシュファイルが無い時例外エラーが出る', async (): Promise<void> => {
        const testcase_cachename = test_cachename + testCaseId;
        const test_cachepath  = './dst/' + testcase_cachename;
        // await unlink(test_cachepath);    // そもそも作ってないので不要

        try {
            await fs.access(test_cachepath, constants.R_OK);
        } catch (err) {
            expect(err.toString()).toBe("Error: ENOENT: no such file or directory, access '" + test_cachepath + "'");
        }

        const scraper = new Scraper();

        try {
            await scraper.loadCache(testcase_cachename);
        } catch (err) {
            expect(err.toString()).toBe("Error: ENOENT: no such file or directory, access '" + test_cachepath + "'");
        }
    });

    test('正常系テスト：saveCacheメソッドによるキャッシュファイル書き込みテスト', async (): Promise<void> => {
        const testcase_cachename = test_cachename + testCaseId;
        const test_cachepath  = './dst/' + testcase_cachename;
        // await unlink(test_cachepath);    // そもそも作ってないので不要

        try {
            await fs.access(test_cachepath, constants.R_OK);
        } catch (err) {
            expect(err.toString()).toBe("Error: ENOENT: no such file or directory, access '" + test_cachepath + "'");
        }

        const scraper = new Scraper();
        await scraper.saveCache(testcase_cachename, test_cachedata);
        const readdata = await fs.readFile(test_cachepath, utf8);
        expect(readdata).toBe(test_cachedata);
    });

    test('異常系テスト：saveCacheメソッドでキャッシュファイルがあったら内容書き換え', async (): Promise<void> => {
        const testcase_cachename = test_cachename + testCaseId;
        const test_cachepath  = './dst/' + testcase_cachename;
        await fs.writeFile(test_cachepath, test_cachedata);
        const double_testdata = await fs.readFile(test_cachepath, utf8);
        expect(double_testdata).toBe(test_cachedata);

        const scraper = new Scraper();
        await scraper.saveCache(testcase_cachename, test_cachedata + test_cachedata);
        const readdata = await fs.readFile(test_cachepath, utf8);
        expect(readdata).toBe(test_cachedata + test_cachedata);

        // 後片付け
        await fs.unlink(test_cachepath);
    });

});
