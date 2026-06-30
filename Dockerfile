# =============================================================================
# Railway Template: Beszel v0.18.7
# https://github.com/henrygd/beszel
# Lightweight server monitoring platform with historical data,
# Docker stats, and alert functions.
# =============================================================================
# Notes:
#   • Beszel listens on port 8090 (hardcoded in upstream CMD).
#     Railway's healthcheck probes PORT (set to 8090 by default in
#     railway.json). If you change PORT, ensure it matches 8090 or
#     update HEALTHCHECK accordingly.
#   • Persistent data lives at /beszel_data — mount a Railway volume
#     there to survive restarts.
# =============================================================================

FROM docker.io/henrygd/beszel:0.18.7

LABEL org.opencontainers.image.source="https://github.com/INAPP-Mobile/railway-beszel"

# Upstream listens on 8090 (hardcoded). Railway's reverse-proxy uses
# PORT to determine target port — set PORT=8090 in env to match.
EXPOSE 8090

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider "http://127.0.0.1:8090/" >/dev/null 2>&1 || exit 1
