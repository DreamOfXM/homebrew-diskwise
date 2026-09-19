# Homebrew tap for DiskWise

One-command install (fully-qualified, so Homebrew trusts just this cask):

```sh
brew install --cask dreamofxm/diskwise/diskwise
```

Or tap once and use the short name — since Homebrew 6, third-party taps are untrusted by
default, so the `brew trust` step is required:

```sh
brew tap DreamOfXM/diskwise
brew trust --cask dreamofxm/diskwise/diskwise
brew install --cask diskwise
```

[DiskWise](https://github.com/DreamOfXM/diskwise) is a free, open-source macOS disk cleaner:
every removal goes to the Trash and stays undoable, no telemetry, no daemon, no network access.

## Why a personal tap instead of official homebrew-cask

The published build is ad-hoc signed and not notarized. Official `homebrew-cask` won't take a
cask that needs a Gatekeeper workaround, and its acceptance policy also asks for existing
notability (forks / watchers / stars well above what this project has today). Once Developer ID
signing and notarization ship, the intent is to submit upstream and retire this tap.

Trust policy: <https://docs.brew.sh/Tap-Trust> ·
Acceptable casks: <https://docs.brew.sh/Acceptable-Casks> ·
Acceptance policy: <https://docs.brew.sh/Package-Acceptance-Policy>

## Bumping the version

`Casks/diskwise.rb` pins a version and a SHA-256, and the asset name follows the release tag
plus the architecture it was built for: tag `v1.2.0` shipped `DiskWise-1.2.dmg` (arm64 only),
tag `v1.3` ships `DiskWise-1.3-universal.dmg`. To bump:

```sh
shasum -a 256 DiskWise-<version>-universal.dmg   # from the release asset, not a local rebuild
# edit version + sha256 in Casks/diskwise.rb, then:
brew audit --cask --strict --online dreamofxm/diskwise/diskwise
brew style --cask Casks/diskwise.rb
```

`brew bump --open-pr diskwise` can open the PR once this tap is public on GitHub.

## Status

End-to-end verified on 2026-09-17 on an Apple Silicon Mac:

```console
$ brew install --cask dreamofxm/diskwise/diskwise
🍺  diskwise was successfully installed!
```

Homebrew downloaded the release DMG, accepted the pinned SHA-256, and moved `DiskWise.app` to
`/Applications` (bundle version 1.2). Gatekeeper was then inspected rather than assumed:

| Check | Result |
|-------|--------|
| `xattr /Applications/DiskWise.app` | `com.apple.quarantine` present |
| `spctl --assess --type execute` | `rejected` |
| `codesign -dv` | `Signature=adhoc`, `TeamIdentifier=not set` |

So installing through Homebrew does **not** bypass the first-launch confirmation — which is why
the cask ships the `caveats` block. This changes when Developer ID signing and notarization land
in the app itself, not in this tap.
