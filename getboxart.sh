#!/usr/bin/env bash
#!/usr/bin/env bash

# usage:
#   ./getboxart.sh [--refresh] <BASE_URL> "search term"

REFRESH=0

if [[ "$1" == "--refresh" ]]; then
    REFRESH=1
    shift
fi

BASE_URL="$1"
SEARCH="$2"
OUTDIR="./Imgs"
CACHE_FILE="./.cache_dirlist.txt"

if [[ -z "$BASE_URL" || -z "$SEARCH" ]]; then
    echo "Usage: $0 [--refresh] <BASE_URL> \"search term\""
    exit 1
fi

mkdir -p "$OUTDIR"

# Fetch or read cached directory listing
if [[ -f "$CACHE_FILE" && $REFRESH -eq 0 ]]; then
    files=$(cat "$CACHE_FILE")
else
    html=$(curl -fsSL "$BASE_URL/") || exit 1
    files=$(echo "$html" \
        | sed -n 's/.*href="\([^"]*\.png\)".*/\1/p' \
        | sort -u)
    echo "$files" > "$CACHE_FILE"
fi

# Filter by search term
candidates=$(echo "$files" | grep -i "$SEARCH")
[[ -z "$candidates" ]] && exit 1

# Prefer USA
usa_candidates=$(echo "$candidates" | grep -i "USA")
[[ -n "$usa_candidates" ]] && candidates="$usa_candidates"

# Build "decoded<TAB>encoded" list
display_list=$(
    while IFS= read -r encoded; do
        decoded=$(printf '%b' "${encoded//%/\\x}")
        printf "%s\t%s\n" "$decoded" "$encoded"
    done <<< "$candidates"
)

# fzf with Kitty preview
if command -v fzf >/dev/null && command -v kitty >/dev/null; then
    selection=$(echo "$display_list" | fzf \
        --prompt="Boxart > " \
        --with-nth=1 \
        --delimiter=$'\t' \
        --preview="
ENCODED=\$(echo {} | cut -f2);
DECODED=\$(echo {} | cut -f1);
IMAGE_URL=\"$BASE_URL/\$ENCODED\";
tmp=\$(mktemp -t imgXXXX.png);
curl -fsSL \"\$IMAGE_URL\" -o \"\$tmp\" &&
kitty +kitten icat --silent \"\$tmp\";
rm -f \"\$tmp\"
" \
        --preview-window=right:60%)
else
    selection=$(echo "$display_list" | head -n1)
fi

[[ -z "$selection" ]] && exit 1

decoded_name=$(echo "$selection" | cut -f1)
encoded_name=$(echo "$selection" | cut -f2)

outfile="$OUTDIR/$decoded_name"
remote="$BASE_URL/$encoded_name"

echo "Downloading:"
echo "  $decoded_name"

curl -fsSL "$remote" -o "$outfile" || exit 1

echo "Saved to $outfile"

