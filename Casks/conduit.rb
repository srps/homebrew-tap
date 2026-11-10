cask "conduit" do
  version "0.6.2"
  sha256 "ebca4557c09bf32b942095c1810494837700536139dab3a3eb2ab328ef079a0e"

  url "https://github.com/srps/Conduit/releases/download/v#{version}/Conduit-#{version}-macOS26-arm64.dmg"
  name "Conduit"
  desc "Menu bar proxy manager for corporate networks"
  homepage "https://github.com/srps/Conduit"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Conduit.app"

  uninstall quit: "io.github.srps.Conduit"

  zap launchctl: "io.github.srps.Conduit.Helper",
      delete:    [
        "/Library/Application Support/io.github.srps.Conduit",
        "/Library/LaunchDaemons/io.github.srps.Conduit.Helper.plist",
        "/Library/PrivilegedHelperTools/io.github.srps.Conduit.Helper",
      ],
      trash:     [
        "~/Library/Application Support/Conduit",
        "~/Library/Caches/io.github.srps.Conduit",
        "~/Library/Caches/io.github.srps.Conduit.Updater",
        "~/Library/HTTPStorages/io.github.srps.Conduit",
        "~/Library/Logs/Conduit",
        "~/Library/Preferences/io.github.srps.Conduit.plist",
        "~/Library/Preferences/io.github.srps.Conduit.Updater.plist",
      ]

  caveats <<~EOS
    Conduit is signed with its own release certificate and is not notarized.
    If macOS blocks the first launch, open System Settings > Privacy & Security
    and choose Open Anyway.

    Managing the macOS proxy and DNS settings needs Conduit's privileged
    helper. Install it from Conduit's Settings.

    Conduit updates itself, so `brew upgrade` leaves it alone unless you pass
    --greedy.
  EOS
end
