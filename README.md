# plasma-netping

Tiny KDE Plasma 6 panel widget that shows connectivity state and latency. It works on networks that block ICMP (no ping involved).

- `plasmoid/` — the widget (`local.netping`); polls `~/bin/netping` every 5 s.
- `bin/netping` — layered check: `nmcli networking connectivity check` for state, plus a `curl` probe of `http://www.gstatic.com/generate_204` for latency. Result is cached 12 s so endpoints are probed at most that often.

Output: `NNms` | `PORTAL` | `LIMITED` | `DOWN`.

## Install

```sh
install -Dm755 bin/netping ~/bin/netping
cp -r plasmoid ~/.local/share/plasma/plasmoids/local.netping
```

Then add "Net Ping" to a panel. The script path is hardcoded in `plasmoid/contents/ui/main.qml` (`$HOME/bin/netping`, run through the shell); edit it if you install the script elsewhere.

Needs: NetworkManager (`nmcli`), `curl`, `awk`.
