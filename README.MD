# Host FST


This is a file system translator (and driver) for compatible Apple IIgs
emulators.  It depends on emulator support (but should not cause problems
if run on real hardware or an unsupportive emulator).

![Host FST](images/ss-1.png)

This FST exposes a shared folder from your native file system as a volume 
within GS/OS.  (The volume will not be available from ProDOS 8). Reading 
or writing a file on the :Host drive will read or write the file directly 
on the native file system.  File Types, Finder Info, and Resource Forks 
are supported.

![Host FST](images/ss-2.png)

In general any software that works with the HFS FST should work with the 
Host FST.

## Installation

Currently, only GSPlus has support for the host fst.

1. See the [releases](https://github.com/ksherlock/host-fst/releases) page for a disk image.
2. Install the `host.fst` and `host.driver` in your `*:System:` folder
3. Bleeding edge versions of GSPlus have a config option (F4, Host FST Configuration) to
select the host fst directory. (On older versions it doesn't work correctly).
4. If you're using an older version of GSPlus, shutdown GSPlus and manually edit the 
`config.txt` file.  Add a line like:

    g_cfg_host_path = /Users/me/IIgs/
  
