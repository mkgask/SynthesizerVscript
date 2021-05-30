export {};

declare global {
    interface String {
        /** 指定の文字数で文字列を切り捨て */
        truncate(length : number, word? : string, removes? : string | RegExp ) : String;
        truncate_remove_blank(length : number, word? : string ) : String;
    }
}

String.prototype.truncate =
function (length : number, word? : string, removes? : string | RegExp ) : String {
    if (this.length <= length) return this;
    if (!word) { word = '...'; }

    let substr = this.substr(0, length);

    if (removes) {
        substr = substr.replace(removes, '');
    }

    return substr + word;
};

String.prototype.truncate_remove_blank =
function (length : number, word? : string ) : String {
    return this.truncate(length, word, /[\s\r\n\t]+/mg);
};
