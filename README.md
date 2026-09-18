[![github](https://img.shields.io/github/stars/veebch?style=flat&logo=github&logoColor=black&labelColor=white&color=ffed53)](https://www.github.com/veebch)


# Sebastian

Instructions/printable parts for a very bare bones Linux desktop computer using the Raspberry Pi Touch 2 (10 inch), a compute module (CM5) and a Waveshare Power over Ethernet (PoE) carrier board. The PoE is not used in this project, but it's there if you need it.

Named after a man [that builds things to keep himself company](https://bladerunner.fandom.com/wiki/J.F._Sebastian).
# Video

This video shows how we built ours.

[![YouTube](http://i.ytimg.com/vi/nDxcVeEeYJc/hqdefault.jpg)](https://www.youtube.com/watch?v=nDxcVeEeYJc)


# Use cases

- A dead-simple machine for people you love who find tech intimidating - no window manager quirks, no clutter, just a screen that does what it needs to.
- It's just Raspberry Pi OS underneath, so you can set up [RPi Connect](https://www.raspberrypi.com/software/connect/) and remote in to help out (or just check in) without them having to do anything on their end.
- A wall-mounted or countertop kiosk - photo frame, dashboard, calendar.
- A small, low-power desktop for someone who mostly just needs to browse, video call, and run a couple of apps.

# Components

- Raspberry Pi Touch 2 (10 inch)
- Raspberry Pi Compute Module 5
- Waveshare [PoE carrier board](https://www.waveshare.com/cm5-poe-base-a.htm) for CM5
- 3d printed enclosure/stand
- 1 magnet ([link](https://www.amazon.de/-/en/dp/B08K39Q1DL)) - holds the stand in place when you pick up the unit
- NVME drive
- Cooling Fan
- 4 standoffs (to attach the cover.stl file to the carrier board/screen)
- 1 small nut and bolt (to attach the magnet to the stand)

# Assembly

STL and FreeCAD source files for the enclosure/stand are in [3d/](3d/) - print `stand.stl`, `power-button.stl`, `ports-cutout.stl` and `cover.stl`. The stand can be edited in the FreeCad file `stand.FCStd`.

1. Fit the CM5 onto the Waveshare PoE carrier board.
2. Connect the Touch 2 display's cable to the **DSI2** port on the carrier board (this is the port `rotate-screen.sh` expects, via the `DSI-2` output name).
3. Attach the fan (optional).
4. Add the standoffs, then attach your printed cover, ports cutout and button (lip inside the case, long end facing out).
5. Using the nut and bolt, attach the magnet to the recess in the stand (this bit is optional too, but it stops the screen falling out of the stand when you pick it up, also, who doesn't love magnets).

# Software

The single tweak to the standard desktop panel is the landscape/portrait mode toggle.

## Setup

### 1. Flash the OS onto a micro SD card

On another computer, download and install [Raspberry Pi Imager](https://www.raspberrypi.com/software/), then use it to write the latest 64-bit Raspberry Pi OS (**Desktop** version, not Lite) to a micro SD card.

Before writing, click the gear icon (or "Edit Settings") in the imager to set a hostname, username/password, and enable SSH. Doing this now means you can control the device over the network later without needing to plug a keyboard, mouse and monitor into it.

### 2. First boot

Insert the micro SD card into the Waveshare carrier board and power it on. Give it a minute or two to boot up.

You now need a terminal on the device itself. Either:

- plug a keyboard, mouse and monitor into the device and open a terminal from the desktop, or
- from another computer on the same network, open a terminal and run `ssh <username>@<hostname>.local`, using the username and hostname you set in Raspberry Pi Imager.

### 3. Move the OS onto the NVME drive

The SD card is only there to get things started - everything below moves the OS onto the (much faster) NVME drive.

In the terminal on the device, install and run [rpi-clone](https://github.com/geerlingguy/rpi-clone):

```
curl https://raw.githubusercontent.com/geerlingguy/rpi-clone/master/install | sudo bash
sudo rpi-clone nvme0n1
```

Follow the on-screen prompts to confirm the clone. Once it's finished, power off the device, remove the micro SD card, and power it back on - it should now boot from the NVME drive instead.

### 4. Get this repo onto the device

The rest of this guide is run from a terminal on the device, either directly or over SSH as in step 2.

"Cloning" a repo just means downloading a copy of it, including its history, using the `git` command. Raspberry Pi OS comes with `git` pre-installed, so you can go straight to:

```
git clone https://github.com/veebch/sebastian.git
cd sebastian
```

(If you'd rather avoid the command line for this bit, you can also download the repo as a zip: go to [github.com/veebch/sebastian](https://github.com/veebch/sebastian), click the green "Code" button, then "Download ZIP", and extract it, then `cd` into the extracted folder instead)

### 5. Install wlr-randr

`rotate-screen.sh` uses `wlr-randr` to change the display orientation, and it isn't installed by default on Raspberry Pi OS:

```
sudo apt update
sudo apt install wlr-randr
```

### 6. Install the rotation script

Copy the script into `~/bin` (a folder for your own scripts/programs) and make it executable so it can be run directly:

```
mkdir -p ~/bin
cp rotate-screen.sh ~/bin/rotate-screen
chmod +x ~/bin/rotate-screen
```

### 7. Add ~/bin to your PATH

`$PATH` is the list of folders the shell searches when you type a command name. Adding `~/bin` to it means you (and the panel) can run `rotate-screen` from anywhere, without typing the full path. Add this line to `~/.bashrc` (or `~/.profile`) if it isn't already there, then reload your shell:

```
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### 8. Install the panel config

This adds a rotate button to the taskbar/panel:

```
mkdir -p ~/.config/wf-panel-pi
cp wf-panel-pi.ini ~/.config/wf-panel-pi/wf-panel-pi.ini
```

Log out and back in (or restart the panel) for the new launcher to appear.

I highly recommend adding some of the newer Linux terminal tools, outlined [here](https://www.veeb.ch/projects/2026-linux-commands)

# Contributing

This is a one-off build we're sharing, not a polished product - if you spot something that could be clearer, cheaper, or better designed, fork the repo and send a PR. Building your own version and telling us what you'd change is just as welcome.

We are often a bit too brief in our READMEs, so Claude helped edit this one - reorganizing sections, numbering steps, fixing wording, and filling in setup details - all reviewed by us before merging. The build itself, its design, and the facts in this README are ours; no code, video or 3D models were AI-generated. Commits with AI-drafted text carry a `Co-Authored-By: Claude` trailer, so you can spot exactly which ones they are.
