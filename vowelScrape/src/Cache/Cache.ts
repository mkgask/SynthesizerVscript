import { access, readFile, writeFile } from 'fs/promises';
import { constants } from 'fs';

const utf8 : BufferEncoding = 'utf8';



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
        if (cache_filename) { cache_filepath = this.createPath(Cache.cache_basepath, cache_filename); }
        if (!cache_filepath) throw new Error('Cache.load : Invalid cache_filepath');

        await access(cache_filepath, constants.R_OK);
        this.cache_data = (await readFile(cache_filepath, utf8)).toString();
        return this.cache_data;
    }



    /*  Modules save
    */

    async save(cache_data : string, cache_filename? : string) : Promise<boolean>
    {
        let cache_filepath = this.cache_filepath;
        if (cache_filename) { cache_filepath = this.createPath(Cache.cache_basepath, cache_filename); }
        if (!cache_filepath) throw new Error('Cache.save : Invalid cache_filepath');

        await writeFile(cache_filepath, cache_data);
        return true;
    }



    /*  Utilities
    */

    createPath(...args : (string | undefined)[]) : string
    {
        let tmp : Array<string> = [];
        let index : number = 0;
        let first_slash : string = '';

        for (let key in args) {
            index += 1;

            const arg = args[key]
            if (typeof arg === 'undefined') continue;

            if (arg.length === 0) { continue; }

            if (index === 1 && arg.substr(0, 1) === '/') { first_slash = '/'; }
            tmp.push(arg.replace(/^\/?(.*)\/?$/, '$1'));
        }

        return first_slash + tmp.join('/');
    }

}



export { Cache };