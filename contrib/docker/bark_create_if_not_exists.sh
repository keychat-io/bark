if [ -d /root/.bark ]; then
  echo "Bark already created"
else
  sleep 5s
  /usr/local/bin/bark create --regtest --asp "${ASPD_URL}" --bitcoind "${BITCOIND_URL}" --bitcoind-user "${BITCOIND_RPC_USER}" --bitcoind-pass "${BITCOIND_RPC_PASS}"
fi
