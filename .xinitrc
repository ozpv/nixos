slstatus &
xwallpaper --zoom /usr/share/wallpapers/wallpaper.png &
[ -f ~/.xprofile ] && . ~/.xprofile &

exec dwm
