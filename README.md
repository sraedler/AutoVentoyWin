# Ventoy template for unattended Windows installation

In this repository, a basic template for an unattended setup of Windows10/11 is given.
The repository consists of various tools supporting the installation of Windows10/11, with little user interaction.

## Quickstart

 1. Create a bootable USB disc using [Ventoy](https://github.com/ventoy/ventoy/)
 2. Copy all files in the repository on the USB (using the same folder structure)
 3. Download a Windows installation ISO and put it in the ISO folder (tested with Win11_German_x64v1.iso)
 4. Adapt the scripts if necessary

## What happens during the execution?

 1. The xml configurations under ventoy\config\ call the CreateSetup.cmd script in the SetupComplete folder.
 2. CreateSetup.cmd does the following
	 1. Create a temporary folder on the system drive
	 2. Copy all files from the SetupComplete folder to the temporary folder
	 3. Checks for internet access and supports to connect to wifi (just a beta script)
	 4. Download snappy driver installer (so to allow to download and install Windows drivers)
	 5. Download [Office Tool](https://github.com/YerongAI/Office-Tool) to allow the unattended installation of Office
	 6. Download and install [chocolatey](https://chocolatey.org/) for further unattended installations
	 7. After the automatic system reboot, the SetupComplete.cmd is executed, which installs:
		 1. Office 2021 using Office Tool
		 2. Execute Ninite.exe tool with valuable tools such as Chrome 
		 3. Install adobereader and lockhunter (note: an error occurs with lockhunter caused by the impossibility to open the browser at this stage of windows) using chocolatey
	8. The setup files are finally removed from the system

## How to extend the approach?
There are some things you can do to extend the approach

### Windows.xml
Change the xml file to change things. TODO not described yet.
### Download files and install them
Do it accordingly to the Office Tools sample in CreateSetup and further execute it using SetupComplete
### Add static files and install them
See the example of Ninite.exe in SetupComplete.cmd. 
You can also put the files under another dir, but you have to specify it.

## TODOs
 - Optimize the structure so that it is more maintainable.
 - Extract the download function of CreateSetup so that it can be called in a function.
 - Improvement of the alpha version of the Wifi tool which is required and IMHO very helpful.
 - Allow to install softwares and downloads in parallel to improve performace.
 - Add a script that downloads all the files to the USB, allowing to install without the necessity to download everything all the time.
 - Many others....

## Contribution
Please feel free to fork this repo and send a pull request if you want to contribute to this project.

Notice that this project is in a beta version. Not all features are tested well, which might lead to bugs.

## Thanks
Special thanks to the developer of ventoy and the support of easy2boot, which inspired me of that solution!

## Legal Rights
This template with scripts is for personal purpose and I strongly encourage to only use alignet with your countries law.