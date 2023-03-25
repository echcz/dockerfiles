#!/bin/sh

for f in `ls /docker-entrypoint.d | sort -V`; do
    f="/docker-entrypoint.d/$f"
    case "$f" in
        *.envsh)
            if [ -x "$f" ]; then
                echo "$(date) docker-entrypoint [INFO] Sourcing $f";
                . "$f"
            else
                echo "$(date) docker-entrypoint [WARN] Ignoring $f, not executable";
            fi
            ;;
        *.sh)
            if [ -x "$f" ]; then
                echo "$(date) docker-entrypoint [INFO] Launching $f";
                "$f"
            else
                echo "$(date) docker-entrypoint [WARN] Ignoring $f, not executable";
            fi
            ;;
        *) echo "$(date) docker-entrypoint [WARN] Ignoring $f";;
    esac
done

exec "$@"
