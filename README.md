# Config files

Some general guidelines:

```sh
# To load .Xresources file
xrdb .Xresourses

# To set GTK FlatColor theme
mkdir -p ~/.themes
cp .themes/FlatColor ~/.themes/ -R
lxappearance  # GUI application for settings the theme

# To move wallpapers to right place
mkdir -p ~/Images/Wallpaper
cp wallpaper/* ~/Images/Wallpaper

# To copy general scripts
mkdir -p ~/.local/scripts
cp local/scripts/* ~/.local/scripts/

# To set up .config folder
for folder in .config/*; do
    mkdir -p ~/$folder
    ln -s $PWD/$folder ~/$folder/  # if want to replace already existing files run with -f flag
done
```
