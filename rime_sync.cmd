mode con cols=500 lines=500
cd /d "E:\GitHub\OpenCC\" && git pull
cd /d "e:\GitHub\rime\Arthurmcarthur\Cangjie3-Plus\" && git pull
cd /d "E:\GitHub\rime\DictTool\" && git pull
cd /d "E:\GitHub\rime\hchunhui\librime-lua\" && git pull
cd /d "e:\GitHub\rime\Jackchows\Cangjie5\" && git pull
cd /d "E:\GitHub\rime\lotem\rime-guhuwubi\" && git pull
cd /d "E:\GitHub\rime\lotem\rime-linguistic-wubi\" && git pull
cd /d "E:\GitHub\rime\lotem\rime-wubi98\" && git pull
cd /d "E:\GitHub\rime\lotem\rime-zhengma\" && git pull
cd /d "E:\GitHub\rime\rime\rime-bopomofo\" && git pull
cd /d "E:\GitHub\rime\rime\rime-cangjie\" && git pull
cd /d "E:\GitHub\rime\rime\rime-cantonese\" && git pull
cd /d "E:\GitHub\rime\rime\rime-double-pinyin\" && git pull
cd /d "E:\GitHub\rime\rime\rime-emoji\" && git pull
cd /d "E:\GitHub\rime\rime\rime-essay\" && git pull
cd /d "E:\GitHub\rime\rime\rime-jyutping\" && git pull
cd /d "E:\GitHub\rime\rime\rime-luna-pinyin\" && git pull
cd /d "E:\GitHub\rime\rime\rime-pinyin-simp\" && git pull
cd /d "E:\GitHub\rime\rime\rime-prelude\" && git pull
cd /d "E:\GitHub\rime\rime\rime-stroke\" && git pull
cd /d "E:\GitHub\rime\rime\rime-terra-pinyin\" && git pull
cd /d "E:\GitHub\rime\rime\rime-wubi\" && git pull
cd /d "E:\GitHub\rime\rime-configuration\bosconb\Rime_sync\" && git pull
cd /d "E:\GitHub\rime\rime-configuration\byujiang\wubi06_rime\" && git pull
cd /d "E:\GitHub\rime\rime-configuration\cmal\rime-conf\" && git pull
cd /d "E:\GitHub\rime\rime-configuration\g178253\rime-wubi06\" && git pull
cd /d "E:\GitHub\rime\rime-configuration\GuoBinyong\wubixinshiji\" && git pull
cd /d "E:\GitHub\rime\rime-configuration\hz-lang\wb06\" && git pull
cd /d "E:\GitHub\rime\rime-configuration\jiqiangwubi\SuperWubiSchema\" && git pull
cd /d "E:\GitHub\rime\rime-configuration\kktt007\rime-fcitx-rime\" && git pull
cd /d "E:\GitHub\rime\rime-configuration\lswqzhang\RIME-wubi\" && git pull
cd /d "E:\GitHub\rime\rime-configuration\outsinre\fcitx-rime\" && git pull
cd /d "E:\GitHub\rime\rime-configuration\Pioneer-Linzi\xinshijiwubi\" && git pull
cd /d "E:\GitHub\rime\rime-configuration\rtransformation\rime-opencc_emoji_symbols\" && git pull
cd /d "E:\GitHub\rime\rime-configuration\tigren\rime_configs\" && git pull
cd /d "E:\GitHub\rime\rime-configuration\youanan\rime\" && git pull
taskkill /IM WeaselServer.exe /F
del "E:\VMware\Rime\data\installation.yaml"
del "E:\VMware\Rime\Weasel\7z.dll"
del "E:\VMware\Rime\Weasel\7z.exe"
del "E:\VMware\Rime\Weasel\7-zip-license.txt"
del "E:\VMware\Rime\Weasel\COPYING-curl.txt"
del "E:\VMware\Rime\Weasel\curl.exe"
del "E:\VMware\Rime\Weasel\curl-ca-bundle.crt"
del "E:\VMware\Rime\Weasel\LICENSE.txt"
del "E:\VMware\Rime\Weasel\README.txt"
del "E:\VMware\Rime\Weasel\rime-install.bat"
del "E:\VMware\Rime\Weasel\rime-install-config.bat"
del "E:\VMware\Rime\Weasel\uninstall.exe"
del "E:\VMware\Rime\Weasel\data\bopomofo.schema.yaml"
del "E:\VMware\Rime\Weasel\data\bopomofo_express.schema.yaml"
del "E:\VMware\Rime\Weasel\data\bopomofo_tw.schema.yaml"
del "E:\VMware\Rime\Weasel\data\cangjie5.dict.yaml"
del "E:\VMware\Rime\Weasel\data\cangjie5.schema.yaml"
del "E:\VMware\Rime\Weasel\data\cangjie5_express.schema.yaml"
del "E:\VMware\Rime\Weasel\data\default.yaml"
del "E:\VMware\Rime\Weasel\data\essay.txt"
del "E:\VMware\Rime\Weasel\data\key_bindings.yaml"
del "E:\VMware\Rime\Weasel\data\luna_pinyin.dict.yaml"
del "E:\VMware\Rime\Weasel\data\luna_pinyin.schema.yaml"
del "E:\VMware\Rime\Weasel\data\luna_pinyin_fluency.schema.yaml"
del "E:\VMware\Rime\Weasel\data\luna_pinyin_simp.schema.yaml"
del "E:\VMware\Rime\Weasel\data\luna_pinyin_tw.schema.yaml"
del "E:\VMware\Rime\Weasel\data\luna_quanpin.schema.yaml"
del "E:\VMware\Rime\Weasel\data\pinyin_simp.dict.yaml"
del "E:\VMware\Rime\Weasel\data\pinyin_simp.schema.yaml"
del "E:\VMware\Rime\Weasel\data\punctuation.yaml"
del "E:\VMware\Rime\Weasel\data\stroke.dict.yaml"
del "E:\VMware\Rime\Weasel\data\stroke.schema.yaml"
del "E:\VMware\Rime\Weasel\data\symbols.yaml"
del "E:\VMware\Rime\Weasel\data\terra_pinyin.dict.yaml"
del "E:\VMware\Rime\Weasel\data\terra_pinyin.schema.yaml"
copy "E:\GitHub\rime\rime\rime-bopomofo\bopomofo.schema.yaml" "E:\VMware\Rime\data\bopomofo.schema.yaml" /y
copy "E:\GitHub\rime\rime\rime-bopomofo\bopomofo_express.schema.yaml" "E:\VMware\Rime\data\bopomofo_express.schema.yaml" /y
copy "E:\GitHub\rime\rime\rime-bopomofo\bopomofo_tw.schema.yaml" "E:\VMware\Rime\data\bopomofo_tw.schema.yaml" /y
copy "E:\GitHub\rime\rime\rime-cangjie\cangjie5.dict.yaml" "E:\VMware\Rime\data\cangjie5.dict.yaml" /y
copy "E:\GitHub\rime\rime\rime-cangjie\cangjie5.schema.yaml" "E:\VMware\Rime\data\cangjie5.schema.yaml" /y
copy "E:\GitHub\rime\rime\rime-cangjie\cangjie5_express.schema.yaml" "E:\VMware\Rime\data\cangjie5_express.schema.yaml" /y
copy "E:\GitHub\rime\rime\rime-essay\essay.txt" "E:\VMware\Rime\data\essay.txt" /y
copy "E:\GitHub\rime\rime\rime-luna-pinyin\luna_pinyin.dict.yaml" "E:\VMware\Rime\data\luna_pinyin.dict.yaml" /y
copy "E:\GitHub\rime\rime\rime-luna-pinyin\luna_pinyin.schema.yaml" "E:\VMware\Rime\data\luna_pinyin.schema.yaml" /y
copy "E:\GitHub\rime\rime\rime-luna-pinyin\luna_pinyin_fluency.schema.yaml" "E:\VMware\Rime\data\luna_pinyin_fluency.schema.yaml" /y
copy "E:\GitHub\rime\rime\rime-luna-pinyin\luna_pinyin_simp.schema.yaml" "E:\VMware\Rime\data\luna_pinyin_simp.schema.yaml" /y
copy "E:\GitHub\rime\rime\rime-luna-pinyin\luna_pinyin_tw.schema.yaml" "E:\VMware\Rime\data\luna_pinyin_tw.schema.yaml" /y
copy "E:\GitHub\rime\rime\rime-luna-pinyin\luna_quanpin.schema.yaml" "E:\VMware\Rime\data\luna_quanpin.schema.yaml" /y
copy "E:\GitHub\rime\rime\rime-pinyin-simp\pinyin_simp.dict.yaml" "E:\VMware\Rime\data\pinyin_simp.dict.yaml" /y
copy "E:\GitHub\rime\rime\rime-pinyin-simp\pinyin_simp.schema.yaml" "E:\VMware\Rime\data\pinyin_simp.schema.yaml" /y
copy "e:\GitHub\rime\rime\rime-prelude\default.yaml" "E:\VMware\Rime\data\default.yaml" /y
copy "e:\GitHub\rime\rime\rime-prelude\key_bindings.yaml" "E:\VMware\Rime\data\key_bindings.yaml" /y
copy "e:\GitHub\rime\rime\rime-prelude\punctuation.yaml" "E:\VMware\Rime\data\punctuation.yaml" /y
copy "e:\GitHub\rime\rime\rime-prelude\symbols.yaml" "E:\VMware\Rime\data\symbols.yaml" /y
copy "E:\GitHub\rime\rime\rime-stroke\stroke.dict.yaml" "E:\VMware\Rime\data\stroke.dict.yaml" /y
copy "E:\GitHub\rime\rime\rime-stroke\stroke.schema.yaml" "E:\VMware\Rime\data\stroke.schema.yaml" /y
copy "E:\GitHub\rime\rime\rime-terra-pinyin\terra_pinyin.dict.yaml" "E:\VMware\Rime\data\terra_pinyin.dict.yaml" /y
copy "E:\GitHub\rime\rime\rime-terra-pinyin\terra_pinyin.schema.yaml" "E:\VMware\Rime\data\terra_pinyin.schema.yaml" /y
rd /s /q "E:\VMware\Rime\data\build\"
rd /s /q "E:\VMware\Rime\data\luna_pinyin.userdb\"
rd /s /q "E:\VMware\Rime\data\pinyin_simp.userdb\"
rd /s /q "e:\VMware\Rime\data\terra_pinyin.userdb\"
cd /d E:\VMware\Rime\data\
sed -i '/luna_pinyin/d' user.yaml
sed -i '/pinyin_simp/d' user.yaml
sed -i '/terra_pinyin/d' user.yaml
sed -i 's/aaaaaaaaaaaaaaaaaaaaaaaaaaaa/bbbbbbbbbbbbbbbbbbbbbbbbbbbb/g' *.yaml
cd /d "E:\VMware\Rime\Weasel\"
start /wait WeaselDeployer /deploy
nircmd exec2 hide "E:\VMware\Rime\Weasel\" "E:\VMware\Rime\Weasel\WeaselServer.exe"
cd /d E:\VMware\Rime\data\
git diff
git add .
git commit -m "Sync Pre-Installed Official Schemas"
git push
pause