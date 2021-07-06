


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

            { "Output settings track", "出力設定" },
            { "It will be saved in the same directory as the project file.", "プロジェクトファイルと同じディレクトリに保存されます" },
            { "Select track", "出力するトラックを選択" },
            { "Output log together", "ログも一緒に出力する" },

            { "Failed  open logfile", "ログファイルが開けませんでした" }
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

    local synthv_to_lab = SynthVtoLab: new()

    if not synthv_to_lab: precheck() then
        return SV: finish()
    end

    local log = Log: new(synthv_to_lab.log_path)
    log: w("synthv_to_lab.project_path : " .. synthv_to_lab.project_path)

    for index, track in ipairs(synthv_to_lab.tracks) do
        log: w("track" .. index .. " : " .. track: getName())
    end

    log: w("current track number : " .. tostring(synthv_to_lab.current_track))

    local output_dialog = OutputSettingsDialog: new(synthv_to_lab.tracks, synthv_to_lab.current_track)
    local output_dialog_result = output_dialog: show()

    if not output_dialog_result.status then
        return SV: finish()
    end

    if (output_dialog_result.answers.logsave) then
        log: w("log start")
        log: start()
    else
        log: disable()
    end

--[[
    local result_start_dialog = showStartDialog(synthv_to_lab.tracks, synthv_to_lab.current_track)

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
]]

    log: close()
    SV: finish()
end



-- # Modules main

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
        local log_path = project_path and self.changePathExt(project_path_windows, 'synthv2lab.log') or ''

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

    precheck = function (self)
        if not (0 < #self.project_path) then
            SV: showMessageBox("!", "プロジェクトを開いてください。")
            return false
        end

        if not (0 < #self.tracks) then
            SV: showMessageBox("!", "トラックを作成してください。")
            return false
        end

        return true
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

    -- Modules path

    changePathExt = function (path, ext)
        local path = string.gsub(path, '%.svp$', '.' .. ext)
        return path
    end,

    changePathToWindows = function (path)
        local path = string.gsub(path, '\\', '/')
        return path
    end
}



-- # Modules log

Log = {

    -- Foundation

    new = function (self, log_path)
        local UTF8toSJIS_table = io.open(UTF8toSJIS_table_path, "rb")
        local log_path_sjis = log_path

        if UTF8toSJIS_table then
            log_path_sjis = UTF8toSJIS:UTF8_to_SJIS_str_cnv(UTF8toSJIS_table, log_path)
        end

        local obj = {
            log_path = log_path,
            log_path_sjis = log_path_sjis,
            log_start = false,
            pre_log = "",
            logfile = nil,
            enable = true
        }

        if not UTF8toSJIS_table then
            if SV: getHostInfo().languageCode == "ja-JP" then
                SV: showMessageBox("!", [[
日本語ファイルパスを扱うためのデータファイルが読み込まれていません

プロジェクトファイルのパスに日本語が含まれている場合、ログ出力を行うことができません

必要な場合はlibsフォルダをSynthesizer V実行ファイルのあるフォルダに設置してください
                ]])

                obj.enable = false
            end
        end

        return setmetatable(obj, { __index = self })
    end,

    start = function (self)
        self.log_start = true
        self.logfile = io.open(self.log_path_sjis, "w")

        if self.logfile == nil then
            SV: showMessageBox("!", SV: T("Failed open logfile : " .. self.log_path_sjis))
            return self.disable()
        end

        if (0 < #self.pre_log) then
            self.logfile: write(self.pre_log)
        end
    end,

    close = function (self)
        if not self.logfile == nil then
            self.logfile: close()
        end
    end,

    disable = function (self)
        self: close()

        self.log_path = ""
        self.log_path_sjis = ""
        self.log_start = false
        self.pre_log = ""
        self.logfile = nil
        self.enable = false
    end,

    -- Modules

    w = function (self, value)
        if not self.enable == true then
            return
        end

        if (self.log_start) then
            return self.logfile: write('[' .. self.t() .. '] ' .. tostring(value) .. "\n")
        end

        self.pre_log = self.pre_log .. '[' .. self.t() .. '] ' .. tostring(value) .. "\n";
    end,

    t = function (self)
        return os.date("%Y-%m-%d %H:%M:%S")
    end
}


-- # Modules output settings dialog

OutputSettingsDialog = {

    -- Foundation

    new = function (self, tracks, current_order)
        -- Properties
        local obj = {
            tracks = tracks,
            current_order = current_order
        }

        return setmetatable(obj, { __index = self })
    end,

    -- Modules

    show = function (self)
        local dialog_parameters = self: getParameters()
        return SV:showCustomDialog(dialog_parameters)
    end,

    getParameters = function (self)
        local choices = {}

        for index, track in ipairs(self.tracks) do
            table.insert(choices, index, "track" .. tostring(index) .. ' : ' .. track: getName())
        end

        local param = {
            title = SV: T("Output settings track"),
            message = SV: T("It will be saved in the same directory as the project file."),
            buttons = "OkCancel",

            widgets = {
                {
                    name = "track",
                    type = "ComboBox",
                    label = SV: T("Select track"),
                    default = self.current_order - 1,
                    choices = choices
                },

                {
                  name = "logsave",
                  type = "CheckBox",
                  text = SV: T("Output log together"),
                  default = false
                }
            }
        }
    
        return param
    end
}



--- Show end dialog to OkCandelDialog
--- show process end message
--- @return any
function showEndDialog()
    return SV: showMessageBox("end title", "end body")
end



-- # Utilities UTF8toSJIS

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


