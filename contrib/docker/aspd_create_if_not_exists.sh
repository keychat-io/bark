echo "${ASPD__DATA_DIR}"
ls -lhR "${ASPD__DATA_DIR}"

if [ -f "${ASPD__DATA_DIR}/mnemonic" ]; then
  echo "Config already exists at ${ASPD__DATA_DIR}"
else
  echo "Creating new config at ${ASPD__DATA_DIR}"
  echo "ASPD__NETWORK=${ASPD__NETWORK}"
  echo "ASPD__BITCOIND__URL=${ASPD__BITCOIND__URL}"
  echo "ASPD__BITCOIND__RPC_USER=${ASPD__BITCOIND__RPC_USER}"
  echo "ASPD__BITCOIND__RPC_PASS=${ASPD__BITCOIND__RPC_PASS}"
  echo "ASPD__POSTGRES__HOST=${ASPD__POSTGRES__HOST}"
  echo "ASPD__POSTGRES__USER=${ASPD__POSTGRES__USER}"
  echo "ASPD__POSTGRES__PASSWORD=${ASPD__POSTGRES__PASSWORD}"

  sleep 5s
  /usr/local/bin/aspd create
fi
