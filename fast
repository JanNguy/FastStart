#!/bin/bash

# Initialisation des variables
name=""
help="FastStart help\n\nUsage: fastStart.sh [NAME OF THE PROJECT] [OPTIONS]"

# Variables par défaut
cwd=$(pwd)
file=""

# Variables git
git_init=false
git_branch_name=""
git_message=""
git_push=false
git_new_branch=false

# Variables fichier
arg=false
h_file=false
makef=false

# Fonction pour afficher l'aide
show_help() {
    echo -e "$help"
    echo "Options:"
    echo "  -g          Initialize git repository"
    echo "  -b NAME     Create and checkout new git branch"
    echo "  -m MESSAGE  Git commit message"
    echo "  -p          Push to remote repository"
    echo "  --arg       Add argument handling to main function"
    echo "  --h         Add header file"
    echo "  --makef     Create Makefile"
    exit 0
}

# Traitement des arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            show_help
            ;;
        -g)
            git_init=true
            shift
            ;;
        -b)
            git_branch_name="$2"
            git_new_branch=true
            shift 2
            ;;
        -m)
            git_message="$2"
            shift 2
            ;;
        -p)
            git_push=true
            shift
            ;;
        --arg)
            arg=true
            shift
            ;;
        --h)
            h_file=true
            shift
            ;;
        --makef)
            makef=true
            shift
            ;;
        -*)
            echo "Option inconnue: $1" >&2
            exit 1
            ;;
        *)
            if [[ -z "$name" ]]; then
                name="$1"
                file="$name.c"
                shift
            else
                echo "Nom du projet déjà spécifié: $name" >&2
                exit 1
            fi
            ;;
    esac
done

if [[ -z "$name" ]]; then
    echo -e "$help"
    exit 1
fi

mkdir -p src
touch "src/$file"

if [[ "$h_file" = true ]]; then
    cat patterns/header.txt > "src/$file"
fi

if [[ "$arg" = true ]]; then
    cat patterns/base_arg.txt >> "src/$file"
else
    cat patterns/base_no_arg.txt >> "src/$file"
fi

if [[ "$makef" = true ]]; then
    cp patterns/makefile.txt Makefile
    sed -i.bak "s/__NAME__/$name/g" Makefile && rm -f Makefile.bak
fi

sed -i.bak "s/__NAME__/$name/g" "src/$file" && rm -f "src/$file.bak"

if [[ "$h_file" = true ]]; then
    mkdir -p includes
    touch includes/my.h
    cat patterns/header_file.txt > includes/my.h
    sed -i.bak "s/__NAME__/$name/g" includes/my.h && rm -f includes/my.h.bak
    sed -i.bak '1i\

#include "my.h"
' "src/$file" && rm -f "src/$file.bak"

    if [[ "$arg" = true ]]; then
        sed -i.bak "s/__ARGS__/int ac, char **av/g" includes/my.h && rm -f includes/my.h.bak
    else
        sed -i.bak "s/__ARGS__/void/g" includes/my.h && rm -f includes/my.h.bak
    fi
fi

# Gestion Git
if [[ "$git_init" = true ]]; then
    git init

    files_to_add=("src/$file")
    [[ "$makef" = true ]] && files_to_add+=("Makefile")
    [[ "$h_file" = true ]] && files_to_add+=("includes/my.h")

    git add "${files_to_add[@]}" 2>/dev/null

    if [[ -n "$git_message" ]]; then
        git commit -m "$git_message"
    else
        git commit -m "Initial commit"
    fi

    if [[ "$git_new_branch" = true ]] && [[ -n "$git_branch_name" ]]; then
        git checkout -b "$git_branch_name"
    fi

    if [[ "$git_push" = true ]]; then
        branch_to_push="${git_branch_name:-main}"
        git push -u origin "$branch_to_push" 2>/dev/null || echo "Push failed - is the remote repository set up?"
    fi
fi

echo "Done"
