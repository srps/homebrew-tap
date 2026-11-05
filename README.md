# srps/homebrew-tap

Homebrew casks for [Conduit](https://github.com/srps/Conduit), a macOS menu bar
proxy manager for corporate networks.

```sh
brew install --cask srps/tap/conduit
```

Conduit needs an Apple Silicon Mac with macOS 26 or later.

The app is signed with Conduit's own release certificate and is not notarized.
If macOS blocks the first launch, open **System Settings > Privacy & Security**
and choose **Open Anyway**.

Conduit updates itself through Sparkle, so `brew upgrade` skips it unless you
pass `--greedy`. `brew uninstall --zap --cask conduit` also removes the
privileged helper and Conduit's settings, caches and logs. Credentials stay in
your Keychain.

## Updates

A scheduled workflow points the cask at the latest Conduit release every six
hours. It checks that the disk image's SHA-256 matches the checksum file
published with the release before it commits. Run it by hand from the Actions
tab after a release.
