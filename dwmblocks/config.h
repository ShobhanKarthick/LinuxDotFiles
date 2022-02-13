//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
    {"", "db-cpu-temp", 90, 3},
    {"", "db-memory", 90, 4},
    {"", "db-datetime", 60, 1},
    {"", "db-volume", 0, 10},
    {"", "db-battery", 10, 5},
    {"", "db-wifi", 0, 6},
    {"", "db-bluetooth", 0, 7},
    {"", "db-power", 0, 8},
};

//Sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char *delim = " | ";

// Have dwmblocks automatically recompile and run when you edit this file in
// vim with the following line in your vimrc/init.vim:

// autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }
