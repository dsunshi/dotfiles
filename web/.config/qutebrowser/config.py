config.load_autoconfig(False)
# zl to autotype username + tab + password from bitwarden-cli
config.bind('<z><l>', 'spawn --userscript qute-bitwarden')
# zul to autotype username
config.bind('<z><u><l>', 'spawn --userscript qute-bitwarden --username-only')
# zpl to autotype password
config.bind('<z><p><l>', 'spawn --userscript qute-bitwarden --password-only')

# xb to toggle the status bar
config.bind('xb', 'config-cycle statusbar.show always never')
# xt to toggle the tab bar
config.bind('xt', 'config-cycle tabs.show always never')
# xx = xb + xt
config.bind('xx', 'config-cycle statusbar.show always never;; config-cycle tabs.show always never')

