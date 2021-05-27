export {};

declare global {
    interface String {
        /** 指定の文字数で文字列を切り捨て */
        truncate(length : number, word? : string ) : String;
    }
}

String.prototype.truncate =
function (length : number, word? : string ) : String {
    if (this.length <= length) return this;
    if (!word) { word = '...'; }
    return this.substr(0, length) + word;
};