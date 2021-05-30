interface ICache
{
    cache_filepath : string;

    reset(cache_filepath : string) : string;

    load(cache_filepath? : string) : string;
    save(cache_data : string, cache_filepath? : string) : boolean;
}