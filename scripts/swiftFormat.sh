if which mint >/dev/null; then
  git diff --name-only | grep .swift | while read filename; do
    mint run swiftformat "$filename"
  done
else
  echo "warning: Mint is not installed. please install it here https://github.com/yonaskolb/Mint"
fi
