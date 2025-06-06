#!/bin/bash

#getopts
name=$1
help="FastStart help\n\nUsage: fastStart.sh [NAME OF THE PROJECT]"

#Basics
cwd=$(pwd)
file="$name.c"

#git variables
git="git"
git_commit_line="git commit"
git_push_line="git push"
git_message=""
git_path="."
git_branch_name=""
git_push=false

#git options
git_init=false
git_new_branch=false
git_on_main_branch=false
git_on_o_n=false

#file option
arg=false
h_file=false
makef=false

#options
push_nb_main=false

# Correction de la boucle getopts
while getopts "gb:m:p:-:" opt; do
    case $opt in
        g) git_init=true;;
        b) git_branch_name="$OPTARG"; git_new_branch=true;;
        m) git_message="$OPTARG";;
        p) git_push=true;;
        mf) makef=true;;
        -)
            case "${OPTARG}" in
                arg) arg=true;;
                h) h_file=true;;
                *) echo "Option inconnue: --$OPTARG" >&2; exit 1;;
            esac
            ;;
        *) echo "Option inconnue: -$OPTARG" >&2; exit 1;;
    esac
done

echo "outside"

if [ $# -ne 1 ] || [ -z "$1" ]; then
    echo -e "$help"
    exit 84
fi

mkdir -p src
touch "src/$file"

if [ "$h_file" = true ]; then
    cat patterns/header.txt > "src/$file"
fi

if [ "$arg" = true ]; then
    cat patterns/base_arg.txt > "src/$file"
else
    cat patterns/base_no_arg.txt > "src/$file"
fi

if ( "$makef" == true); then
    touch Makefile > $"patterns/makefile.txt"

sed -i "s/__NAME__/$name/g" "src/$file"

if [ "$h_file" = true ]; then
    echo "#include \"my.h\"" >> "src/$file"
    mkdir -p includes
    touch includes/my.h
    cat patterns/header_file.txt > includes/my.h
    sed -i "s/__NAME__/$name/g" includes/my.h
    if [ "$arg" = true ]; then
        sed -i "s/__ARGS__/'ac, av'/g" includes/my.h
    fi
fi

if [ "$git_init" = true ]; then
    git init
    git add .

    if [ -n "$git_message" ]; then
        git commit -m "$git_message"
    else
        git commit -m "Initial commit"
    fi

    if [ "$git_new_branch" = true ]; then
        git branch "$git_branch_name"
        git checkout "$git_branch_name"
    fi

    if [ "$git_push" = true ]; then
        git push -u origin "$git_branch_name"
    fi
fi

echo "Done"
