#################################################################
# File: 	Makefile
# Author: 	maym
# Date: 	2017-04-17 19:50:44
# Description:
# 	Install dotfile to user home directory, or uninstall 
# 	dotfile from user home directory.
#################################################################
.PHONY: all install uninstall depend

all:
	@echo -e "\033[33mUsage: make [install|uninstall]\033[0m"

install:
	@echo -e "\033[32mInstall dotfiles to user home directory...\033[0m"

	@for i in `ls -a | grep -E -vw '.|..|Makefile|.git'`; do \
		install -m 600 $$i ~; \
	done

	@echo -e "\033[32mDone.\033[0m"

uninstall:
	@echo -e "\033[32mUninstall dotfile...\033[0m"

	@for i in `ls -a | grep -E -vw '.|..|Makefile|.git'`; do \
		rm -f ~/$$i; \
	done

	@echo -e "\033[32mDone.\033[0m"

depend:
	@echo -e "\033[32mStart make depend software list...\033[0m"

	@if [ ! -f customsoft ]; then \
		echo -e "\033[31mfile: customsoft not exist!\033[0m"; \
		exit -1; \
	fi

	@echo -e '\n# DO NOT DELETE THIS LINE -- depend use it' >> Makefile 
	@soft_list="soft_list = "; \
	cat customsoft | grep -w '#' | cut -d: -f1 | cut -d' ' -f2 | \
	while read soft; do \
		soft_list=($${soft_list[@]} $$soft); \
		echo $${soft_list[@]} > depfile; \
	done
	@cat depfile >> Makefile
	@rm -f depfile

	@echo -e "\033[32mDone.\033[0m"

softinstall:
	@apt install -y $(soft_list)

# DO NOT DELETE THIS LINE -- depend use it
soft_list = mutt msmtp w3m vim cmus htop tmux
