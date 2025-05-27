import logging
import os
import sys
import time

from bitcoinrpc.authproxy import AuthServiceProxy


RPC_USER = os.environ["BITCOIN_RPC_USER"]
RPC_PASSWORD = os.environ["BITCOIN_RPC_PASSWORD"]
RPC_HOST = os.environ["BITCOIN_RPC_HOST"]
RPC_PORT = os.environ["BITCOIN_RPC_PORT"]

# Every BLOCK_FREQUENCY seconds a block will be mined
BLOCK_FREQUENCY = int(os.environ.get("BLOCK_FREQUENCY", "60"))

logging.basicConfig(stream=sys.stderr, level=logging.DEBUG)
logger = logging.getLogger(__name__)


def create_and_load_wallet(client):
    try:
        logger.info("Creating wallet")
        client.createwallet("wallet")
        return
    except Exception:
        logger.info("Wallet already exists")

    try:
        client.loadwallet("wallet")
    except Exception:
        logger.info("Wallet is already loaded")


def create_initial_blocks(rpc_client):
    count = rpc_client.getblockcount()
    while count <= 101:
        count = rpc_client.getblockcount()
        address = rpc_client.getnewaddress()
        rpc_client.generatetoaddress(101, address)


def main():
    url = f"http://{RPC_USER}:{RPC_PASSWORD}@{RPC_HOST}:{RPC_PORT}"
    logging.info("Connectiong to %s", url)

    rpc_client = AuthServiceProxy(url, timeout=120)

    create_and_load_wallet(rpc_client)
    create_initial_blocks(rpc_client)
    while True:
        try:
            time.sleep(BLOCK_FREQUENCY)
            rpc_client = AuthServiceProxy(url, timeout=120)
            address = rpc_client.getnewaddress()
            rpc_client.generatetoaddress(1, address)

            blockheight = rpc_client.getblockcount()
            logger.debug("Blockheight = %s", blockheight)
        except Exception:
            logger.exception("Failed to generate new block")


if __name__ == "__main__":
    main()
