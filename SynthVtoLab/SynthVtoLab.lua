


-- # Properties

local vowel_table_jp = {
    ["あ"] = "a", ["い"] = "i", ["う"] = "u", ["え"] = "e", ["お"] = "o",
    ["か"] = "a", ["き"] = "i", ["く"] = "u", ["け"] = "e", ["こ"] = "o",
    ["さ"] = "a", ["し"] = "i", ["す"] = "u", ["せ"] = "e", ["そ"] = "o",
    ["た"] = "a", ["ち"] = "i", ["つ"] = "u", ["て"] = "e", ["と"] = "o",
    ["な"] = "a", ["に"] = "i", ["ぬ"] = "u", ["ね"] = "e", ["の"] = "o",
    ["は"] = "a", ["ひ"] = "i", ["ふ"] = "u", ["へ"] = "e", ["ほ"] = "o",
    ["ま"] = "a", ["み"] = "i", ["む"] = "u", ["め"] = "e", ["も"] = "o",
    ["や"] = "a",               ["ゆ"] = "u",               ["よ"] = "o",
    ["ら"] = "a", ["り"] = "i", ["る"] = "u", ["れ"] = "e", ["ろ"] = "o",
    ["わ"] = "a",               ["を"] = "o",               ["ん"] = "n",
    ["が"] = "a", ["ぎ"] = "i", ["ぐ"] = "u", ["げ"] = "e", ["ご"] = "o",
    ["ざ"] = "a", ["じ"] = "i", ["ず"] = "u", ["ぜ"] = "e", ["ぞ"] = "o",
    ["だ"] = "a", ["ぢ"] = "i", ["づ"] = "u", ["で"] = "e", ["ど"] = "o",
    ["ば"] = "a", ["び"] = "i", ["ぶ"] = "u", ["べ"] = "e", ["ぼ"] = "o",
    ["ぱ"] = "a", ["ぴ"] = "i", ["ぷ"] = "u", ["ぺ"] = "e", ["ぽ"] = "o",
    ["きゃ"] = "a",               ["きゅ"] = "u",               ["きょ"] = "o",
    ["しゃ"] = "a",               ["しゅ"] = "u",               ["しょ"] = "o",
    ["ちゃ"] = "a",               ["ちゅ"] = "u",               ["ちょ"] = "o",
    ["にゃ"] = "a",               ["にゅ"] = "u",               ["にょ"] = "o",
    ["ひゃ"] = "a",               ["ひゅ"] = "u",               ["ひょ"] = "o",
    ["みゃ"] = "a",               ["みゅ"] = "u",               ["みょ"] = "o",
    ["りゃ"] = "a",               ["りゅ"] = "u",               ["りょ"] = "o",
    ["ぎゃ"] = "a",               ["ぎゅ"] = "u",               ["ぎょ"] = "o",
    ["じゃ"] = "a",               ["じゅ"] = "u",               ["じょ"] = "o",
    ["びゃ"] = "a",               ["びゅ"] = "u",               ["びょ"] = "o",
    ["ぴゃ"] = "a",               ["ぴゅ"] = "u",               ["ぴょ"] = "o",
    ["ア"] = "a", ["イ"] = "i", ["ウ"] = "u", ["エ"] = "e", ["オ"] = "o",
    ["カ"] = "a", ["キ"] = "i", ["ク"] = "u", ["ケ"] = "e", ["コ"] = "o",
    ["サ"] = "a", ["シ"] = "i", ["ス"] = "u", ["セ"] = "e", ["ソ"] = "o",
    ["タ"] = "a", ["チ"] = "i", ["ツ"] = "u", ["テ"] = "e", ["ト"] = "o",
    ["ナ"] = "a", ["ニ"] = "i", ["ヌ"] = "u", ["ネ"] = "e", ["ノ"] = "o",
    ["ハ"] = "a", ["ヒ"] = "i", ["フ"] = "u", ["ヘ"] = "e", ["ホ"] = "o",
    ["マ"] = "a", ["ミ"] = "i", ["ム"] = "u", ["メ"] = "e", ["モ"] = "o",
    ["ヤ"] = "a",               ["ユ"] = "u",               ["ヨ"] = "o",
    ["ラ"] = "a", ["リ"] = "i", ["ル"] = "u", ["レ"] = "e", ["ロ"] = "o",
    ["ワ"] = "a",               ["ヲ"] = "o",               ["ン"] = "n",
    ["ガ"] = "a", ["ギ"] = "i", ["グ"] = "u", ["ゲ"] = "e", ["ゴ"] = "o",
    ["ザ"] = "a", ["ジ"] = "i", ["ズ"] = "u", ["ゼ"] = "e", ["ゾ"] = "o",
    ["ダ"] = "a", ["ヂ"] = "i", ["ヅ"] = "u", ["デ"] = "e", ["ド"] = "o",
    ["バ"] = "a", ["ビ"] = "i", ["ブ"] = "u", ["ベ"] = "e", ["ボ"] = "o",
    ["パ"] = "a", ["ピ"] = "i", ["プ"] = "u", ["ペ"] = "e", ["ポ"] = "o",
    ["キャ"] = "a",               ["キュ"] = "u",               ["キョ"] = "o",
    ["シャ"] = "a",               ["シュ"] = "u",               ["ショ"] = "o",
    ["チャ"] = "a",               ["チュ"] = "u",               ["チョ"] = "o",
    ["ニャ"] = "a",               ["ニュ"] = "u",               ["ニョ"] = "o",
    ["ヒャ"] = "a",               ["ヒュ"] = "u",               ["ヒョ"] = "o",
    ["ミャ"] = "a",               ["ミュ"] = "u",               ["ミョ"] = "o",
    ["リャ"] = "a",               ["リュ"] = "u",               ["リョ"] = "o",
    ["ギャ"] = "a",               ["ギュ"] = "u",               ["ギョ"] = "o",
    ["ジャ"] = "a",               ["ジュ"] = "u",               ["ジョ"] = "o",
    ["ビャ"] = "a",               ["ビュ"] = "u",               ["ビョ"] = "o",
    ["ピャ"] = "a",               ["ピュ"] = "u",               ["ピョ"] = "o",
    ["うぁ"] = 'a',               ["ウァ"] = "u",
    ["てぃ"] = "i",               ["ティ"] = "i",
}

