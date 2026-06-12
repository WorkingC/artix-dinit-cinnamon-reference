# Artix Linux, artix-dinit-cinnamon reference
These notes assume you chose a version that has a built-in desktop environment on the installer. For this, I chose dinit-cinnamon. 

These notes are divided by the components they focus on installing and configuring, including any extremely hackish workarounds we do to work with Cinnamon's compositor, muffin. Additional bash scripts and boot scripts will be cited in the reference, and they'll be found in shell-scripts and boot-scripts respectively. 

This is written for someone freshly coming from Windows and still having that expectation for the user interface. That's why Cinnamon is the chosen desktop environment. Almost everything done in this guide does not directly use Cinnamon's system settings, and where it does, I'll specifically cite those instances. 

## When you see "sudo nano"
This might be frowned upon, but you do not have to use the terminal text editor to edit files, which is good given how unwieldy it can be. You could instead use a different text editor, something like Kate, Leafpad, or Cudatext. In those cases, you still run them with sudo, but as ```sudo cudatext``` or similar. Some text editors, like Kate, will flash up a warning about launching as sudo. Just follow their instructions. 

Likewise, you do not have to access those files through the terminal. If it's your preference to browse 
