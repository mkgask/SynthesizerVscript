# Synthesizer V script

このリポジトリは以下のSynthesizer Vスクリプトを設置予定です。（今のところv1、v2両対応）

This repository plans the following Synthesizer V scripts. (Currently compatible with both v1 and v2)



## SynthVtoLab

AviUtlのPSDToolkitで使う口パク準備（音素のみ）を生成するlabファイルを出力
~~多分ほぼ完成~~

Output lab file for lip-sync preparation (phonemes only) used in PSDToolkit in AviUtl.  
BPM change in the song should have been supported.  
~~Maybe almost Completed.~~



## SynthVtoVmd

MMDで使う表情モーション用のvmdファイルを出力  
計画中

Output vmd file for facial expression motion used in MMD.  
Under planning.



## Script usage - スクリプトの使い方

1. このページの緑のCodeボタンからzipファイルをダウンロード＆展開してください。
1. pluginLibsフォルダをSynthesizer Vの実行ファイルがあるフォルダにコピーしてください。
1. SynthVtoLabフォルダをSynthesiver Vのscriptsフォルダへコピーしてください。
1. Synthesizer Vを起動すると、上部メニューのスクリプトに「出力」->「PSDToolkit用の*.labファイルを出力」が増えているので、用途に合わせてご利用ください。
---
1. Zipfile download and expand where green "Code" button in this page.
1. Copy to pluginLibs folder to same directory in Synthesizer V execution file.
1. Copy to SynthVtoLab folder to Synthesizer V scripts folder.
1. Use it according to your needs "Output" -> "Output *.lab file for PSDToolkit" are added to the script in the top menu when you start Synthesizer V.
<!--
1. リリースページからzipファイルをダウンロード・展開してください。
1. pluginLibsフォルダをSynthesizer Vの実行ファイルがあるフォルダにコピーしてください。
1. SynthVtoLabフォルダまたはSynthVtoVmdフォルダをSynthesiver Vのscriptフォルダへコピーしてください。
1. Synthesizer Vを起動すると、上部メニューのスクリプトに「SynthV to Lab」か「SynthV to Vmd」または両方が増えているので、用途に合わせてご利用ください。
---
1. Zip file download and expand from release page.
1. Copy to pluginLibs folder to same directory in Synthesizer V execution file.
1. Copy to SynthVtoLab folder or SynthVtoVmd folder to Synthesizer V script folder.
1. Use it according to your needs "Synth V to Lab", "Synth V to Vmd", or both are added to the script in the top menu when you start Synthesizer V.
-->



## Special Thanks  --  深謝

AoiSaya/FlashAir_UTF8toSJIS: FlashAir library to convert from UTF-8 to Shift _ JIS  
https://github.com/AoiSaya/FlashAir_UTF8toSJIS/

日本語を含むファイルパスへの保存に使わせていただきました

I used it to save to a file path including Japanese

SynthV_scripts/snippets/lua.code-snippets at master · Yukikazari/SynthV_scripts
https://github.com/Yukikazari/SynthV_scripts/blob/master/snippets/lua.code-snippets

VS CodeでのSynthesizer Vスクリプト開発に必須です

Required for developing Synthesizer V scripts in VS Code



## History  --  更新履歴

2025/07/02 v2.0.1 軽微な修正    Minor fixes.  
2025/06/29 v2 Synthesizer V Studio 2 Pro 仮対応    Provisional response.
2022/04/25 v1 初版    First version.  


