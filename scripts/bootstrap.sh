if [ -z "$0" ]; then
  target_branch="master"
else
  target_branch="$0"
fi

echo cloning branch $target_branch from github.com/8dianhou/cf-backbone...

mkdir ./temp

git clone https://github.com/8dianhou/cf-backbone --branch $target_branch --single-branch ./temp

rm -rf ./temp/.git
shopt -s dotglob
mv ./temp/* ./

rm -r ./temp
cnpm i && bower install
