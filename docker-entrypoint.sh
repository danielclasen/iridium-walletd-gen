#!/usr/bin/env bash

wallet_regex=".*-w\ (\S+).*|.*--container-file=(\S+).*"

if [[ "$@" =~ $wallet_regex ]]; then
    WALLET=${BASH_REMATCH[1]}

    if [ ! -f "$WALLET" ]; then
        echo "Wallet $WALLET does not exist. Going to create a new one."
        iridium/iridium_walletd "$@" | grep -Po ".*Address: (\S+)$" | sed -E "s/.*Address: (\S+)$/\\1/" > "$WALLET.adr"
        chmod -R 777 "$WALLET"
        chmod -R 777 "$WALLET.adr"
    else
        echo "Wallet $WALLET already present. Nothing to do."
        exit 0
    fi



else
    echo "Please specify a wallet file!"
    exit 1;
fi

