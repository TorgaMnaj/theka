#!/bin/bash
# This script is supposed to run from Makefile in parent directory.
# Commit requires long and short description as well as version of commit number.
if [ ! -d .git ]
then
	cd ..
	if [ ! -d .git ]
	then
		echo "
		
		I cant find .git directory! Terminating.
		
		"
		exit 1
	fi
fi

clear
echo "


Printing GIT STATUS:

"
sleep 1
git status

github () {
if [ -e .github ]
then
	git push origin master && echo "Pushed to github."
fi
}

commit () {
	clear
	echo "Enter changelog number: "
	read number
	echo "Enter short description: "
	read sdesc
	echo "Enter long description:
	"
	read ldesc
	head="$number - $sdesc"
	# Testy:
	./venv/bin/python3 -m pytest tests/ || echo "
	Testy se nezdařily anebo neproběhli.
	"
	# Commit and push.
	echo "--- $head" >> changelog && echo "    $ldesc" >> changelog && echo "" >> changelog && git add changelog
	git commit -m "$head" -m "$ldesc" && github && \
	echo "
	Cummit, kontrola a zápis do changelogu provedeny.
	" || echo "
	Commit a kontrola se nezdařily."
}

sleep 1
while true
do
	echo "

	Do You want to add some files and changes to git, before proceeding?
	Press 'c' for proceeding commit or 't' for terminating and manualy adding changes to git.
	"
	read answer

	case $answer in
	c|C)
		commit
		break
		;;
	t|T)
		break
		;;
	*)
		echo "
		Neplatný znak! Znovu.
		"
		sleep 1
		clear
		;;
	esac
done

exit 0
