# This is a file with functions and other useful things that I think are well-suited for a bashrc file.

# Opens a command in your editor (or if not possible, shows it to you)
# Note: If the command is a binary file, opening it will just shows garbage.
seecommand() {
  local editor
  if [ "$EDITOR" == "vim" ]; then
    editor="vim -R"
  else
    editor="$EDITOR"
  fi

  for i in "$@"; do
    if [ "$(type -t "$i")" == "alias" ]; then # Command is alias
      echo "$(type "$i")"
    elif [ "$(type -t "$i")" == "file" ]; then # Command is File
      echo "Viewing command: $i..."
      $editor $(type -p "$i")
    elif [ "$(type -t "$i")" == "function" ]; then
      echo "$(type "$i")"
    else
      echo "$i: Not viewable."
      echo "$(type "$i")"
      continue
    fi
  done
  return
}

# Simpler tar invocations
tarball() {
  name="tarball"
  tar cvfJ "$name.tar.xz" $@
}
untar() {
  if [ -e file ]; then
    rm -r /tmp/tar-extract
  fi
  mkdir /tmp/tar-extract
  tar xvf $1 -C /tmp/tar-extract
}

# Gets license from /usr/local/share/licenses and places it in current directory
# TODO: Fix the extension thing it only currently works with .txt.
get-license() {
  local licenses_path="/usr/local/share/licenses/"
  # Get list of licenses from /usr/local/share/licenses/
  local licenses=(${licenses_path}*)
  # Remove .txt from every element.
  local licenses_stripped=()
  for i in "${licenses[@]}"; do
    local temp=$(echo $i | awk -F'/' '{print $NF}')
    temp=$(echo $temp | awk -F'.' '{print $1}')
    licenses_stripped+=($temp)
  done

  # `select` license
  select license in "${licenses_stripped[@]}"; do
    # place license in current directory as LICENSE
    \cp -i "${licenses_path}${license}.txt" ./LICENSE
    break
  done

  return
}

# Dumps text files of explicitly installed packages (Arch)
# Remove or add sections depending on package managers you have.
dump-packages() {
  pacman -Qqen > pkglist.txt
  pacman -Qqem > aur-pkglist.txt

  # Flatpak packages (into csv)
  echo "Application Name,Application ID,Version,Branch,Remote Origin,Active Commit,Installation" > flatpak-pkglist.csv
  flatpak list --app --columns=name,application,version,branch,origin,active,installation | cut --whitespace-delimited=trimmed -O ',' -f 1- >> flatpak-pkglist.csv

  # Cargo packages
  cargo install --list > cargo-pkglist.txt

  # Pipx
  pipx list > pipx-pkglist.txt
}

meow() {
  for i in $(seq 1 $1); do
    echo -n "meow "
  done
  echo ""
}
