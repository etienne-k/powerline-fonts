#!/bin/sh

# Set source and target directories
powerline_fonts_dir="$( cd "$( dirname "$0" )" && pwd )"

# if an argument is given it is used to select which fonts to install
prefix="$1"

if test "$(uname)" = "Darwin" ; then
  # MacOS
  font_dir="$HOME/Library/Fonts"
else
  # Linux
  if [ $(id -u) -eq 0 ]; then
    font_dir="/usr/local/share/fonts"
  else
    font_dir="$HOME/.local/share/fonts"
  fi
  mkdir -p $font_dir
fi

# Copy all fonts to user fonts directory
echo "Copying fonts to $font_dir..."
find "$powerline_fonts_dir" \( -name "$prefix*.[ot]tf" -or -name "$prefix*.pcf.gz" \) -type f -print0 | xargs -0 -n1 -I % cp "%" "$font_dir/"

# Reset font cache on Linux
if which fc-cache >/dev/null 2>&1 ; then
    echo "Resetting font cache, this may take a moment..."
    fc-cache -f "$font_dir"
fi

echo "Powerline fonts installed to $font_dir"
