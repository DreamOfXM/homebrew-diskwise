cask "diskwise" do
  version "1.5"
  sha256 "6cd3882bccdfbbe84248f57ade9f21c7e750d6f39c7161eebef0b335d5041fb1"

  url "https://github.com/DreamOfXM/diskwise/releases/download/v#{version}/DiskWise-#{version}-universal.dmg"
  name "DiskWise"
  desc "Open-source disk cleaner that only ever moves files to the Trash"
  homepage "https://github.com/DreamOfXM/diskwise"

  livecheck do
    url "https://github.com/DreamOfXM/diskwise/releases"
    strategy :github_latest
  end

  # From v1.3 the published DMG is a universal binary (arm64 + x86_64), so there is
  # no architecture to pin here.
  depends_on macos: :ventura

  app "DiskWise.app"

  uninstall quit: "com.dreamofxm.diskcleaner"

  zap trash: [
    "~/Library/Caches/com.dreamofxm.diskcleaner",
    "~/Library/Preferences/com.dreamofxm.diskcleaner.plist",
    "~/Library/Saved Application State/com.dreamofxm.diskcleaner.savedState",
  ]

  caveats "DiskWise is ad-hoc signed and not notarized by Apple, so the first launch gets " \
          "blocked: approve it in System Settings -> Privacy & Security -> Open Anyway. " \
          "(On macOS 13-14, right-click -> Open works instead.) Installing through Homebrew " \
          "does not skip that step: the cask fetches the very file the Releases page offers."
end
