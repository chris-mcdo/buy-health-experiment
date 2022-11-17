#!/bin/sh

OUTPUT_DIR="/tmp/jupyter"
GITHUB_PAGES_BRANCH="gh-pages"
INPUT_FILE_PREFIX="sample-size-analysis"
INPUT_FILE_NAME="${INPUT_FILE_PREFIX}.ipynb"
OUTPUT_FILE_FORMAT="html"
OUTPUT_FILE_NAME="${INPUT_FILE_PREFIX}.${OUTPUT_FILE_FORMAT}"
OUTPUT_FILE_PATH="${OUTPUT_DIR}/${OUTPUT_FILE_NAME}"

GITHUB_ORIGINAL_BRANCH="$(git branch --show-current)"

GITHUB_COMMIT_MESSAGE=${1:-"update report"}
echo "commit message ${GITHUB_COMMIT_MESSAGE}"

mkdir ${OUTPUT_DIR}

jupyter nbconvert --to ${OUTPUT_FILE_FORMAT} --template pj ${INPUT_FILE_NAME} --output-dir ${OUTPUT_DIR}

git switch ${GITHUB_PAGES_BRANCH}

mv -f ${OUTPUT_FILE_PATH} .

git add ${OUTPUT_FILE_NAME}
git commit -m "${GITHUB_COMMIT_MESSAGE}"

git push origin gh-pages

git switch ${GITHUB_ORIGINAL_BRANCH}

rmdir ${OUTPUT_DIR}
