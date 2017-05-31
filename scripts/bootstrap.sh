echo cloning branch $1 from github.com/8dianhou/cf-backbone...
git clone https://github.com/8dianhou/cf-backbone --branch $1 --single-branch ./temp
rm -rf ./temp/.git
mv ./temp/* ./
mv ./temp/.* ./
rm -r ./temp
