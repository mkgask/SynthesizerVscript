import '#/String.extensions';

import { Cache } from "#/Cache/Cache";
import { access, readFile, writeFile, unlink } from 'fs/promises';
import { constants } from 'fs';



let testCaseId : string = '';

const reporter = {
    // 各testが開始されるタイミングで呼び出される
    specStarted(result: any) {
        testCaseId = result.id
    }
}

jasmine.getEnv().addReporter(reporter)



const test_cachename : string = 'test';
const test_cachedata : string = 'testdata';

const utf8 : BufferEncoding = 'utf8';



describe('Cache', (): void => {
    test('正常系テスト：インスタンス生成テスト', async (): Promise<void> => {
        const cache = new Cache('');
        await expect(typeof cache).toBe('object');
        await expect(cache.constructor.name).toBe('Cache');
    });

    test('正常系テスト：インスタンス生成時のファイルパス生成テスト', async (): Promise<void> => {
        const cache2 = new Cache(test_cachename);
        await expect(cache2.cache_filepath).toBe('./dst/' + test_cachename);
    });

    test('異常系テスト：インスタンス生成時に空のファイル名を渡すとパス生成しない', async (): Promise<void> => {
        const cache1 = new Cache('');
        await expect(cache1.cache_filepath).toBe('');
    });

    test('正常系テスト：resetメソッドによるファイルパス生成テスト', async (): Promise<void> => {
        const cache = new Cache('');
        cache.reset(test_cachename);
        await expect(cache.cache_filepath).toBe('./dst/' + test_cachename);
    });

    test('異常系テスト：resetメソッドに空のファイル名を渡すとパス生成しない', async (): Promise<void> => {
        const cache = new Cache('');
        cache.reset('');
        await expect(cache.cache_filepath).toBe('');
    });

    test('正常系テスト：loadメソッドによるキャッシュファイル読み込みテスト', async (): Promise<void> => {
        const testcase_cachename = test_cachename + testCaseId;
        const test_cachepath  = './dst/' + testcase_cachename;
        await writeFile(test_cachepath, test_cachedata);
        const test_loaddata = await readFile(test_cachepath, utf8);
        await expect(test_loaddata).toBe(test_cachedata);

        const cache = new Cache('');
        const loaddata = await cache.load(testcase_cachename);
        await expect(loaddata).toBe(test_cachedata);

        // 後片付け
        await unlink(test_cachepath);
    });

    test('異常系テスト：loadメソッドでキャッシュファイルが無い時例外エラーが出る', async (): Promise<void> => {
        const testcase_cachename = test_cachename + testCaseId;
        const test_cachepath  = './dst/' + testcase_cachename;
        // await unlink(test_cachepath);    // そもそも作ってないので不要

        try {
            await access(test_cachepath, constants.R_OK);
        } catch (err) {
            expect(err.toString()).toBe("Error: ENOENT: no such file or directory, access '" + test_cachepath + "'");
        }

        const cache = new Cache('');

        try {
            await cache.load(testcase_cachename);
        } catch (err) {
            expect(err.toString()).toBe("Error: ENOENT: no such file or directory, access '" + test_cachepath + "'");
        }
    });

    test('正常系テスト：saveメソッドによるキャッシュファイル書き込みテスト', async (): Promise<void> => {
        const testcase_cachename = test_cachename + testCaseId;
        const test_cachepath  = './dst/' + testcase_cachename;
        // await unlink(test_cachepath);    // そもそも作ってないので不要

        try {
            await access(test_cachepath, constants.R_OK);
        } catch (err) {
            expect(err.toString()).toBe("Error: ENOENT: no such file or directory, access '" + test_cachepath + "'");
        }

        const cache = new Cache('');
        await cache.save(test_cachedata, testcase_cachename);
        const readdata = await readFile(test_cachepath, utf8);
        expect(readdata).toBe(test_cachedata);
    });

    test('異常系テスト：saveメソッドでキャッシュファイルがあったら内容書き換え', async (): Promise<void> => {
        const testcase_cachename = test_cachename + testCaseId;
        const test_cachepath  = './dst/' + testcase_cachename;
        await writeFile(test_cachepath, test_cachedata + test_cachedata);
        const double_testdata = await readFile(test_cachepath, utf8);
        expect(double_testdata).toBe(test_cachedata + test_cachedata);

        const cache = new Cache('');
        await cache.save(testcase_cachename, test_cachedata);
        const readdata = await readFile(test_cachepath, utf8);
        expect(readdata).toBe(test_cachedata + test_cachedata);

        // 後片付け
        await unlink(test_cachepath);
    });

    test('正常系テスト：createPathメソッドテスト', (): void => {
        const cache = new Cache('');

        // ファイル名を渡さないと空文字列
        expect(cache.createPath('')).toBe('');

        // ファイル名を1つ渡すとそのまま返ってくる
        expect(cache.createPath(test_cachename)).toBe(test_cachename);
        expect(cache.createPath(test_cachedata)).toBe(test_cachedata);

        // ファイル名を2つ渡すと2つ結合
        expect(cache.createPath(test_cachename, test_cachedata)).toBe(test_cachename + '/' + test_cachedata);
        expect(cache.createPath(test_cachedata, test_cachename)).toBe(test_cachedata + '/' + test_cachename);

        // ファイル名を3つ渡すと3つ結合
        expect(cache.createPath(test_cachename, test_cachedata, test_cachename)).toBe(test_cachename + '/' + test_cachedata + '/' + test_cachename);
        expect(cache.createPath(test_cachename, test_cachename, test_cachedata)).toBe(test_cachename + '/' + test_cachename + '/' + test_cachedata);
    });
});
