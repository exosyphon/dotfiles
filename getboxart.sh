#!/usr/bin/env bash

# usage:
#   ./getboxart.sh [--refresh] <BASE_URL> "search term"

REFRESH=0

# check if first argument is --refresh
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
    echo "Using cached directory listing..."
    files=$(cat "$CACHE_FILE")
else
    echo "Fetching file index from $BASE_URL..."
    html=$(curl -fsSL "$BASE_URL/") || {
        echo "Failed to fetch $BASE_URL"
        exit 1
    }

    # Extract .png filenames (already URL-encoded in HTML)
    files=$(echo "$html" \
        | sed -n 's/.*href="\([^"]*\.png\)".*/\1/p' \
        | sort -u)

    if [[ -z "$files" ]]; then
        echo "No PNG files found at $BASE_URL"
        exit 1
    fi

    # Save cache
    echo "$files" > "$CACHE_FILE"
    echo "Cache updated: $CACHE_FILE"
fi

# Filter candidates by search term (case-insensitive)
candidates=$(echo "$files" | grep -i "$SEARCH")

if [[ -z "$candidates" ]]; then
    echo "No matches found for \"$SEARCH\""
    exit 1
fi

# Auto-prefer USA
usa_candidates=$(echo "$candidates" | grep -i "USA")
if [[ -n "$usa_candidates" ]]; then
    candidates="$usa_candidates"
fi

# Interactive chooser with Kitty preview (safe for special characters)
if command -v fzf >/dev/null 2>&1 && command -v kitty >/dev/null 2>&1; then
    echo "Select a boxart (Kitty preview available):"
    match=$(echo "$candidates" | fzf \
        --height=50% \
        --prompt="Boxart > " \
        --preview="FILENAME={}; \
IMAGE_URL=\"$BASE_URL/\$FILENAME\"; \
tmpfile=\$(mktemp -t imgXXXX.png); \
curl -fsSL \"\$IMAGE_URL\" -o \"\$tmpfile\"; \
kitty +kitten icat --silent \"\$tmpfile\"; \
rm -f \"\$tmpfile\"" \
        --preview-window=right:60%)
else
    echo "fzf or kitty not found; using first match"
    match=$(echo "$candidates" | head -n1)
fi

if [[ -z "$match" ]]; then
    echo "No selection made"
    exit 1
fi

remote="$BASE_URL/$match"

# Decode URL encoding for the filename safely
decoded_name=$(printf '%b' "${match//%/\\x}")
outfile="$OUTDIR/$decoded_name"

echo "Downloading:"
echo "  $decoded_name"

curl -fsSL "$remote" -o "$outfile" || {
    echo "Download failed"
    exit 1
}

echo "Saved to $outfile"