local vowel_table_ch = {
    -- please pull request
}

local vowel_table_en = {
    -- please pull request
}


--- get vowel from definition list
--- @param key string
--- @return string
function vowelTable(key)
    local vowel = vowel_table_jp[key]
    if not vowel then vowel = vowel_table_ch[key] end
    if not vowel then vowel = vowel_table_en[key] end
    return vowel
end


-- # Foundation


--- Get Translate text
--- return translate text to Synthesizer V system
--- @param langCode string
--- @return table    -- translate text array or blank array
function getTranslations(langCode)
    if langCode == "ja-jp" then
        return {
            { "Output *.lab file for PSDToolkit", "PSDToolkit用の*.labファイルを出力" },
            { "Output", "出力" },

            { "Select track", "出力トラック選択" },
            { "track", "トラック" },

            { "test text", "テストテキスト" },
            { "test text 2", "テストテキスト 2" }
        }
    end

    -- please pull request ch language

    return {}
end


--- Define script information
--- @return table
function getClientInfo()
    return {
        name = SV: T("Output *.lab file for PSDToolkit"),
        category = SV: T("Output"),
        author = "@mkgask",
        versionNumber = 0.1,
        minEditorVersion = 65540
    }
end


--- Bootstrap
--- @return nil
function main()
    -- OkCancelDialog first display. Track select dialog with input output filename.
    -- Convert notes consonant to lab file
    -- finish

    local synth_v_to_lab = SynthVtoLab: new()
    local log_path = synth_v_to_lab.log_path
    SV: showMessageBox("main()", "log_path : " .. log_path)
    SV: showMessageBox("main()", "synth_v_to_lab.project_path : " .. synth_v_to_lab.project_path)
    SV: showMessageBox("main()", "UTF8toSJIS_table_path : " .. UTF8toSJIS_table_path)

    local UTF8toSJIS_table = io.open(UTF8toSJIS_table_path, "rb")
    SV: showMessageBox("UTF8toSJIS:UTF8_to_SJIS_str_cnv()", "UTF8toSJIS_table == nil : " .. tostring(UTF8toSJIS_table == nil))

    local log_path_sjis = UTF8toSJIS:UTF8_to_SJIS_str_cnv(UTF8toSJIS_table, log_path)
    local logfile = io.open(log_path_sjis, "w")
    logfile: write("log_path : " .. log_path)
    logfile: close()



    if not (0 < #synth_v_to_lab.project_path) then
        SV: showMessageBox("!", "プロジェクトを開いてください。")
        return SV: finish()
    end

    if not (0 < #synth_v_to_lab.tracks) then
        SV: showMessageBox("!", "トラックを作成してください。")
        return SV: finish()
    end

    for index, track in ipairs(synth_v_to_lab.tracks) do
        SV: showMessageBox("main()", "track name : " .. track: getName())
    end

    local current_track_order = getCurrentTrackDisplayOrder(synth_v_to_lab.main_editor)
    SV: showMessageBox("main()", "current track number : " .. tostring(current_track_order))

    local result_start_dialog = showStartDialog(synth_v_to_lab.tracks, current_track_order)

    if result_start_dialog.status == false then
        do return end
    end

    local consonant_list = getTrackConsonant()
    local lablist = convertTrackConsonantToLabList(consonant_list)
    output(lablist)

    local result_end_dialog showEndDialog(output_file)

    if result_end_dialog.status == false then
        do return end
    end

    SV: finish()
end



-- # Modules

SynthVtoLab = {
    -- Foundation
    new = function (self)
    
        local project = SV: getProject()
        local main_editor = SV: getMainEditor()
        local tracks = self.getTracks(project)
        local current_track = self.getCurrentTrackDisplayOrder(main_editor)

        local project_path = project: getFileName()
        local project_path_windows = self.changePathToWindows(project_path)
        local lab_path = project_path and self.changePathExt(project_path_windows, 'lab') or ''
        local log_path = project_path and self.changePathExt(project_path_windows, 'log') or ''

        -- Properties
        local obj = {
            project = project,
            main_editor = main_editor,
            tracks = tracks,
            current_track = current_track,
            project_path = project_path_windows,
            lab_path = lab_path,
            log_path = log_path
        }

        return setmetatable(obj, { __index = self })
    end,

    -- Modules track
    getTracks =  function (project)
        local track_num = project: getNumTracks()
        local tracks = {}

        for index = 1, track_num do
            tracks[index] = project: getTrack(index)
        end

        return tracks
    end,

    getCurrentTrackDisplayOrder = function (main_editor)
        return main_editor: getCurrentTrack(): getDisplayOrder()
    end,

    --path
    changePathExt = function (path, ext)
        local path = string.gsub(path, '%.svp$', '.' .. ext)
        return path
    end,

    changePathToWindows = function (path)
        local path = string.gsub(path, '\\', '/')
        return path
    end
}


--- Show start dialog to OkCandelDialog
--- Track select dialog with input output filename.
--- @param tracks table
--- @param current_track_order any
--- @return any    -- return check result, ok or cancel
function showStartDialog(tracks, current_track_order)
    local param = getStartDialogParameter(tracks, current_track_order)
    return SV: showCustomDialog(param)
end


--- Show end dialog to OkCandelDialog
--- show process end message
--- @return any
function showEndDialog()
    return SV: showMessageBox("end title", "end body")
end



-- # Utilities


function getStartDialogParameter(tracks, current_track_order)
    local choices = {}
    local current_number = 0

    for index = 1, tracks.length do
        choices[index] = "track" + tostring(index)

        if tracks[index].getDisplayOrder() == current_track_order then
            current_number = index
        end
    end

    local param = {
        title = SV.T("Select track"),
        message = "",
        buttons = "OkCancel",

        widgets = {
            {
                name = "track",
                type = "ComboBox",
                label = SV.T("track"),
                default = current_number,
                choices = choices
            }
        }
    }

    return param
end



-- # Modules UTF8toSJIS

--- https://github.com/AoiSaya/FlashAir_UTF8toSJIS/

UTF8toSJIS_table_path = "libs/Utf8Sjis.tbl"

--[[
    UTF8toSJIS.lua - for FlashAir
    rev. 0.01
    Based on Mgo-tec/SD_UTF8toSJIS version 1.21
    This is a library for converting from UTF-8 code string to Shift_JIS code string.
    In advance, you need to upload a conversion table file Utf8Sjis.tbl to FlashAir.
The MIT License (MIT)
Copyright (c) 2019 AoiSaya
Copyright (c) 2016 Mgo-tec
Blog URL ---> https://www.mgo-tec.com
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--]]

UTF8toSJIS = {
    cnvtbl={
        [0xE2] = {0xE28090, 0x01EEC}; --文字"‐" UTF8コード E28090～、S_jisコード815D
        [0xE3] = {0xE38080, 0x09DCC}; --スペース UTF8コード E38080～、S_jisコード8140
        [0xE4] = {0xE4B880, 0x11CCC}; --文字"一" UTF8コード E4B880～、S_jisコード88EA
        [0xE5] = {0xE58085, 0x12BCC}; --文字"倅" UTF8コード E58085～、S_jisコード98E4
        [0xE6] = {0xE6808E, 0x1AAC2}; --文字"怎" UTF8コード E6808E～、S_jisコード9C83
        [0xE7] = {0xE78081, 0x229A6}; --文字"瀁" UTF8コード E78081～、S_jisコードE066
        [0xE8] = {0xE88080, 0x2A8A4}; --文字"耀" UTF8コード E88080～、S_jisコード9773
        [0xE9] = {0xE98080, 0x327A4}; --文字"退" UTF8コード E98080～、S_jisコード91DE
    };
}

--- String型文字列をShift_JISコードに変換
--- @return string strSJIS
function UTF8toSJIS:UTF8_to_SJIS_str_cnv(f2, strUTF8)
    local sj_cnt = 1
    local fnt_cnt = 1
    local sp_addres = 0x9DCC --スペース
    local SJ1, SJ2
    local sjis_byte = {}
    local str_length = strUTF8: len()
    SV: showMessageBox("UTF8toSJIS:UTF8_to_SJIS_str_cnv()", "str_length : " .. tostring(str_length))
    SV: showMessageBox("UTF8toSJIS:UTF8_to_SJIS_str_cnv()", "f2 == nil : " .. tostring(f2 == nil))

--    local UTF8SJIS_file = "Utf8Sjis.tbl"
--    local f2 = io.open(UTF8SJIS_file, "r")

    if f2 == nil then
        return nil
    end

    while fnt_cnt <= str_length do
        local utf8_byte = strUTF8: byte(fnt_cnt)

        if utf8_byte >= 0xC2 and utf8_byte <= 0xD1 then    --2バイト文字
            sp_addres = self: UTF8_To_SJIS_code_cnv(strUTF8:byte(fnt_cnt,fnt_cnt+1))
            SJ1, SJ2 = self: SD_Flash_UTF8SJIS_Table_Read(f2, sp_addres)
            sjis_byte[sj_cnt] = SJ1
            sjis_byte[sj_cnt+1] = SJ2
            sj_cnt = sj_cnt + 2
            fnt_cnt = fnt_cnt + 2
        elseif utf8_byte >= 0xE2 and utf8_byte <= 0xEF then
            sp_addres = self: UTF8_To_SJIS_code_cnv(strUTF8:byte(fnt_cnt,fnt_cnt+2))
            SJ1, SJ2 = self: SD_Flash_UTF8SJIS_Table_Read(f2, sp_addres)

            if SJ1 >= 0xA1 and SJ1 <= 0xDF then    --Shift_JISで半角カナコードが返ってきた場合の対処
                sjis_byte[sj_cnt] = SJ1
                sj_cnt = sj_cnt + 1
            else
                sjis_byte[sj_cnt] = SJ1
                sjis_byte[sj_cnt+1] = SJ2
                sj_cnt = sj_cnt + 2
            end

            fnt_cnt = fnt_cnt + 3
        elseif utf8_byte >= 0x20 and utf8_byte <= 0x7E then
            sjis_byte[sj_cnt] = utf8_byte
            sj_cnt = sj_cnt + 1
            fnt_cnt = fnt_cnt + 1
        else    --その他は全て半角スペースとする。
            sjis_byte[sj_cnt] = 0x20
            sj_cnt = sj_cnt + 1
            fnt_cnt = fnt_cnt + 1
        end
        -- sleep(0)
    end

    local r = string.char(table.unpack(sjis_byte)), sj_cnt-1

    SV: showMessageBox("UTF8toSJIS:UTF8_to_SJIS_str_cnv()", "r : " .. tostring(r: len()))

    return r
end

--- UTF-8コードをSD内の変換テーブルを読み出してShift-JISコードに
--- @return number SD_addrs
function UTF8toSJIS:UTF8_To_SJIS_code_cnv(utf8_1, utf8_2, utf8_3)
    local SD_addrs = 0x9DCC --スペース

    if utf8_1 >= 0xC2 and utf8_1 <= 0xD1 then
        -- 0xB0からS_JISコード実データ。0x00-0xAFまではライセンス文ヘッダ。
        SD_addrs = ((utf8_1 * 256 + utf8_2) - 0xC2A2) * 2 + 0xB0    -- 文字"¢" UTF8コード C2A2～、S_jisコード8191
    elseif utf8_2>=0x80 then
        local UTF8uint = (utf8_1 * 65536) + (utf8_2 * 256) + utf8_3

        local tbl = self.cnvtbl[utf8_1]

        if tbl then
            SD_addrs = (UTF8uint-tbl[1]) * 2 + tbl[2]
        elseif utf8_1 >= 0xEF and utf8_2 >= 0xBC then
            SD_addrs = (UTF8uint - 0xEFBC81) * 2 + 0x3A6A4    -- 文字"！" UTF8コード EFBC81～、S_jisコード8149

            if utf8_1 == 0xEF and utf8_2 == 0xBD and utf8_3 == 0x9E then
                SD_addrs = 0x3A8DE    -- "～" UTF8コード EFBD9E、S_jisコード8160
            end
        end
    end

    return SD_addrs
end

--- @return any sj1, any sj2
function UTF8toSJIS:SD_Flash_UTF8SJIS_Table_Read(ff, addrs)
    if ff then
        ff: seek("set", addrs)
        return (ff: read(2)): byte(1,2)
    else
        return " UTF8toSjis file has not been uploaded to the flash in SD file system"
    end
end


