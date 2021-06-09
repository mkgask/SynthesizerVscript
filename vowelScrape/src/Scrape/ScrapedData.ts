class ScrapedData
{
    private _value : string = '';

    get value() : string
    {
        return this._value;
    }

    set value(val : string)
    {
        this._value = val;
    }
}



export { ScrapedData };