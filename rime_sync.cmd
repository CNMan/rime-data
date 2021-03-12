mode con cols=500 lines=500
taskkill /IM WeaselServer.exe /F
git pull
rd /s /q "E:\VMware\Rime\data\build\"
rd /s /q "E:\VMware\Rime\data\luna_pinyin.userdb\"
rd /s /q "E:\VMware\Rime\data\pinyin_simp.userdb\"
rd /s /q "E:\VMware\Rime\data\terra_pinyin.userdb\"
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