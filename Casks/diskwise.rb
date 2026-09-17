cask "diskwise" do
  version "1.2.0"
  sha256 "1b355b8855199fd3af1fa6994dee89a4d04ba977e35732b3db7624053fb8b6b4"

  url "https://github.com/DreamOfXM/diskwise/releases/download/v#{version}/DiskWise-#{version.sub(/\.0$/, "")}.dmg",
      verified: "github.com/DreamOfXM/diskwise/"
  name "DiskWise"
  desc "Open-source macOS disk cleaner that only ever moves files to the Trash"
  homepage "https://github.com/DreamOfXM/diskwise"

  livecheck do
    url "https://github.com/DreamOfXM/diskwise/releases"
    strategy :github_latest
  end

  # Universal (Intel + arm64) builds are on the roadmap; the published DMG is
  # arm64-only until Developer ID signing lands.
  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "DiskWise.app"

  caveats "DiskWise is ad-hoc signed and not notarized by Apple, so Gatekeeper may ask you " \
          "to confirm once on first launch. Notarization is on the project roadmap."

  uninstall quit: "com.dreamofxm.diskcleaner"

  zap trash: [
    "~/Library/Preferences/com.dreamofxm.diskcleaner.plist",
    "~/Library/Caches/com.dreamofxm.diskcleaner",
    "~/Library/Saved Application State/com.dreamofxm.diskcleaner.savedState",
  ]
end
