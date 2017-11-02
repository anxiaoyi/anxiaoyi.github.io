#!/bin/bash

_BLOG_WHICH=`which zk-blog`
_SCRIPT_PATH=`readlink -f $_BLOG_WHICH`

function main() {
    case $1 in
        'run')
            hexo_run
            ;;
        'clean')
            hexo_clean
            ;;
        'ssh')
            ssh_conn
            ;;
        'commit')
            git_commit
            ;;
        'emacs')
            run_emacs
            ;;
        'pull')
            git_pull
            ;;
        'deploy')
            github_deploy
            ;;
        *)
            echo 'Usage: zk-blog [run | clean | ssh | commit | pull | emacs | deploy]'
            exit 1
    esac
    
    exit 0
}

function hexo_run() {
    DIR_NAME=`dirname $_SCRIPT_PATH`
    cd `dirname $DIR_NAME`
    sudo hexo serve --draft
}

function hexo_clean() {
    DIR_NAME=`dirname $_SCRIPT_PATH`
    cd `dirname $DIR_NAME`
    sudo hexo clean
}

function ssh_conn() {
    ssh root@59.110.168.119    
}

function git_commit() {
    cd `dirname $_SCRIPT_PATH`
    git add --a
    git commit -m 'update blogs'
    git push origin master
}

function git_pull() {
    cd `dirname $_SCRIPT_PATH`
    git pull origin master
}

function run_emacs() {
    DIR_NAME=`dirname $_SCRIPT_PATH`
    LC_CTYPE='zh_CN.UTF-8' emacs "$DIR_NAME/_posts"
}

function github_deploy() {
    DIR_NAME=`dirname $_SCRIPT_PATH`
    cd `dirname $DIR_NAME`
    hexo generate
    cp source/CNAME public/
    cd public/
	git init
	git remote add origin git@github.com:anxiaoyi/anxiaoyi.github.io.git
	rm -f *.java
	rm -f *.class
	git pull origin master
    git add --a
    git commit -m 'update site'
    git push origin master
}

main $1
