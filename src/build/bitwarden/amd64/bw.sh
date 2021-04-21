#!/bin/bash

CUR=${PWD}
BITWARDEN=$(wget -qO- https://api.github.com/repos/dani-garcia/bitwarden_rs/tags | grep 'name' | cut -d\" -f4 | head -1)

DB="sqlite,mysql,postgresql"

apt-get update && apt-get install -y --no-install-recommends libmariadb-dev libpq-dev
git clone https://github.com/dani-garcia/bitwarden_rs bitwarden
pushd bitwarden || exit 1
git checkout ${BITWARDEN}
cargo build --features ${DB} --release
find . -not -path "./target*" -delete
popd || exit 1
cp -r bitwarden/target/release/bitwarden_rs ./bitwarden_rs && rm -rf bitwarden