cask "diskwise" do
  version "1.4"
  sha256 "5e63ad921157405492b89d304a74bb0e6986389ef29b521f462ebe16e5763cf1"

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
