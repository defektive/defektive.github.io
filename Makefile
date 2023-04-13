dev::
	hugo server

spellcheck::
	@find content/ -name '*.md' -exec aspell -x -p `pwd`/.aspell.en.pws --repl=`pwd`/.aspell.en.prepl -c {} \;