# Testing Invoke-LiveResponse

These directions are for quickly setting up lab machines that can be used to test `Invoke-LiveResponse` changes w/multiple OSes and various versions of Powershell.

## Details

This config uses Vagrant to configure and install the following lab boxes:

* `ps2`: Windows 7 SP1, Powershell 2.0
* `ps4`: Windows 8.1, Powershell 4.0
* `ps5`: Windows 10, Powershell 5.0

Details about Powershell versions and the mapping to OSes can be found [here](https://4sysops.com/wiki/differences-between-powershell-versions/#powershell-and-windows-versions).

In the current config, Invoke-LiveResponse is run from the same system that hosts the lab VMs (this means it must be Windows) - we'll call it **vmhost**. A future extension would be to create another VM that emulates the analyst's host.

## Setup

Perform all of these steps on the vmhost.

1. Download and install Virtualbox or VMware (I used Virtualbox)
2. Download and install Vagrant
3. Create a new directory and a Vagrantfile inside of it (you can copy the file from this repo)
4. Download winpmem to the same directory as the Vagrantfile
5. Open a command prompt (`cmd.exe`) and navigate to the directory created above
6. run `vagrant up`. Sequentially and eventually, all the lab boxes should come online. Verify that `vagrant powershell ps*` provides a Powershell prompt for each system.
7. Download the `Invoke-LiveResponse` repo (if it's not already present on the vmhost). 
8. Optional: If `Invoke-LiveResponse` is not already in your Powershell path, add a hardlink to place it in your user profile: `mklink /J %userprofile%\WindowsPowershell\Modules\Invoke-LiveResponse <path\to\repo>`
9. Setup complete!

## Usage

Run the following commands:

```powershell
Import-Module Invoke-LiveResponse

# you'll need to get the specific port for each Windows host by running this in cmd.exe: vagrant port <vm name>
# default credential for the vagrant user is vagrant
Invoke-LiveResponse -ComputerName 127.0.0.1 -Credential Win7\vagrant -Port <see notes> -Authentication Negotiate -All -LocalOut C:\tmp
```

If any errors occurred, fix and rerun.

If not errors occurred, in a separate command prompt window, run:

```
vagrant powershell ps<#>

Get-ChildItem c:\tmp -recurse
```

Are all the output files present with non-null sizes? If so, the change seems to be working!

You can either suspend (`vagrant pause <vm name>`) or destroy (`vagrant destroy -f <vm name>`) the VMs.

## Enhancements

* Add a VM to emulate the analyst host (instead of running `Invoke-LiveResponse` from the vmhost)
* Automate or script the tests and/or verification process.

## Changelog

### 20181224

Creating documentation for this testing process.