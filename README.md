#PABuffs

This repository represents my personal updates to Adelea's PABuffs addon for RIFT.   For more information on the addon (including Adelea's original release notes, information, etc.) please visit http://rift.curseforge.com/addons/pabuffs/.

I only intend to update this addon for my own personal use, and make no promises for keeping it updated in the future.   Please review the commit notes for anything that I have changed and/or added to the addon, etc.

####New Installation
1. Click the "Download Zip" button above and to the right of the list of repository files above.
2. Extract the contents of the zip file to your RIFT Addons directory (typically, but not always, c:/users/USER_NAME/Documents/RIFT/Interface/Addons).   If you cannot find it, you can always start the game, and then at character select click the "Addons" button, and then when the addons window opens, click the "Open Addon Directory" button.   When you finish this step, you should have a directory like so:  .../RIFT/Interface/Addons/PABuffs-master
3. Rename the extracted directory FROM "PABuffs-master" TO "PABuffs"

####Upgrade Existing Installation
1. Click the "Download Zip" button above and to the right of the list of repository files above.
2. Go to your "PABuffs" directory (typically, but not always, c:/users/USER_NAME/Documents/RIFT/Interface/Addons/PABuffs).   If you cannot find it, you can always start the game, and then at character select click the "Addons" button, and then when the addons window opens, click the "Open Addon Directory" button.
3. Open the zip file you downloaded, and click to enter the "PABuffs-master" directory within it.   Copy everything therein to your local "PABuffs" addon directory, overwriting all files.

####Submit New Abilities
If you have planar abilities which are not yet included in this addon, you may submit the necessary information by creating an issue here:  https://github.com/Amadeus-/PABuffs/issues     The information needed can be found by typing the following command in your main chat window:  "/PAB list".    This command will print a list of your planar abilities which are not (yet) supported by PABuffs.   *(The list is in this format:  "ABILITY_NAME :: ABILITY_ID".)*

*(NOTE:  To make it easier to copy/paste the ID(s), you may wish to type the command "/log on", then "/PAB list", and then "/log off".   This will save the output of the command to a file in your /Documents/RIFT folder called Log.txt.)*

For each planar ability that you see listed (which you feel should be included in the addon), the following information will be needed
1. The ABILITY_NAME
2. The ABILITY_ID
3. The name of the ability for which it is an upgrade
