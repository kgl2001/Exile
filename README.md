# Exile Loader disassembly

Buildable copy of the Exile Loader file.

# Summary

Download the ```EliteL.asm``` file, and build using ```BeebASM```:

```beebasm -w -v -i ExileL.asm > ExileLV3.lst```

There are three different build options, which can be adjusted at the top of the ```EliteL.asm``` file

- ```FSN```: Select ```DFS``` for a disc build or ```NET``` for an econet build
- ```STRIP```: Select ```TRUE``` to strip out redundant code or ```FALSE``` to retain
- ```Version```: Select ```STH``` for a build based on the loader from ```STH``` disc image, or V3 for loader from the Release 3 disc image

```DFS``` / ```FALSE``` / ```STH``` will rebuild the original ```ExileL``` file from the STH disc image.  
File SHA1: c3d934b5c4e039aa76ce25e360e04c1f71468132

```DFS``` / ```FALSE``` / ```V3``` will rebuild the original ```ExileL``` file from the Release 3 disc image.  
File SHA1: cb8a12fad92fcfc139caa2e9107e807d3aa952d6

# The Various Exile Release Disc Images

There are at least four different release disc images of Exile in existence.

- Release 1: ```Exile_D1S1_80T_HG3_2066CA7D_1.hfe```
- Release 2: ```Exile_D1S1_80T_HG3_EA8CECA2_1.hfe```
- Release 3: ```Exile_D1S1_40T_HG3_0E245387_1.hfe``` / ```Exile_D1S2_80T_HG3_162468BD_1.hfe```

These three releases are available for download from here:

https://drive.google.com/drive/folders/1aHulFQixLOs03Vxop1Zu9v2_0Oauaxdb

They all have some level of disk copy protection and code obfuscation.

The files from the Release 3 disc image have been extracted and decrypted as part of this project. These decrypted files have been packaged into another disc image, and are available for download from the stardot forums:

https://stardot.org.uk/forums/viewtopic.php?p=444883#p444883

It is worth highlighting that although the files have been decrypted, they have not been modified in any other way, and a level of copy protection, requiring the user to enter a word from the supplied novella in order to proceed, is still active on this disc.

- Release 4: ```Exile.zip```

This forth release is available for download from the Stairway To Hell (STH) software archive site:

https://www.stairwaytohell.com/bbc/archive/diskimages/Superior/Exile.zip

This disc image is not copy protected, and the code can be read without any decryption. There is no novella copy protection on this disc image either.


# Associated Game File Disassemblies

The main game files, ExileB and ExileMC, have previously been disassembled by level7. The full disassembly can be found here:

https://www.level7.org.uk/miscellany/exile-disassembly.txt

It is not clear what original binary files were used for this disassembly.

This disassembly was then refined by tom_seddon, who created a version that can be re-assembled using BeebASM. A few minor changes to the level7 disassembly were required in order to build a version that was an identical match to the binary files included in the disc image from the STH archive. This work can be found here:

https://github.com/tom-seddon/exile_disassembly/


# Running Exile from an Econet File Server

Until now, using the STH release disc, it has not been possible to run Exile from an Econet file server. Although the loader file, ```ExileL```, would load from the file server, any attempt to run the game by pressing ```f0``` would fail. By monitoring Econet network activity it could be seen that no attempt was even being made to load the main binary files ```ExileB``` or ```ExileMC```.

A quick review of the loader file revealed that NMIs were being claimed by the loader:

```
7302   A9 8F      LDA #&8F
7304   A2 0C      LDX #&0C
7306   A0 FF      LDY #&FF
7308   20 F4 FF   JSR &FFF4
```
This prevents Econet from working correctly, and patching out this code resulted in the main binary files loading successfully. However, there were still a couple of issues that needed to be dealt with.

Firstly, patching out the code that claims NMIs has the potential to impact the main game, particularly if there is unrelated Econet traffic on the network whilst the game is being played. This is easily addressed by adding a bit of stub code to the end of the main game binary files, ExileB and ExileMC and running this stub code before then running the main binary. It is possible to do this, because once the main game is loaded, no further Econet access is required.

