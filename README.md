# Sinden Lightgun - Linux Utilities

- [License](License.md)

BETA - this is currently in a BETA phase. The Pi is setup is properly configured. Unclear if the 32/64 bit binaries were properly included from the [original driver files](https://www.sindenlightgun.com/drivers/).

Want to test them out and [let us know](https://github.com/SindenLightgun/SindenLightgunLinux/issues/1)?

## About

- [Version Info](Version.md)

This repo contains all the Sinden Lightgun Linux utilities for setup and configuration. After successfully running the setup scripts it will:

- Clean up old Sinden files
- Backup existing gun configurations
- Copy current borders to `<retoarch_install>/retroarch/overlays/`
- Copy current RetroPie scripts to `${HOME}/$HOME/.local/bin/g/`
- Copy current binaries to the `${HOME}/SindenLightgunLinux/bin`
- Add USB `udev` `sinden-lightgun.rules` for auto detection
    - P1-Gun: Plugging in/out will auto start/stop the device
    - P2-Gun == Not Implemented; Must run the `sindenlightgun-p2start` utility in `PORTS`
    - Auto-Detect on boot == Questionable

## Report bugs

- [Create an issue](https://github.com/SindenLightgun/SindenLightgunLinux/issues).
- [Join the Discord](https://discord.com/invite/B67hgt4)

# Installation

## Download

### New install

This will download the latest version of the Sinden Lightgun utilities

```
cd ${HOME}; \
git clone https://github.com/SindenLightgun/SindenLightgunLinux.git; \
cd SindenLightgunLinux;
./setup-linux.sh
```

### Update

Update the files of your current version:

```
cd ${HOME}/SindenLightgunLinux
git pull
```

Re-run setup if there were Sinden utility changes. This should be able to be run anytime without negative affects.

```
./setup-linux.sh
```

### Change to a new version

If you are a new install, you will be on the default branch of the repo, typically the most current. If you want to change the version of either a new install or an update to a newer version, you can grab all versions, list them, and change via:

```
cd ${HOME}/SindenLightgunLinux
git fetch; git branch
git branch checkout VERSION_NAME
```


## Configure / Setup

Configure Sinden Lightgun dependencies, utilities, and borders. These scripts will install/update the software as needed, but not touch an existing configuration file(s).

```
cd ${HOME}/SindenLightgunLinux;
./setup-linux.sh;
```

## Per Architecture Binaries

If the set-up script does not determine your `arch` properly (it should indicate this), you will need to manually copy the files over. Determine which architecture you are running on and perform the following command based on your arch.

### Pi/Arm

```
cp -r arch/Pi-ARM/* bin/
```

### x86-32bit

```
cp -r arch/x86_32/* bin/
```

### x86-64bit

```
cp -r arch/x86_64/* bin/
```

## Finish

You should now reboot to have EmulationStation include the Lightgun

## Example Configs

Can be found [here](Examples.md)

## Troubleshooting

### Gun test not working

- ssh into your device
- Plug the gun in
- check for the `LightgunMono.exe.lock` Lockfile `ls /tmp/Light*`
- Is the Lockfile there? Yes -- head to discord, lets figure this out
- Is the Lockfile there? No
    - StopAll Devices `${HOME}/$HOME/.local/bin/sindenlightgun-stopall.sh`
    - Manually start P1 `${HOME}/$HOME/.local/bin/sindenlightgun-p1start.sh`
    - Check for the lockfile `ls /tmp/Light*`
    - Still not working? -- head to discord, lets figure this out

### Gun not working in an emulator/game

- head to discord, lets figure this out

### Auto Start/Stop not working, but gun works

With the gun plugged in run

```
cat /proc/bus/input/devices
```

This should output a list of devices, including 3 entries for Sinden Gun. One of the entries should be `Name="SindenCameraE` and have a line that identifies the vendor/product/version. Those values should be

```
I: Bus=0003 Vendor=32e4 Product=9210 Version=0100
```

If they are not, the ID for your gun is different, and why the auto detect may not be working

You will need to change the values in `/etc/udev/rules.d/99-sinden-lightgun.rules` to match your gun.

*TODO* if this is an actual bug, need to add a hook to NOT swap an updated file out.


