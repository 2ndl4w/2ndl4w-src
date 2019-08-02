#!/bin/bash

# 1.1 start ghost local
ghost start
echo "Ghost start successfully."

# start ghost-static-site-generator to fetch from working
gssg --url https://2ndl4w.github.io
if 
    [ -d "static" ] 
then 
    echo "Directory static/ exists."
    # Fix absolute path problem
    while read a ; do echo ${a///assets/assets} ; done < static/index.html > static/index.html.t ; mv static/index.html{.t,}
else 
    echo "Directory static/ does not exist. script stopped."
fi

# move ghost static generated site to the github pages repo
shopt -s dotglob nullglob
cd ..
if
    [ -d "2ndl4w.github.io" ]
then
    echo "Directory 2ndl4w.github.io/ exists."
    mv 2ndl4w-src/static/* 2ndl4w.github.io
else
    echo "Directory 2ndl4w.github.io/ doesn't exists."
    git clone https://github.com/2ndl4w/2ndl4w.github.io.git
    mv 2ndl4w-src/static/* 2ndl4w.github.io
fi

# push updates to git
cd 2ndl4w.github.io
git add .
git commit -m "blog update"
git push
open https://2ndl4w.github.io
