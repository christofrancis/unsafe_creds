#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

DATA_DIR="data"
CONFIG_FILE="$DATA_DIR/config.env"
PID_FILE="$DATA_DIR/server.pid"

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

if ! [[ "$PORT" =~ ^[0-9]+$ ]] ||
   [ "$PORT" -lt 1 ] ||
   [ "$PORT" -gt 65535 ]; then

    echo
    echo "ERROR: Invalid port."
    exit 1
fi

cat > "$CONFIG_FILE" <<EOF_CONFIG
IP=$IP
PORT=$PORT
EOF_CONFIG

echo
echo "Using:"
echo "IP   = $IP"
echo "PORT = $PORT"
echo

if ! command -v php >/dev/null 2>&1; then

    echo "ERROR: PHP was not found."
    echo
    echo "Install it with:"
    echo "pkg install php"

    exit 1
fi

if [ ! -f "router.php" ]; then

    echo "ERROR: router.php was not found."
    exit 1
fi


SERVER_PID=""
CLEANED_UP=0


stop_pid() {

    local PID="$1"

    if ! [[ "$PID" =~ ^[0-9]+$ ]]; then
        return
    fi

    if ! kill -0 "$PID" 2>/dev/null; then
        return
    fi

    kill -TERM "$PID" 2>/dev/null || true

    # Give PHP time to release the listening socket
    for _ in 1 2 3 4 5 6 7 8 9 10; do

        if ! kill -0 "$PID" 2>/dev/null; then
            return
        fi

        sleep 0.2
    done

    # Last resort
    kill -KILL "$PID" 2>/dev/null || true
}


cleanup() {

    if [ "$CLEANED_UP" -eq 1 ]; then
        return
    fi

    CLEANED_UP=1

    if [ -n "$SERVER_PID" ]; then

        echo
        echo "Stopping server..."

        stop_pid "$SERVER_PID"

        wait "$SERVER_PID" 2>/dev/null || true
    fi

    rm -f "$PID_FILE"
}


# Clean up a previous server if the launcher exited incorrectly
if [ -f "$PID_FILE" ]; then

    OLD_PID="$(cat "$PID_FILE" 2>/dev/null)"

    if [[ "$OLD_PID" =~ ^[0-9]+$ ]] &&
       kill -0 "$OLD_PID" 2>/dev/null; then

        OLD_CMD="$(
            tr '\0' ' ' < "/proc/$OLD_PID/cmdline" 2>/dev/null || true
        )"

        if [[ "$OLD_CMD" == *php* &&
              "$OLD_CMD" == *"-S"* &&
              "$OLD_CMD" == *"router.php"* ]]; then

            echo "Found previous Unsafe Creds PHP server (PID $OLD_PID)."
            echo "Stopping it before restart..."

            stop_pid "$OLD_PID"

            sleep 0.5
        fi
    fi

    rm -f "$PID_FILE"
fi


trap 'exit 130' INT
trap 'exit 143' TERM
trap 'exit 129' HUP
trap cleanup EXIT


echo "Starting PHP server..."
echo


php -S "0.0.0.0:$PORT" router.php \
    > >(tee "$DATA_DIR/server.log") 2>&1 &

SERVER_PID=$!

printf '%s\n' "$SERVER_PID" > "$PID_FILE"


sleep 1


if ! kill -0 "$SERVER_PID" 2>/dev/null; then

    echo "ERROR: PHP server failed to start."
    echo "Port $PORT may already be in use."
    echo
    echo "Check for another PHP server with:"
    echo "pgrep -af 'php -S'"

    SERVER_PID=""

    rm -f "$PID_FILE"

    exit 1
fi


WEBSITE_URL="http://$IP:$PORT/index.html"


echo "Website URL:"
echo "$WEBSITE_URL"
echo


if command -v termux-open-url >/dev/null 2>&1; then

    termux-open-url "$WEBSITE_URL" >/dev/null 2>&1 || true

else

    echo "Open the URL above manually in your Android browser."
    echo
fi


wait "$SERVER_PID"
