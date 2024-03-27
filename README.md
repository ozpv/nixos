# nixos
nixos config

# Setup
cd into /etc/nixos
```
cd /etc/nixos
```
clone the repo (make sure to make backups)
```
git clone https://github.com/ozpv/nixos.git
```
move .xinitrc to ~/
```
mv .xinitrc ~/.
```
then rebuild switch
```
nixos-rebuild switch --flake /etc/nixos#ozpv
```
 
full command: 
```
cd /etc/nixos
git clone https://github.com/ozpv/nixos.git
mv .xinitrc ~/.
nixos-rebuild switch --flake /etc/nixos#ozpv
```
