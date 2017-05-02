#!/bin/sh
set -eux

DOTFILES_DIR=${HOME}/dotfiles

cd ${DOTFILES_DIR}

# make linkefiles except for ".git" or ".gitinnore"
for i in .??*
do
	[[ ${i}=".git" ]] && continue
	[[ ${i}=".gitignore" ]] && continue
	ln -snfv ${DOTFILES_DIR}/${i} ${HOME}/${i}
	# echo ${DOTFILES_DIR}/${i} ${HOME}/${i}
done
