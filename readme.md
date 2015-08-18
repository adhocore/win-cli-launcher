## win-cli-launcher

a command line launcher for windows os
launch anything, be it executables or arbitrary files by simple alias that you can run as command in any terminals


## installation

- download and unzip
- place the `bin` folder in root of `C:/` drive so that the path looks like: `C:/bin` 
- if you place in other paths then adjust the `binpath` in `\bin\launcher.bat` around line 11 accordingly 
- run command `path/to/bin/launcher.bat` and it sets up itself


## usage

### add new launcher
- run command `launcher "targetFile" alias`
- `targetFile` The fullpath of file to be invoked via command
- `alias`      The command that will invoke targetFile
- `alias`      is Optional, defaults to name of targetFile

- example: 
    1. `launcher "D:/sublime/sublime_text.exe" sublime`
    2. `launcher "D:/sublime/sublime_text.exe"`


### launch stuffs
consider above example #1, we have aliased a command `sublime`
- just run command `sublime` to launch the sublime editor
- or run with extra args `sublime /path/to/some/file.php` to launch sublime editor and have that file.php already opened

consider above example #2, we dont have alias so `sublime_text` is assumed by default
- run command `sublime_text`


### spoiler
- if the basename of targetFile or the alias contains space, the command alias created will have spaces removed
    - example 1: `launcher "D:/sublime/sublime_text.exe" "sublime text"` will have a command `sublimetext`
