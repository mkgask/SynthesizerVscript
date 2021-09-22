

-- # Utilities

function table.empty(self)
    for _, _ in ipairs(self) do
        return false
    end

    for _, _ in pairs(self) do
        return false
    end

    return true
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
            { "Output log together (The time required for output will increase considerably)", "ログも一緒に出力する（出力にかかる時間が結構増えます）" },

            { "all: all track", "all: 全トラック" },

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
        author = "@mkgask (twitter)",
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

    if not synthv_to_lab: preCheck() then
        return SV: finish()
    end

    Log: setPath(synthv_to_lab.log_path)
    synthv_to_lab: saveFirstLog()

    local output_dialog_result = synthv_to_lab: showOutputSettingsDialog()

    if not output_dialog_result.status then
        return SV: finish()
    end

    if output_dialog_result.answers.logsave then
        Log: start()
        synthv_to_lab: startLog()
    else
        Log: disable()
    end


    local select_track = output_dialog_result.answers.track
    local select_track_name = synthv_to_lab.output_dialog.choices[select_track]
    local track_name = string.gsub(select_track_name, '^%w+%s:%s', '')
    Log: w("main() : select track number : " .. Log: v(select_track))
    Log: w("main() : select track name : " .. Log: v(select_track_name))
    Log: w("main() : track name : " .. Log: v(track_name))

    -- 全トラックなら
    if select_track == 1 then
        local track_num = synthv_to_lab.project: getNumTracks()
        Log: w("main() : track num : " .. Log: v(track_num))

        -- tracksをループ
        for index = 1, track_num do
            Log: w("main() : track index : " .. Log: v(index))

            local track = synthv_to_lab.project: getTrack(index)
            Log: w("main() : track : " .. Log: v(track))

            local track_name = string.gsub(track: getName(), '^%w+%s:%s', '')
            Log: w("main() : processing track name : " .. Log: v(track_name))

            -- トラック別の出力ファイルパスを生成
            local save_path = Path: changeExt(synthv_to_lab.project_path, '-' .. track_name .. '.lab')
            Log: w("main() : save lab path : " .. save_path)
            -- トラック処理
            local lab_content = synthv_to_lab: craeteLabContent(index)
            Log: w("main() : lab content length : " .. Log: v(#lab_content))
            -- 出力ファイルパスを指定して内容を保存
            local result, error = synthv_to_lab: saveLab(save_path, lab_content)
            Log: w("main() : save result : " .. Log: v(result))
            Log: w("main() : save error : " .. Log: v(error))
        end

    -- そうでなければ
    else
        -- 出力ファイルパスを生成
        local save_path = Path: changeExt(synthv_to_lab.project_path, '-' .. track_name .. '.lab')
        Log: w("main() : save lab path : " .. save_path)
        -- トラック処理
        local lab_content = synthv_to_lab: craeteLabContent(select_track - 1)
        Log: w("main() : lab content length : " .. Log: v(#lab_content))
        -- 出力ファイルパスを指定して内容を保存
        local result, error = synthv_to_lab: saveLab(save_path, lab_content)
        Log: w("main() : save result : " .. Log: v(result))
        Log: w("main() : save error : " .. Log: v(error))
    end

    synthv_to_lab: closeLog()
    return SV: finish()
end



-- # Modules main

SynthVtoLab = {

    -- Foundation

    new = function (self)
        local project = SV: getProject()
        local main_editor = SV: getMainEditor()
        local tracks = SynthV: getTracks(project)
        local current_track = SynthV: getCurrentTrackDisplayOrder(main_editor)

        local project_path = project: getFileName()
        local project_path_windows = Path: changeToWindows(project_path)
        local lab_path = project_path and Path: changeExt(project_path_windows, '.lab') or ''
        local log_path = project_path and Path: changeExt(project_path_windows, '.synthv2lab.log') or ''

        -- Properties
        local obj = {
            project = project,
            main_editor = main_editor,
            tracks = tracks,
            current_track = current_track,
            project_path = project_path_windows,
            lab_path = lab_path,
            log_path = log_path,
            log = nil,
            output_dialog = nil
        }

        return setmetatable(obj, { __index = self })
    end,

    preCheck = function (self)
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

    showOutputSettingsDialog = function (self)
        self.output_dialog = OutputSettingsDialog: new(self.tracks, self.current_track)
        return self.output_dialog: show()
    end,

    -- Modules Lab

    craeteLabContent = function (self, track_number)
        local lab_content = {}

        local time_axis = self.project: getTimeAxis()

        local target_track = self.tracks[track_number]
        local note_groups_references = SynthV: getNoteGroupsWithReference(target_track)
        Log: w("synthv_to_lab.craeteLabContent() : self.tracks : " .. Log: v(self.tracks))
        Log: w("synthv_to_lab.craeteLabContent() : track_number : " .. Log: v(track_number))
        Log: w("synthv_to_lab.craeteLabContent() : target_track : " .. Log: v(target_track))
        Log: w("synthv_to_lab.craeteLabContent() : note_groups_references : " .. Log: v(note_groups_references))

        for index, note_group_reference in ipairs(note_groups_references) do
            Log: w("synthv_to_lab.craeteLabContent() : note_group_reference : " .. Log: v(note_group_reference))

            local notes_num = SynthV: getNumNotes(note_group_reference.note_group)
            local phonems_group = SynthV: getPhonemesForGroup(note_group_reference.group_reference)
            Log: w("synthv_to_lab.craeteLabContent() : notes_num : " .. Log: v(notes_num))

            for index = 1, notes_num do
                local note = note_group_reference.note_group: getNote(index)
                local base_phoneme = phonems_group[index]
                Log: w("synthv_to_lab.craeteLabContent() : base_phoneme : " .. Log: v(base_phoneme))

                local phonemes_list = SynthV: getPhonemesList(note, base_phoneme, time_axis)
                table.insert(lab_content, SynthVPhonemes: convertString(phonemes_list))
            end
        end

        return table.concat(lab_content, "")
    end,

    str_split = function (self, str)
        local r = {}
        Log: w("str : " .. str)
        Log: w("str : " .. string.match(str, '%w+'))

        for value in string.match(str, '%w+') do
            table.insert(r, value)
        end

        return r
    end,

    saveLab = function (self, path, content)
        local path_sjis = path

        if UTF8toSJIS_table then
            path_sjis = UTF8toSJIS:UTF8_to_SJIS_str_cnv(UTF8toSJIS_table, path)
        end

        local f = io.open(path_sjis, "w")
        f: write(content)
        return f: close()
    end,

    -- Modules Log

    saveFirstLog = function (self)
        Log: w("synthv_to_lab.saveFirstLog() : self.project_path : " .. self.project_path)
        Log: w("synthv_to_lab.saveFirstLog() : self.lab_path : " .. self.lab_path)
        Log: w("synthv_to_lab.saveFirstLog() : self.log_path : " .. self.log_path)

        for index, track in ipairs(self.tracks) do
            Log: w("synthv_to_lab.saveFirstLog() : track" .. index .. " : " .. Log: v(track: getName()))
        end

        Log: w("synthv_to_lab.saveFirstLog() : current track number : " .. Log: v(self.current_track))
    end,

    startLog = function (self, output_dialog_result)
        Log: w("synthv_to_lab.startLog() : log start")
    end,

    writeLog = function (self, text)
        Log: w(text)
    end,

    closeLog = function (self)
        Log: close()
    end
}


-- # Modules SynthV

SynthV = {

    -- Modules Track

    getTracks = function (self, project)
        local track_num = project: getNumTracks()
        local tracks = {}

        for index = 1, track_num do
            tracks[index] = project: getTrack(index)
        end

        return tracks
    end,

    getCurrentTrackDisplayOrder = function (self, main_editor)
        return main_editor: getCurrentTrack(): getDisplayOrder()
    end,

    -- Modules Phonems for Group

    getPhonemesForGroup = function (self, note_group_reference)
        local phonems_group = SV: getPhonemesForGroup(note_group_reference)
        Log: w("SynthV.getPhonemesForGroup() : phonems_group : " .. tostring(phonems_group))

        for kpg, vpg in pairs(phonems_group) do
            Log: w("SynthV.getPhonemesForGroup() : phonems_group : " .. tostring(kpg) .. ' : ' .. tostring(vpg))
        end

        return phonems_group
    end,

    -- Modules Note Group

    getNoteGroupsWithReference = function (self, track)
        local group_num = track: getNumGroups()
        Log: w("SynthV.getNoteGroupsWithReference() : track: getNumGroups() : " .. Log: v(group_num))

        local note_groups_references = {}

        for index = 1, group_num do
            local group_reference = track: getGroupReference(index)
            local note_group = group_reference: getTarget()

            table.insert(note_groups_references, {
                group_reference = group_reference,
                note_group = note_group
            })
        end

        return note_groups_references
    end,

    getNoteGroup = function (self, track)
        local group_num = track: getNumGroups()
        Log: w("SynthV.getNoteGroup() : target_track: getNumGroups() : " .. tostring(group_num))

        local note_groups = {}

        for index = 1, group_num do
            local group_reference = track: getGroupReference(index)
            local note_group = group_reference: getTarget()
            table.insert(note_groups, note_group)
        end

        return note_groups
    end,

    -- Modules Note

    getNumNotes = function (self, note_group)
        local notes_num = note_group: getNumNotes()
        Log: w("SynthV.getNumNotes() : notes_num : " .. notes_num)
        return notes_num
    end,

    getPhonemesList = function (self, note, base_phoneme, time_axis)
        local attr = note: getAttributes()
        local note_durs = attr.dur
        local note_alts = attr.alt
        local note_offset_second = attr.tNoteOffset
        if note_offset_second == nil then note_offset_second = 0 end

        local dur_all_brick = note: getDuration()
        local note_onset_brick = note: getOnset()
        local note_end_brick = note: getEnd()
        local phonemes_string = note: getPhonemes()

        if 0 == #phonemes_string then phonemes_string = base_phoneme end

        --[[
            ノートオフセット取得（100ns）
            音素の開始時間生成（100ns）
            音素の終了時間生成（100ns）
            音素の全体の継続時間取得（100ns）
            音素を空白で分割
            100を音素数で割ってデフォルト出力割合とする

            音素数分ループ
                aiueoなら母音とする、それ以外は子音とする
                子音の中でもnだけは特別扱いが必要
                    nnは「ん」になるがnnaは「んな」か「んあ」か
                    nnnaはどうか

                母音の場合
                    前回が母音なら
                        音素を出力音素とする
                        開始時間を取得
                        継続時間を取得
                            音素長スケーリングがあれば継続時間から割って算出
                            なければデフォルト出力割合に従って算出
                        開始時間と継続時間を足して終了時間とする
                        出力音素、開始時間、終了時間を出力配列に追加
                    前回が子音なら
                        音素を出力音素とする
                        開始時間を取得
                        継続時間を取得
                            音素長スケーリングがあれば継続時間から割って算出
                            なければデフォルト出力割合に従って算出
                        継続時間と子音継続時間を取得し音素継続時間とする
                        開始時間と音素継続時間を足して終了時間とする
                        出力音素、開始時間、終了時間を出力配列に追加
                    前回が無かったら
                子音の場合
                    前回が母音なら
                        開始時間を取得
                        継続時間を取得
                            音素長スケーリングがあれば全体継続時間を掛けて算出
                            なければデフォルト出力割合を全体継続時間に掛けて算出
                        取得した継続時間を子音継続時間とする
                    前回が子音なら
                        デフォルト音素を出力音素とする
                        継続時間を取得
                            音素長スケーリングがあれば継続時間から割って算出
                            なければデフォルト出力割合に従って算出
                        開始時間と継続時間を足して終了時間とする
                        出力音素、開始時間、終了時間を出力配列に追加
                        開始時間を取得
                    前回が無かったら
        ]]

        Log: w("SynthV.getPhonemesList() : note_offset_second : " .. Log: v(note_offset_second))
        Log: w("SynthV.getPhonemesList() : note_onset_brick : " .. Log: v(note_onset_brick))
        Log: w("SynthV.getPhonemesList() : note_end_brick : " .. Log: v(note_end_brick))
        Log: w("SynthV.getPhonemesList() : note_durs : " .. Log: v(note_durs))
        Log: w("SynthV.getPhonemesList() : phonemes_string : " .. Log: v(phonemes_string))

        local synthv_note = SynthVNote: new({
            note_offset_second = note_offset_second,
            note_onset_brick = note_onset_brick,
            time_axis = time_axis,
            note_end_brick = note_end_brick,
            note_durs = note_durs,
            note_phonemes = phonemes_string
        })

        local old_phonemes = {
            phoneme = 'a',
            start_time = 0,
            duration_time = 0,
            end_time = synthv_note.note_start
        }

        local append_phonemes = {}

        local synthv_phonemes = SynthVPhonemes: new(synthv_note)
        local phonemes_list = {}

        for index, phonemes in ipairs(synthv_note.note_phonemes) do
            Log: w("SynthV.getNoteInfo() : index : phonemes : " .. Log: v(index) .. ' : ' .. Log: v(phonemes))
            table.insert(phonemes_list, index, {})

            if synthv_note: inVowels(phonemes) then
                if synthv_note: inVowels(old_phonemes.phoneme) then
                    Log: w("SynthV.getNoteInfo() : vv")
                    -- 母母
                    --phonemes_list[index] = synthv_phonemes: createPhonemesInfoTypeVV(index, old_phonemes)
                    append_phonemes = synthv_phonemes: createPhonemesInfoTypeVV(index, old_phonemes)
                else
                    Log: w("SynthV.getNoteInfo() : cv")
                    -- 子母
                    --phonemes_list[index] = synthv_phonemes: createPhonemesInfoTypeVC(index, old_phonemes)
                    append_phonemes = synthv_phonemes: createPhonemesInfoTypeCV(index, old_phonemes)
                end
            else
                if synthv_note: inVowels(old_phonemes.phoneme) then
                    Log: w("SynthV.getNoteInfo() : vc")
                    -- 母子
                    --phonemes_list[index] = synthv_phonemes: createPhonemesInfoTypeCV(index, old_phonemes)
                    append_phonemes = synthv_phonemes: createPhonemesInfoTypeVC(index, old_phonemes)
                else
                    Log: w("SynthV.getNoteInfo() : cc")
                    -- 子子
                    --phonemes_list[index] = synthv_phonemes: createPhonemesInfoTypeCC(index, old_phonemes)
                    append_phonemes = synthv_phonemes: createPhonemesInfoTypeCC(index, old_phonemes)
                end
            end

            for i, appp in ipairs(append_phonemes) do
                if appp.wait == false then
                    phonemes_list[i] = appp
                end
            end

            -- old_phonemes = phonemes_list[index]
            old_phonemes = append_phonemes[#append_phonemes]
        end

        return phonemes_list
    end,

}


SynthVNote = {
    new = function (self, note_info)
        local note_offset = self: convertNoteOffset100ns(note_info.note_offset_second)
        local note_start = self: convertNoteOnSet100ns(note_info.note_onset_brick, note_info.time_axis)
        local note_end = self: convertNoteEnd100ns(note_info.note_end_brick, note_info.time_axis)
        local note_phonemes = self: getPhonemesTableFromString(note_info.note_phonemes)
        local default_ratio = self: getDefaultRatio(#note_phonemes)
        local note_durs = note_info.note_durs

        if not note_durs or 0 == #note_durs then
            note_durs = {}

            for index = 1, #note_phonemes do
                table.insert(note_durs, default_ratio)
            end
        end

        local obj = {
            note_offset = note_offset,
            note_start = note_start,
            note_end = note_end,
            note_duration = note_end - note_start,
            note_durs = note_durs,
            note_phonemes = note_phonemes,
            default_ratio = default_ratio,
            vowels = { 'a', 'i', 'u', 'e', 'o' },
            undefined_vowel = 'n'
        }

        return setmetatable(obj, { __index = self })
    end,

    convertNoteOffset100ns = function (self, note_offset)
        Log: w("SynthVNote.convertNoteOffset100ns() : note_offset : " .. Log: v(note_offset))

        local sto100ns = self: secondTo100ns(note_offset)
        Log: w("SynthVNote.convertNoteOffset100ns() : sto100ns : " .. Log: v(sto100ns))
        return sto100ns
    end,

    convertNoteOnSet100ns = function (self, onset_brick, time_axis)
        local onset_second = time_axis: getSecondsFromBlick(onset_brick)
        Log: w("SynthVNote.convertNoteOnSet100ns() : onset_second : " .. Log: v(onset_second))
        local sto100ns = self: secondTo100ns(onset_second)
        Log: w("SynthVNote.convertNoteOnSet100ns() : sto100ns : " .. Log: v(sto100ns))
        return sto100ns
    end,

    convertNoteEnd100ns = function (self, end_brick, time_axis)
        local end_second = time_axis: getSecondsFromBlick(end_brick)
        Log: w("SynthVNote.convertNoteEnd100ns() : end_second : " .. Log: v(end_second))
        local sto100ns = self: secondTo100ns(end_second)
        Log: w("SynthVNote.convertNoteEnd100ns() : sto100ns : " .. Log: v(sto100ns))
        return sto100ns
    end,

    getPhonemesTableFromString = function (self, phonemes_string)
        Log: w("SynthVNote.getPhonemesTableFromString() : phonemes_string : " .. Log: v(phonemes_string))
        local split_str = {}

        for word in string.gmatch(phonemes_string, '%w+') do
            table.insert(split_str, word)
        end

        Log: w("SynthVNote.getPhonemesTableFromString() : split_str : " .. Log: v(split_str))
        return split_str
    end,

    getDefaultRatio = function (self, phonemes_num)
        Log: w("SynthVNote.getDefaultRatio() : phonemes_num : " .. Log: v(phonemes_num))
        local ratio = (100 / phonemes_num) / 100
        Log: w("SynthVNote.getDefaultRatio() : ratio : " .. Log: v(ratio))
        return ratio
    end,

    -- Utilities

    secondTo100ns = function (self, second)
        return MathRound(second * 10000000)
    end,

    inVowels = function (self, phonemes)
        Log: w("SynthVNote.inVowels() : phonemes : " .. Log: v(phonemes))
        local in_vowels = self: inTable(phonemes, self.vowels)
        Log: w("SynthVNote.inVowels() : in_vowels : " .. Log: v(in_vowels))
        return in_vowels
    end,

    inTable = function (self, search, table)
        for index = 1, #table do
            if table[index] == search then return true end
        end

        return false
    end,

    isSoundRepellency = function (self, phoneme)
        return phoneme == 'N'
    end
}


SynthVPhonemes = {
    new = function (self, synthv_note)
        local obj = {
            note_info = synthv_note,
        }

        return setmetatable(obj, { __index = self })
    end,

    -- 母母
    -- そのまま登録
    createPhonemesInfoTypeVV = function (self, index, oldest)
        local phoneme = self.note_info.note_phonemes[index]
        local start_time = oldest.end_time

        Log: w("SynthV.createPhonemesInfoTypeVV() : self.note_info.note_durs[index] : " .. self.note_info.note_durs[index])
        Log: w("SynthV.createPhonemesInfoTypeVV() : self.note_info.note_duration : " .. self.note_info.note_duration)
        Log: w("SynthV.createPhonemesInfoTypeVV() : self.note_info.default_ratio : " .. self.note_info.default_ratio)
        Log: w("SynthV.createPhonemesInfoTypeVV() : (self.note_info.note_duration * self.note_info.note_durs[index]) : " .. (self.note_info.note_duration * self.note_info.note_durs[index]))
        Log: w("SynthV.createPhonemesInfoTypeVV() : (self.note_info.note_duration * self.note_info.default_ratio) : " .. (self.note_info.note_duration * self.note_info.default_ratio))

        local duration_time = MathRound(self.note_info.note_durs[index] and
            (self.note_info.note_duration * self.note_info.note_durs[index]) or
            self.note_info.note_duration * self.note_info.default_ratio)

        local end_time = start_time + duration_time

        local obj = {
            phoneme = phoneme,
            start_time = start_time,
            duration_time = duration_time,
            end_time = end_time,
            wait = false
        }

        Log: w("SynthV.createPhonemesInfoTypeVV() : obj : " .. Log: v(obj, true))
        return { obj }
    end,

    -- 子母
    -- 子と母で一つとして登録（子がNだった時は別々に登録）
    createPhonemesInfoTypeCV = function (self, index, oldest)
        Log: w("SynthV.createPhonemesInfoTypeCV() : oldest.phoneme : " .. Log: v(oldest.phoneme, true))

        if oldest.phoneme == 'N' and oldest.wait then
            local phoneme = self.note_info.note_phonemes[index]
            local start_time = oldest.end_time

            Log: w("SynthV.createPhonemesInfoTypeCV() : self.note_info.note_durs[index] : " .. self.note_info.note_durs[index])
            Log: w("SynthV.createPhonemesInfoTypeCV() : self.note_info.note_duration : " .. self.note_info.note_duration)
            Log: w("SynthV.createPhonemesInfoTypeCV() : self.note_info.default_ratio : " .. self.note_info.default_ratio)
            Log: w("SynthV.createPhonemesInfoTypeCV() : (self.note_info.note_duration * self.note_info.note_durs[index]) : " .. (self.note_info.note_duration * self.note_info.note_durs[index]))
            Log: w("SynthV.createPhonemesInfoTypeCV() : (self.note_info.note_duration * self.note_info.default_ratio) : " .. (self.note_info.note_duration * self.note_info.default_ratio))

            local duration_time = MathRound(self.note_info.note_durs[index] and
                (self.note_info.note_duration * self.note_info.note_durs[index]) or
                self.note_info.note_duration * self.note_info.default_ratio)

            local end_time = start_time + duration_time

            local obj = {
                phoneme = phoneme,
                start_time = start_time,
                duration_time = duration_time,
                end_time = end_time,
                wait = false
            }

            oldest.wait = false

            Log: w("SynthV.createPhonemesInfoTypeCV() : obj : " .. Log: v(obj, true))
            return { oldest, obj }
        end

        local phoneme = self.note_info.note_phonemes[index]
        local start_time = oldest.end_time

        if oldest.wait == true then
            start_time = oldest.start_time
        end

        Log: w("SynthV.createPhonemesInfoTypeCV() : self.note_info.note_durs[index] : " .. self.note_info.note_durs[index])
        Log: w("SynthV.createPhonemesInfoTypeCV() : self.note_info.note_duration : " .. self.note_info.note_duration)
        Log: w("SynthV.createPhonemesInfoTypeCV() : self.note_info.default_ratio : " .. self.note_info.default_ratio)
        Log: w("SynthV.createPhonemesInfoTypeCV() : (self.note_info.note_duration * self.note_info.note_durs[index]) : " .. (self.note_info.note_duration * self.note_info.note_durs[index]))
        Log: w("SynthV.createPhonemesInfoTypeCV() : (self.note_info.note_duration * self.note_info.default_ratio) : " .. (self.note_info.note_duration * self.note_info.default_ratio))

        Log: w("SynthV.createPhonemesInfoTypeCV() : (self.note_info.note_duration * self.note_info.note_durs[index - 1]) : " .. (self.note_info.note_duration * self.note_info.note_durs[index - 1]))

        local duration_time = MathRound(self.note_info.note_durs[index] and
            (self.note_info.note_duration * self.note_info.note_durs[index]) or
            self.note_info.note_duration * self.note_info.default_ratio)

        duration_time = duration_time + MathRound(self.note_info.note_durs[index - 1] and
            (self.note_info.note_duration * self.note_info.note_durs[index - 1]) or
            self.note_info.note_duration * self.note_info.default_ratio)

        local end_time = start_time + duration_time

        local obj = {
            phoneme = phoneme,
            start_time = start_time,
            duration_time = duration_time,
            end_time = end_time,
            wait = false
        }

        Log: w("SynthV.createPhonemesInfoTypeCV() : obj : " .. Log: v(obj, true))
        return { obj }
    end,

    -- 母子
    -- 母は登録済み、子は次を待つ
    createPhonemesInfoTypeVC = function (self, index, oldest)
        local phoneme = self.note_info.note_phonemes[index]
        local start_time = oldest.end_time

        Log: w("SynthV.createPhonemesInfoTypeVC() : index : " .. index)
        Log: w("SynthV.createPhonemesInfoTypeVC() : phoneme : " .. phoneme)
        Log: w("SynthV.createPhonemesInfoTypeVC() : start_time : " .. start_time)
        Log: w("SynthV.createPhonemesInfoTypeVC() : self.note_info.note_durs[index] : " .. self.note_info.note_durs[index])
        Log: w("SynthV.createPhonemesInfoTypeVC() : self.note_info.note_duration : " .. self.note_info.note_duration)
        Log: w("SynthV.createPhonemesInfoTypeVC() : self.note_info.default_ratio : " .. self.note_info.default_ratio)
        Log: w("SynthV.createPhonemesInfoTypeVC() : (self.note_info.note_duration * self.note_info.note_durs[index]) : " .. (self.note_info.note_duration * self.note_info.note_durs[index]))
        Log: w("SynthV.createPhonemesInfoTypeVC() : (self.note_info.note_duration * self.note_info.default_ratio) : " .. (self.note_info.note_duration * self.note_info.default_ratio))

        local duration_time = MathRound((self.note_info.note_durs[index] and
            (self.note_info.note_duration * self.note_info.note_durs[index]) or
            self.note_info.note_duration * self.note_info.default_ratio)
            + oldest.duration_time)

        local end_time = start_time + duration_time

        local obj = {
            phoneme = phoneme,
            start_time = start_time,
            duration_time = duration_time,
            end_time = end_time,
            wait = true
        }

        Log: w("SynthV.createPhonemesInfoTypeVC() : obj : " .. Log: v(obj, true))
        return { obj }
    end,

    -- 子子
    -- 開始時間をキープして次を待つ（前がNで次がそれ以外の場合は前だけ登録）
    createPhonemesInfoTypeCC = function (self, index, oldest)
        Log: w("SynthV.createPhonemesInfoTypeCC() : oldest.phoneme : " .. Log: v(oldest.phoneme, true))
        --local phoneme = self.note_info.undefined_vowel
        local phoneme = oldest.phoneme

        if oldest.phoneme == 'N' and oldest.wait and phoneme ~= 'N' then
            local start_time = oldest.end_time

            Log: w("SynthV.createPhonemesInfoTypeCC() : self.note_info.note_durs[index] : " .. self.note_info.note_durs[index])
            Log: w("SynthV.createPhonemesInfoTypeCC() : self.note_info.note_duration : " .. self.note_info.note_duration)
            Log: w("SynthV.createPhonemesInfoTypeCC() : self.note_info.default_ratio : " .. self.note_info.default_ratio)
            Log: w("SynthV.createPhonemesInfoTypeCC() : (self.note_info.note_duration / self.note_info.note_durs[index]) : " .. (self.note_info.note_duration / self.note_info.note_durs[index]))
            Log: w("SynthV.createPhonemesInfoTypeCC() : (self.note_info.note_duration / self.note_info.default_ratio) : " .. (self.note_info.note_duration / self.note_info.default_ratio))

            local duration_time = MathRound(self.note_info.note_durs[index] and
                (self.note_info.note_duration / self.note_info.note_durs[index]) or
                self.note_info.note_duration / self.note_info.default_ratio)
                + oldest.duration_time
    
            local end_time = start_time + duration_time
    
            local obj = {
                phoneme = phoneme,
                start_time = start_time,
                duration_time = duration_time,
                end_time = end_time,
                wait = true
            }

            Log: w("SynthV.createPhonemesInfoTypeCC() : obj : " .. Log: v(obj, true))
            oldest.wait = false
            return { oldest, obj }
        end

        local start_time = oldest.end_time

        if oldest.wait == true then
            start_time = oldest.start_time
        end

        Log: w("SynthV.createPhonemesInfoTypeCC() : self.note_info.note_durs[index] : " .. self.note_info.note_durs[index])
        Log: w("SynthV.createPhonemesInfoTypeCC() : self.note_info.note_duration : " .. self.note_info.note_duration)
        Log: w("SynthV.createPhonemesInfoTypeCC() : self.note_info.default_ratio : " .. self.note_info.default_ratio)
        Log: w("SynthV.createPhonemesInfoTypeCC() : (self.note_info.note_duration / self.note_info.note_durs[index]) : " .. (self.note_info.note_duration / self.note_info.note_durs[index]))
        Log: w("SynthV.createPhonemesInfoTypeCC() : (self.note_info.note_duration / self.note_info.default_ratio) : " .. (self.note_info.note_duration / self.note_info.default_ratio))

        local duration_time = MathRound(self.note_info.note_durs[index] and
            (self.note_info.note_duration / self.note_info.note_durs[index]) or
            self.note_info.note_duration / self.note_info.default_ratio)
            + oldest.duration_time

        local end_time = start_time + duration_time

        local obj = {
            phoneme = phoneme,
            start_time = start_time,
            duration_time = duration_time,
            end_time = end_time,
            wait = true
        }

        Log: w("SynthV.createPhonemesInfoTypeCC() : obj : " .. Log: v(obj, true))
        return { obj }
    end,

    convertString = function (self, phonemes_list)
        local str = ''

        Log: w("SynthV.convertString() : phonemes_list : " .. Log: v(phonemes_list, true))

        for index, phonemes in ipairs(phonemes_list) do
            if not phonemes or phonemes == nil or table.empty(phonemes) then goto convertStringContinue1 end
            Log: w("SynthV.convertString() : phonemes : " .. Log: v(phonemes, true))
            str = str .. phonemes.start_time .. ' ' .. phonemes.end_time .. ' ' .. phonemes.phoneme .. "\n"
            ::convertStringContinue1::
        end

        Log: w("SynthV.convertString() : str : " .. Log: v(str))
        return str
    end
}


-- # Modules path

Path = {
    changeExt = function (self, path, ext)
        local path = string.gsub(path, '%.[^%.]*$', ext)
        return path
    end,

    changeToWindows = function (self, path)
        local path = string.gsub(path, '\\', '/')
        return path
    end
}


-- # Modules log

LogBase = {

    -- Foundation

    new = function (self)
        local obj = {
            log_path = '',
            log_path_sjis = '',
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

    setPath = function (self, log_path)
        local log_path_sjis = log_path

        if UTF8toSJIS_table then
            log_path_sjis = UTF8toSJIS:UTF8_to_SJIS_str_cnv(UTF8toSJIS_table, log_path)
        end

        self.log_path = log_path
        self.log_path_sjis = log_path_sjis
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
            return self.logfile: write('[' .. self: t() .. '] ' .. tostring(value) .. "\n")
        end

        self.pre_log = self.pre_log .. '[' .. self: t() .. '] ' .. tostring(value) .. "\n";
    end,

    t = function (self)
        return os.date("%Y-%m-%d %H:%M:%S")
    end,

    v = function (self, value, hash_table, depth)
        local value_type = type(value)
        if depth == nil then depth = 0 end
        if hash_table then hash_table = true else hash_table = false end

        if value_type == 'nil' then
            return 'nil'
        end

        if value_type == 'number' then
            return tostring(value)
        end

        if value_type == 'string' then
            return '"' .. tostring(value) .. '"'
        end

        if value_type == 'boolean' then
            return value and 'true' or 'false'
        end

        if value_type == 'table' then
            local r = "\n"
            depth = depth + 1

            local indent = ''

            for index = 1, depth do
                indent = indent .. '    '
            end

            if hash_table then
                for key, val in pairs(value) do
                    r = r .. 'table:' .. indent .. tostring(key) .. ' : ' .. self: v(val, hash_table, depth) .. "\n"
                end
            else
                for ind, val in ipairs(value) do
                    r = r .. 'table:' .. indent .. tostring(ind) .. ' : ' .. self: v(val, hash_table, depth) .. "\n"
                end
            end

            return r
        end

        return value_type .. ' : ' .. tostring(value)
    end
}

Log = LogBase: new()


-- # Modules output settings dialog

OutputSettingsDialog = {

    -- Foundation

    new = function (self, tracks, current_order)
        -- Properties
        local obj = {
            tracks = tracks,
            current_order = current_order,
            choices = {}
        }

        return setmetatable(obj, { __index = self })
    end,

    -- Modules

    show = function (self)
        local dialog_parameters = self: getParameters()
        results = SV: showCustomDialog(dialog_parameters)
            
        if not results.status then
            return results
        end

        results.answers.track = results.answers.track + 1

        return results
    end,

    getParameters = function (self)
        for index, track in ipairs(self.tracks) do
            table.insert(self.choices, index, "track" .. tostring(index) .. ' : ' .. track: getName())
        end

        table.insert(self.choices, 1, SV: T("all: all track"))

        local param = {
            title = SV: T("Output settings track"),
            message = SV: T("It will be saved in the same directory as the project file."),
            buttons = "OkCancel",

            widgets = {
                {
                    name = "track",
                    type = "ComboBox",
                    label = SV: T("Select track"),
                    default = self.current_order,
                    choices = self.choices
                },

                {
                  name = "logsave",
                  type = "CheckBox",
                  text = SV: T("Output log together (The time required for output will increase considerably)"),
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


MathRound = function (value)
    return math.floor(value + 0.5)
end


-- # Utilities UTF8toSJIS

--- https://github.com/AoiSaya/FlashAir_UTF8toSJIS/

UTF8toSJIS_table_path = "pluginLibs/SynthVtoLab/Utf8Sjis.tbl"
UTF8toSJIS_table = io.open(UTF8toSJIS_table_path, "rb")

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


