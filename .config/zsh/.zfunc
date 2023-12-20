# ====
# JXL
# ====

# Convert all files in current dir to JPEG XL (requires libjxl & parallel)
jpg2jxl() {
    # Prepare ENV & directories
    PLLDIR="/tmp/pll_$(date +%s)"
    JXLPATH="jxl"
    mkdir jxl

    # Run conversion
    parallel --results $PLLDIR "cjxl --lossless_jpeg=1 {} $JXLPATH/{.}.jxl" ::: *.jpeg(N) *.jpg(N) *.JPEG(N) *.JPG(N)

    # Find all failed
    grep -nrli failed $PLLDIR | cut -d "/" -f 5 | tee failed.txt
    FAILEDNUM="$(cat failed.txt | wc -l)"
    echo "Wrote $FAILEDNUM failed items to failed.txt"

    # Calculate size reduction
    OLDSIZE="$(du -kc *.jpg(N) *.jpeg(N) *.JPG(N) *.JPEG(N) | grep total$ | cut -f1)"
    NEWSIZE="$(du -kc $JXLPATH/*.jxl | grep total$ | cut -f1)"
    SIZEREDU=$(awk -v t1="$OLDSIZE" -v t2="$NEWSIZE" 'BEGIN{printf "%.0f", (t2-t1)/t1 * 100}')

    OLDSIZEH=$(echo "${OLDSIZE}K" | numfmt --from=iec --to=iec-i --suffix=B --format='%.2f')
    NEWSIZEH=$(echo "${NEWSIZE}K" | numfmt --from=iec --to=iec-i --suffix=B --format='%.2f')

    echo "Size changed by ${SIZEREDU}% (Old: $OLDSIZEH; New: $NEWSIZEH)"

    unset PLLDIR FAILEDNUM
    unset JXLPATH
    unset NEWSIZE OLDSIZE SIZEREDU OLDSIZEH NEWSIZEH
}

# ====
# Organize images by date
# ====

# Move all files in CWD with pattern `YYYYMMDD.*` into directory structure `YYYY/MM/DD/`
mvdate() {
	regex="([0-9]{4})([0-9]{2})([0-9]{2}).*"
	for f in ./*; do
	    if [ -f "$f" ]; then
            if [[ $f =~ $regex ]]; then
	            mkdir -p "$match[1]/$match[2]/$match[3]"
	            mv -vn "$f" "$match[1]/$match[2]/$match[3]"
	        fi
        fi
	done
	unset regex
}

# Grab `FileModifyDate` on all files in CWD, set as `DateTimeOriginal`, and prepend `YYYYMMDD-HHMMSS-`
# Used for setting proper `Created on` date for Snapchat images
date_mod2create() {
	for f in "$@"; do
        if [ -f "$f" ]; then
            DATEBITS=( $(exiftool -FileModifyDate "$f" | awk -F: '{ print $2 ":" $3 ":" $4 ":" $5 ":" $6 }' | sed 's/+[0-9]*//' | sort | grep -v 1970: | cut -d: -f1-6 | tr ':' ' ' | head -1) )
            YR=${DATEBITS[1]}
            MTH=${DATEBITS[2]}
            DAY=${DATEBITS[3]}
            HR=${DATEBITS[4]}
            MIN=${DATEBITS[5]}
            SEC=${DATEBITS[6]}
            exiftool -overwrite_original -datetimeoriginal="$YR:$MTH:$DAY $HR:$MIN:$SEC" "$f"
            mv -v "$f" "$YR$MTH${DAY}_$HR$MIN${SEC//-[0-9]*}_$f"
	    fi
    done
}


# Grab `DateTimeOriginal`, and prepend `YYYYMMDD-HHMMSS-`
date_create2name() {
    for f in *; do
        if [ -f "$f" ]; then
            DATEBITS=( $(exiftool -datetimeoriginal -createdate "$f" | awk -F: '{ print $2 ":" $3 ":" $4 ":" $5 ":" $6 }' | sed 's/+[0-9]*//' | sort | grep -v 1970: | cut -d: -f1-6 | tr ':' ' ' | head -1) )
            if (( ${#DATEBITS[@]} == 0 )); then
                echo "Unable to get datebits for $f"
                continue
            fi

            YR=${DATEBITS[1]}
            MTH=${DATEBITS[2]}
            DAY=${DATEBITS[3]}
            HR=${DATEBITS[4]}
            MIN=${DATEBITS[5]}
            SEC=${DATEBITS[6]}
            mv -v "$f" "$YR$MTH${DAY}_$HR$MIN${SEC//-[0-9]*}_$f"
        fi
    done
}

# ====
# Misc
# ====

copy() {
    cat "$1" | pbcopy
}

paste() {
    pbpaste >> "$1"
}