Secondly, the loader is also used to load & save game state, and is used to read a disc catalogue. Unsurprisingly, these functions are tailored for use with a floppy disc, and are not particularly compatible with the Econet file server. As an example, the loader will ask for a drive number, which is not really relevant for Econet. Further patching required...

# The Loader file disassembly

Whilst it was possible to further patch the loader file to deal with the load & save game state, and to read a disc catalogue, the amount of changes required made the disassembly / re-assembly process more attractive. And so, armed with the excellent ```py8dis``` disassembler:

https://github.com/ZornsLemma/py8dis

which creates a ```BeebASM``` compatible assembly file from a 6502 binary file, a first pass disassembly was produced using the STH ExileL file as the source binary. Py8dis only takes the disassembly so far, though, and analysis of the file is still required to locate pointers to tables, and to link these pointers to the tables so if the code or tables move the links will not be broken. A copy of the py8dis control file, which was developed to manage the disassembly, will be uploaded to this site in due course.

At this point, it became apparent that a lot of code used in the main game binary files is duplicated in the loader file, such as the map and sprite routines and tables. This made it possible to blindly copy over a significant amount of comments from the previous disassembly work on the main binary files. Little attempt was been made to understand how some of this quite complex code actually works in the loader!

Once the source loader file had been sufficiently disassembled, and after fixing a couple of issues, ```BeebASM``` was able to take this new assembly file, and from that reproduce the original STH ```ExileL``` binary file.

This then allowed the assembly file to be modified to make the load, save and catalogue functions compatible with Econet. An updated disc image with this new loader file, and the updated ```ExileB``` / ```ExileMC``` files with the extra stub code have been uploaded to the stardot forums:

https://stardot.org.uk/forums/viewtopic.php?p=444874#p444874

This disc image in not intended to be used to run the game from disc. The files from this image should be copied over to a suitable directory on the Econet file server, and a ```SAVES``` subdirectory should also be created for the load, save and catalogue functions to operate correctly.

It is possible to build either the original disc based loader file or the modified Econet based loader file. Simply change a line at the top of the assembly file between ```FSN = DFS``` and ```FSN = NET```

# Building the Loader file from the Release 3 disc image.

When reviewing the disassembled loader file from the STH disc image, it was observed that two small sections of code had been ```NOP'd``` out. It is not clear if the game was shipped like this, or it it has been modified subsequently. This triggered the extraction and decryption of the loader file from the copy protected & obfuscated Release 3 disc image, so a comparison could be made.

There are several differences between the STH version and the Release 3 version:
- Most notably, a chunk of code on the STH version relocates to address 0x1500, whereas on the Release 3 version, this same code relocates to   address 0x1700.
- The ```NOPs``` also didn't exist in the Release 3 version; in one position, the ```NOP``` instructions are wholly replaced with two lines of code, and in the other position, the code had been shrunk to completely remove the ```NOPs```.

As the differences between the two ```ExileL``` files are relatively small, it was quite simple to update the assembly file so that it can build a binary loader file based on either the STH source or the Release 3 source. Simply change a line at the top of the assembly file between ```Version = STH``` and ```Version = V3```

As with the STH version, it is possible to build either the original disc based loader file or the modified Econet based loader file for the Release 3 version. Simply change a line at the top of the assembly file between ```FSN = DFS``` and ```FSN = NET```

A disc image, containing an Econet version of the Release 3 build has also been upload to the stardot forums:

https://stardot.org.uk/forums/viewtopic.php?p=445697#p445697

Like the STH build, the main game binary files have been modified to include the extra stub code to claim the NMIs. As with disc version, novella copy protection is still active on the main game binary files. Again, this disc image should be used only to copy files over to the Econet file server.

# Removing redundant code & data

There are several orphaned pieces of code and sections data within the loader file that can be stripped out of the builds. Simply change a line at the top of the assembly file between ```STRIP = TRUE``` and ```STRIP = FALSE```

