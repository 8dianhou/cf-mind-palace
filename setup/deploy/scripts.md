# deploy scripts

## deploy.sh

> this deploy script does 3 things:
> 1. check if there's uncommited code
> 2. check if tagged (when deploy to certain servers)
> 3. use `git push $remote $branch` to trigger hook deploy (ref: setup/deploy/hook-deploy.md)

```bash
#!/bin/sh
set -e

ENV=$1
BRANCH="$(git symbolic-ref HEAD 2>/dev/null)"

GST="$(git status --porcelain)"
if [ -n "$GST" ]; then
  echo "\033[31m commit first: working directory NOT clean \033[0m"
  exit 1;
fi

if ! [[ "$ENV" =~ (test|stage|production) ]]; then
  echo "invalid ENV argument(should be test/production/...)!"
  exit
fi

if [[ "$ENV" =~ (stage|production) ]]; then
  . ./scripts/dev/tag.sh $ENV
fi

TAG="$(git describe --tags `git rev-list --tags --max-count=1`)"

if ! [[ "$ENV" == "test" ]]; then
  echo "pushing test..."
  git push $ENV $BRANCH -f
else
  echo "pushing $TAG..."
  git push $ENV $TAG
fi
```


## tag.sh

> 1. check if tag is latest
> 2. (if not) request tag and check if tag is valid
> 3. (if not) use `git tag` and push tag to origin

```bash
#!/bin/sh

VERSION="$(git describe)"

if ! [[ $VERSION =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  LASTEST_TAG="$(git describe --tags `git rev-list --tags --max-count=1`)"

  read -p "new tag(current $LASTEST_TAG):" TAG

  if ! [[ $TAG =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo 'tag invalid!'
    exit 1;
  fi

  git tag $TAG -a

  echo "git push origin $TAG"
  git push origin $TAG
fi
```

## hotfix.sh

```bash
#!/bin/sh
HOTFIX_BRANCH=$1
echo "start hotfix $HOTFIX_BRANCH"

# merge hotfix to master
git pull &&
git checkout $HOTFIX_BRANCH &&
git checkout master &&
git merge --no-ff $HOTFIX_BRANCH &&
git push &&

# pub
npm run pub-prod &&

echo 'pub prod success!'

# merge hotfix to develop
git checkout develop &&
git pull &&
git merge --no-ff $HOTFIX_BRANCH &&
git push &&
npm run pub-test
```

## add-feature.sh
```bash
#!/bin/bash
BRANCH=$1
echo "adding feature $BRANCH to develop"

git pull &&
git checkout $BRANCH &&
git checkout develop &&
git merge --no-ff $BRANCH
git push
```

## usage
  1. config package.json
    ```jason
    {
      "scripts": {
        "pub-test": "./scripts/dev/deploy.sh test",
        "pub-stage": "./scripts/dev/deploy.sh stage",
        "pub-prod": "./scripts/dev/deploy.sh production",
        "hotfix": "./scripts/dev/hotfix.sh"
      }
    }
    ```
  2. run with npm
    ```bash
    npm run pub-test
    npm run hotfix hotfix-v1.0.0/...
    ```
