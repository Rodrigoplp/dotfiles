# Install Linux

- Swap ctrl and alt keys: install Tweaks.

- Create a shortcut at Terminal to open its settings with <Ctrl-,>

## Disable bold fonts

```
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/allow-bold false
```

Replace the long string after `profiles:/:` with the id of the profile in the Terminal preferences.

## Install Regolith

### Make Teams notifications to float

With Regolith, Microsoft Teams notifications will split the screen and occupy an entire panel. To reduce them to a floating square, the manual says to add a modifier to the Xresources file `.config/regolith/Xresources`.

But that was to no avail. Instead, the only way to make it work was to modify the protected config file `/etc/regolith/i3/config`.

The notification identifier is:

```
[class="Microsoft Teams - Preview" id=48234502 instance="microsoft teams - preview" title="Microsoft Teams Notification" window_role="browser-window"]
```

Add the following to `/etc/regolith/i3/config`:

```
for_window [title="Microsoft Teams Notification"]: floating enable move position 1550 10
for_window [title="Shrew Soft VPN Connect"] floating enable
for_window [window_role="pop-up"] floating enable
for_window [window_role="About"] floating enable
for_window [instance="Browser"] floating enable
```

The only config that worked in Xresources was:

```
i3-wm.gaps.inner.size: 0
```

### Script to identify windows

In case any other window causes problems with Regolith, save the shell script below:

```sh
#!/bin/sh

# i3-get-window-criteria - Get criteria for use with i3 config commands

# To use, run this script, then click on a window.
# Output is in the format: [<name>=<value> <name>=<value> ...]

# Known problem: when WM_NAME is used as fallback for the 'title="<string>"' criterion,
# quotes in "<string>" are not escaped properly. This is a problem with the output of `xprop`,
# reported upstream: https://bugs.freedesktop.org/show_bug.cgi?id=66807

PROGNAME=`basename "$0"`

# Check for xwininfo and xprop
for cmd in xwininfo xprop; do
    if ! which $cmd > /dev/null 2>&1; then
        echo "$PROGNAME: $cmd: command not found" >&2
        exit 1
    fi
done

match_int='[0-9][0-9]*'
match_string='".*"'
match_qstring='"[^"\\]*(\\.[^"\\]*)*"' # NOTE: Adds 1 backreference

{
    # Run xwininfo, get window id
    window_id=`xwininfo -int | sed -nre "s/^xwininfo: Window id: ($match_int) .*$/\1/p"`
    echo "id=$window_id"

    # Run xprop, transform its output into i3 criteria. Handle fallback to
    # WM_NAME when _NET_WM_NAME isn't set
    xprop -id $window_id |
        sed -nr \
            -e "s/^WM_CLASS\(STRING\) = ($match_qstring), ($match_qstring)$/instance=\1\nclass=\3/p" \
            -e "s/^WM_WINDOW_ROLE\(STRING\) = ($match_qstring)$/window_role=\1/p" \
            -e "/^WM_NAME\(STRING\) = ($match_string)$/{s//title=\1/; h}" \
            -e "/^_NET_WM_NAME\(UTF8_STRING\) = ($match_qstring)$/{s//title=\1/; h}" \
            -e '${g; p}'
} | sort | tr "\n" " " | sed -r 's/^(.*) $/[\1]\n/'
```

Make it executable and run it:

```
chmod -x criteria.sh
./criteria.sh
```

It will turn the mouse pointer into a "+" symbol. When the problematic window appears, clock on it. The terminal will output the identification that can be used in Xresources.

## Git

Install updated version.

```
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
sudo apt-get install git
git --version
```

Setup global variables

```
git config --global pager.branch false
git config --global pager.stash false
git config --global pager.log false
git config --global mergetool.keepBackup false
git config --global pull.rebase true
```

## Audio

Improve audio control by installing PulseAudio Volume Control. It allows increasing volum high enough to use AirPods.

## Vim

- Install make

	sudo apt-get install build-essential

- Build vim

Install dependencies.

```
sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git liblua5.1-dev
```

Install Vim.

```
cd
git clone https://github.com/vim/vim.git
cd vim/src
```

Compile.

```
sudo distclean
./configure --with-features=huge \
--enable-multibyte \
--enable-rubyinterp=yes \
--enable-pythoninterp=yes \
--with-python-config-dir=/usr/lib/python2.7/config \ # pay attention here check directory correct
--enable-python3interp=yes \
--with-python3-config-dir=/usr/lib/python3.8/config \
--enable-perlinterp=yes \
--enable-luainterp=yes \
--enable-gui=gtk2 \
--enable-cscope \
--prefix=/usr/local
sudo make
sudo make install
```

Point zsh to load the new vim.

```file:~/.zshrc
alias vim=/usr/local/bin/vim
alias vi=/usr/local/bin/vim
alias vimdiff=/usr/local/bin/vimdiff
```

## Sharing files with Samba

Set user: add the line bellow to `/etc/samba/smb.conf`

```
guest account = rodrigo
```

If there are files that were transfered and can be opened, run:

```
sudo chmod 644 file.txt
sudo chown -R rodrigo:rodrigo file.txt
```

## Recover packages uninstalled by mistake

```
echo '#!/bin/bash' > restore
echo sudo apt-get install `grep Remove /var/log/apt/history.log | tail -1 | sed -e 's|Remove: ||g' -e 's|([^)]*)||g' -e 's|:[^ ]* ||g' -e 's|,||g'` >> restore
chmod +x restore
./restore
```
