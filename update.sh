cd ~/githubrepo/rime/rime-data/ && git pull

cd ~/githubrepo/rime/rime-bopomofo/ && git pull
cd ~/githubrepo/rime/rime-cangjie/ && git pull
cd ~/githubrepo/rime/rime-cantonese/ && git pull
cd ~/githubrepo/rime/rime-double-pinyin/ && git pull
cd ~/githubrepo/rime/rime-emoji/ && git pull
cd ~/githubrepo/rime/rime-essay/ && git pull
cd ~/githubrepo/rime/rime-jyutping/ && git pull
cd ~/githubrepo/rime/rime-luna-pinyin/ && git pull
cd ~/githubrepo/rime/rime-pinyin-simp/ && git pull
cd ~/githubrepo/rime/rime-prelude/ && git pull
cd ~/githubrepo/rime/rime-stroke/ && git pull
cd ~/githubrepo/rime/rime-terra-pinyin/ && git pull
cd ~/githubrepo/rime/rime-wubi/ && git pull

cp -f ~/githubrepo/rime/rime-bopomofo/*.yaml ~/githubrepo/rime/rime-data/
cp -f ~/githubrepo/rime/rime-cangjie/*.yaml ~/githubrepo/rime/rime-data/
cp -f ~/githubrepo/rime/rime-cantonese/*.yaml ~/githubrepo/rime/rime-data/
cp -f ~/githubrepo/rime/rime-double-pinyin/*.yaml ~/githubrepo/rime/rime-data/
cp -f ~/githubrepo/rime/rime-emoji/*.yaml ~/githubrepo/rime/rime-data/
cp -f ~/githubrepo/rime/rime-essay/*.txt ~/githubrepo/rime/rime-data/
cp -f ~/githubrepo/rime/rime-jyutping/*.yaml ~/githubrepo/rime/rime-data/
cp -f ~/githubrepo/rime/rime-luna-pinyin/*.yaml ~/githubrepo/rime/rime-data/
cp -f ~/githubrepo/rime/rime-pinyin-simp/*.yaml ~/githubrepo/rime/rime-data/
cp -f ~/githubrepo/rime/rime-prelude/*.yaml ~/githubrepo/rime/rime-data/
cp -f ~/githubrepo/rime/rime-stroke/*.yaml ~/githubrepo/rime/rime-data/
cp -f ~/githubrepo/rime/rime-terra-pinyin/*.yaml ~/githubrepo/rime/rime-data/
cp -f ~/githubrepo/rime/rime-wubi/*.yaml ~/githubrepo/rime/rime-data/

cd ~/githubrepo/rime/rime-data/
cat Unihan_Readings-kMandarin.txt >> luna_pinyin.dict.yaml
git add .
git commit -m "Sync Pre-Installed Official Schemas"
git push
