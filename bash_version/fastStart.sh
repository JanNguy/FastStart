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

#git options
git_init=false
git_new_branch=false
git_on_main_branch=false
git_on_o_n=false

#options
push_nb_main=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -g|--git)
        shift
        git_init=true
        shift
        ;;
        -b|--branch)
        shift
        git_on_branch=true
        if [[ $1 == "-n" ]]; then
            git_new_branch=true
            shift
            git_branch_name=$1
        elif [[ $1 == "-o" ]]; then
            git_on_o_n=true
            if [[ $git_new_branch == true && $git_on_o_n == true ]]; then
                git_new_branch=false
                echo "Conflict: selected to push on new branch and on the main."
                echo "Default selected main"
            fi
        fi
        if [[ -z $git_branch_name ]]; then
            echo "Error: New branch error"
        fi
        ;;
        -m|--message)
        shift
        git_message=$1
        shift
        ;;
        -p|--push)
        shift
        git_push=true
        git_path=$1
        shift
        ;;
        *)
          echo "Unknown option: $1"
          shift
        ;;
    esac
done

echo "outside"

if [ $# -ne 1 ] || [ -z "$1" ]; then
    echo -e "$help"
    exit 84
fi

touch "$file"
echo "/*" > "$file"
echo "** EPITECH PROJECT, 2024" >> "$file"
echo "** $cwd" >> "$file"
echo "** File description:" >> "$file"
echo "** $file" >> "$file"
echo "*/" >> "$file"
echo "" >> "$file"
echo "int main(void)" >> "$file"
echo "{" >> "$file"
echo "    return 1;" >> "$file"
echo "}" >> "$file"

echo "Done"
echo "}" >> "$file"

git add $file

if [[ $git_init == true ]]; then
    git_commit_line+=" $git_message"
    if [[ $git_new_branch == true ]]; then
        git branch $git_branch_name
        git_push_line+=" origin $git_branch_name"
    fi
fi

echo "Done"
