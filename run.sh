#!/bin/bash

set -eo pipefail

# so we can use globbing instead of find
shopt -s globstar nullglob nocaseglob

readonly OUTPUT_DIR='/output'
readonly READW_PATH='/home/wine/readw/ReAdW.exe'

# can't get this to stay registered during container build
# so registering it every time before we run
# perhaps this is only an issue with the .dll obtained
# from the Cravatt lab XCalibur install
regsvr32 /home/wine/readw/XRawfile2.dll &>/dev/null


convert() {
    local item files

    item="${1}"

    if [[ -d "${item}" ]]; then
        # note that globbing should be set to be case insensitive
        files="${item}/*.raw"

        if [[ -z "${files}" ]]; then
            echo "${item} does not contain any .raw files."
            return
        fi
    elif [[ -f "${item}" ]]; then
        files="${item}"

        if [[ "${item,,}" != *.raw ]]; then
            echo "${item} is not a .raw file."
            return            
        fi
    else
        echo "${item} is not a valid directory or .raw file."
        return
    fi

    local filename parent output_dir outputFile

    for file in ${files}; do
        filename="$(basename -- "$file")"
        filename="${filename%.*}"

        parent="$(dirname "${file}")"
        mkdir -p "${OUTPUT_DIR}/${parent}"

        outputFile="${OUTPUT_DIR}/${parent}/${filename}.mzXML"
        wine  "${READW_PATH}" --mzXML --centroid "${file}" "${outputFile}"
    done
}

main() {
    local f

    for f in "${@}"; do
        convert "${f}"
    done
}

main "$@"

# for running with docker
exec
