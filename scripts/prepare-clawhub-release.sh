#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
SOURCE_SKILL="${ROOT_DIR}/SKILL.md"
SOURCE_REFERENCES="${ROOT_DIR}/references"
TARGET_DIR="${1:-${ROOT_DIR}/release}"

if [ ! -f "${SOURCE_SKILL}" ]; then
  echo "Missing source file: ${SOURCE_SKILL}" >&2
  exit 1
fi

if [ ! -d "${SOURCE_REFERENCES}" ]; then
  echo "Missing source directory: ${SOURCE_REFERENCES}" >&2
  exit 1
fi

rm -rf "${TARGET_DIR}"
mkdir -p "${TARGET_DIR}"

cp "${SOURCE_SKILL}" "${TARGET_DIR}/SKILL.md"
cp -R "${SOURCE_REFERENCES}" "${TARGET_DIR}/references"

echo "Prepared ClawHub release at: ${TARGET_DIR}"
echo "Contents:"
find "${TARGET_DIR}" -mindepth 1 -maxdepth 2 | sort
