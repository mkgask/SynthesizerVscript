import { access, readFile, writeFile } from 'fs/promises';
import { constants } from 'fs';
import { exception } from 'console';



class Cache
{
    /*  Properties
    */

    static readonly cache_basepath : string ='./dst';

    cache_filepath : string = '';
    cache_data : string = '';



    /*  Foundation
    */

    constructor(cache_filename : string)
    {
        this.reset(cache_filename);
    }

    reset(cache_filename : string) : string
    {
        if (cache_filename) { this.cache_filepath = this.createPath(Cache.cache_basepath, cache_filename); }
        return this.cache_filepath;
    }



    /*  Modules load
    */

    async load(cache_filename? : string) : Promise<string>
    {
        let cache_filepath = this.cache_filepath;
        if (!cache_filepath && cache_filename) { cache_filepath = this.createPath(Cache.cache_basepath, cache_filename); }
        if (!cache_filepath) throw exception('Cache.load : Invalid cache_filepath');

        try {
            await access(cache_filepath, constants.R_OK);
        } catch (err) {
            throw err;
        }

        try {
            this.cache_data = (await readFile(cache_filepath)).toString();
        } catch (err) {
            throw err;
        }

        return this.cache_data;
    }



    /*  Modules save
    */

    async save(cache_data : string, cache_filename? : string) : Promise<boolean>
    {
        let cache_filepath = this.cache_filepath;
        if (!cache_filepath && cache_filename) { cache_filepath = this.createPath(Cache.cache_basepath, cache_filename); }
        if (!cache_filepath) throw exception('Cache.save : Invalid cache_filepath');

        try {
            await writeFile(cache_filepath, cache_data);
        } catch (err) {
            throw err;
        }

        return true;
    }



    /*  Utilities
    */

    createPath(...args : (string | undefined)[]) : string {
        let tmp : Array<string> = [];
        let index : number = 0;
        let first_slash : string = '';

        for (let arg in args) {
            index += 1;

            if (!arg) { continue; }

            if (index === 1 && arg.substr(0, 1) === '/') { first_slash = '/'; }
            tmp.push(arg.replace(/^\/?.*\/?$/, ''));
        }

        return first_slash + tmp.join('/');
    }

}



export { Cache };