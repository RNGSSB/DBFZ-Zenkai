# DBFZ BBS editing pack v1.5
# Use in conjunction with DBFZ BBS doc ( https://docs.google.com/document/d/1r8Uv-jz6R8VQuGp42_XV42vl4a1ZdWyxUEDlduMI3vM/edit?usp=sharing )


Getting scripts:
	Vanilla DBFZ 1.31 data has been included in [ vanilla resources ]. In there you'll also find a script called [ extract_parse_copy.cmd ].
	If you run it, it'll do some magic and then dump all the .bbs files straight into [ vanilla resources ].
	
	If you want to add and edit one of these scripts to your own mod, drag and drop the .bbs files onto [ extract_parse_copy.cmd ].
	This will automatically copy the matching .uexp and .uasset files to the correct directory as well.
	
	Note: You can drag and drop multiple files, but don't go too crazy 'cause it'll greatly increase the filesize of your mod, and slow down the parsing and packing of it.


Modifying the scripts and getting them into the game:
	Go up a directory and then go into [ ZMOD ]. You'll find your script there, provided you succesfully completed the step above.
	You can simply edit the script with any text editor, then save your changes.

	To get your edited script into the game, simply run [ pack_mod.cmd ] in the main [ DBFZ BBS editing ] folder.
	The very first time it'll ask you to drag and drop DBFighterZ.exe into the window. This is saved to the script, so you don't have to do this every time you start it.
	After that it'll do everything automatically, and from then on only requires a single keypress* to rebuild and package everything at once (and by default it'll launch the game as well).


How to properly remove a script from your mod:
	Remove the .bbs script from [ ZMOD ].
	Inside [ ZMOD ] there's also a directory called [ uasset_uexp ]. Delete both the .uexp and the .uasset files that match your character code from it.

	Go to [ u4pak\mod\Red\Content\Chara ] and you'll also find subdirectories matching the game's character codes. You can either delete those folders entirely, or only the .uexp and .uasset files inside them.
	Note: BBS_<charcode>EF.bbs scripts are stored inside that same character's directory!


FAQ:
	Q: How do I edit .bbs files?
	A: You can use any text editor. Notepad++ ( https://notepad-plus-plus.org/ ) is one of the most popular ones , because it has nice quality-of-life features and supports custom syntax highlighting.

	Q: How do I change hurt- and hitboxes?
	A: You can only deactivate hurtboxes in BBScript, and even that relies on a somewhat ugly hack. The Unreal Anime Mods Discord has tutorials on how to mod hitboxes.
	
	Q: What is UnknownXXXX: ?
	A: These are functions that we don't have good names for yet. Check out the DBFZ BBS doc to find the most up-to-date information.

	Q: Which character codes belong to which characters?
	A: https://docs.google.com/spreadsheets/d/10m1rGU7_W_VDCMGr2WfJDmFYrTg2-JPbhbfS4qKpqJ0/
	
	Q: Will this affect my Unverum mods?
	A: Unverum overwrites the contents of the ~mods folder before launching the game. Your packaged bbscript mod is deleted.
	
	Q: Where is my packaged mod located? Can I use it with Unverum?
	A: The required .pak and .sig are inside the u4pak directory. You can add it to your Unverum, but keep in mind that that version won't be automatically updated by [ pack_mod.cmd ].
	If you're smartsmartsmart, you can figure out how to do that by editing [ pack_mod.cmd ] yourself. You only have to change the directory at the bottom of the script, and set it to not launch the game upon completion.


Credits:
	https://twitter.com/UltIMa647/
	https://twitter.com/SaitsuMD
	https://twitter.com/Pangaea__
	https://twitter.com/WistfulHopes
	
	Unfortunately I have to cut this short, but a lot of good people are involved in Arcsys modding.
	Please check out the DBFZ bbs doc for an up-to-date list, or hit up the Unreal Anime Mods Discord to talk with 'em.


3rd party tools that actually do all the heavy lifting:
	https://github.com/super-continent/bbscript
	https://github.com/panzi/rust-u4pak
	https://github.com/super-continent/ggst-bbs-unpacker


Notepad++ tips:
	CTRL+SHIFT+F = Search in files. Set the directory to [ vanilla resources ] and you'll be able to easily look for all vanilla uses of certain functions. Very, very useful.

	Use bookmarks to keep track of changes and to do things like mark subroutine positions! This video guide goes through everything you'll want (just set playback speed to 1.5x...): https://www.youtube.com/watch?v=QZH-wxHtpwI
	The script files are far too long for you to waste your time constantly scrolling through them.

	There's a custom .bbs syntax highlighting theme to help you distinguish between different functions. It can be found on the Unreal Anime Mods Discord.