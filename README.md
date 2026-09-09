# Sebastian

Instructions/printable parts for a very bare bones Linux desktop computer using the Raspberry Pi Touch 2 (10 inch), a compute module (CM5) and a Waveshare PoE carrier board. The PoE is not used in this project, but it's there if you need it.

Named after a man [that builds things to keep himself company](https://bladerunner.fandom.com/wiki/J.F._Sebastian).

# Components

- Raspberry Pi Touch 2 (10 inch)
- Raspberry Pi Compute Module 5
- Waveshare PoE carrier board for CM5
- 3d printed enclosure/stand
- 1 magnet ([link](https://www.amazon.de/-/en/dp/B08K39Q1DL))
- NVME drive
- Cooling Fan

# Software

The single tweak to the standard desktop panel is the landscape/portrait mode toggle. This is made with 2 things, a simple shell script placed in your $PATH and an edit to the Panel config.

## Setup

Clone the repo:

```
git clone https://github.com/veebch/sebastian.git
cd sebastian
```

Copy the rotation script to `~/bin` and make it executable:

```
mkdir -p ~/bin
cp rotate-screen.sh ~/bin/rotate-screen
chmod +x ~/bin/rotate-screen
```

Make sure `~/bin` is on your `$PATH`. Add this to `~/.bashrc` (or `~/.profile`) if it isn't already there, then reload your shell:

```
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Save the panel config so the rotate button shows up as a launcher:

```
mkdir -p ~/.config/wf-panel-pi
cp wf-panel-pi.ini ~/.config/wf-panel-pi/wf-panel-pi.ini
```

Log out and back in (or restart the panel) for the new launcher to appear.

I highly recommend adding some of the newer Linux terminal tools, outlined [here](https://www.veeb.ch/projects/2026-linux-commands)



# Video

Here it is being assembled.
