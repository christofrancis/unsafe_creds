#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

DATA_DIR="data"
CONFIG_FILE="$DATA_DIR/config.env"

mkdir -p "$DATA_DIR"

# Default values
IP="127.0.0.1"
PORT="8000"

# Load previous values without executing config.env as shell code
if [ -f "$CONFIG_FILE" ]; then
    while IFS='=' read -r KEY VALUE; do
        case "$KEY" in
            IP) IP="$VALUE" ;;
            PORT) PORT="$VALUE" ;;
        esac
    done < "$CONFIG_FILE"
fi

echo "=============================="
echo "      SERVER CONFIGURATION"
echo "=============================="
echo

read -r -p "Enter IP address [$IP]: " NEW_IP
read -r -p "Enter port [$PORT]: " NEW_PORT

IP="${NEW_IP:-$IP}"
PORT="${NEW_PORT:-$PORT}"

# Validate port
if ! [[ "$PORT" =~ ^[0-9]+$ ]] ||
   [ "$PORT" -lt 1 ] ||
   [ "$PORT" -gt 65535 ]; then

    echo
    echo "ERROR: Invalid port."
    exit 1
fi

# Save configuration
cat > "$CONFIG_FILE" <<EOF
IP=$IP
PORT=$PORT
EOF

echo
echo "Using:"
echo "IP   = $IP"
echo "PORT = $PORT"
echo

# Check PHP
if ! command -v php >/dev/null 2>&1; then

    echo "ERROR: PHP was not found."
    echo
    echo "Install PHP with Homebrew:"
    echo
    echo "brew install php"
    echo

    exit 1
fi

# Check router
if [ ! -f "router.php" ]; then

    echo "ERROR: router.php was not found."
    exit 1
fi

SERVER_PID=""
CLEANED_UP=0

cleanup() {

    if [ "$CLEANED_UP" -eq 1 ]; then
        return
    fi

    CLEANED_UP=1

    echo
    echo "Stopping server..."

    if [ -n "$SERVER_PID" ] &&
       kill -0 "$SERVER_PID" 2>/dev/null; then

        kill "$SERVER_PID" 2>/dev/null || true
        wait "$SERVER_PID" 2>/dev/null || true
    fi
}

trap 'exit 130' INT
trap 'exit 143' TERM
trap cleanup EXIT

echo "Starting PHP server..."
echo

# Start PHP and save output to data/server.log
php -S "0.0.0.0:$PORT" router.php \
    > >(tee "$DATA_DIR/server.log") 2>&1 &

SERVER_PID=$!

sleep 1

# Check whether PHP started correctly
if ! kill -0 "$SERVER_PID" 2>/dev/null; then

    echo "ERROR: PHP server failed to start."
    echo "Port $PORT may already be in use."

    SERVER_PID=""

    exit 1
fi

WEBSITE_URL="http://$IP:$PORT/index.html"

echo "Website URL:"
echo "$WEBSITE_URL"
echo

# Open the default macOS browser
if command -v open >/dev/null 2>&1; then

    open "$WEBSITE_URL" >/dev/null 2>&1 &

else

    echo "Open the URL above manually in your browser."
    echo
fi

wait "$SERVER_PID"
