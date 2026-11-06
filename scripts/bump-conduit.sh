#!/usr/bin/env bash
# Point Casks/conduit.rb at the latest published Conduit release.
# Prints the new version when the cask changed and nothing when it was current.
set -euo pipefail

repo="srps/Conduit"
cask="$(dirname "$0")/../Casks/conduit.rb"

tag="$(gh release view -R "${repo}" --json tagName --jq .tagName)"
version="${tag#v}"
current="$(sed -n 's/^  version "\(.*\)"$/\1/p' "${cask}")"
[[ "${version}" = "${current}" ]] && exit 0

dmg="Conduit-${version}-macOS26-arm64.dmg"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
gh release download "${tag}" -R "${repo}" -D "${work}" -p "${dmg}" -p "Conduit-${version}-macOS26-arm64.sha256"

computed="$(shasum -a 256 "${work}/${dmg}" | cut -d' ' -f1)"
published="$(awk -v f="${dmg}" '$2 == f { print $1 }' "${work}/Conduit-${version}-macOS26-arm64.sha256")"
if [[ "${computed}" != "${published}" ]]
then
  echo "error: ${dmg} hashes to ${computed} but the release's checksum file says ${published:-nothing}" >&2
  exit 1
fi

sed -i.bak -e "s/^  version \".*\"$/  version \"${version}\"/" \
  -e "s/^  sha256 \".*\"$/  sha256 \"${computed}\"/" "${cask}"
rm -f "${cask}.bak"
echo "${version}"
