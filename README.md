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

`Casks/diskwise.rb` pins a version and a SHA-256, and the DMG filename drops the patch number
(`v1.2.0` → `DiskWise-1.2.dmg`). To bump:

```sh
shasum -a 256 DiskWise-<version>.dmg          # from the release asset, not a local rebuild
# edit version + sha256 in Casks/diskwise.rb, then:
brew audit --cask --strict --online dreamofxm/diskwise/diskwise
brew style --cask Casks/diskwise.rb
```

`brew bump --open-pr diskwise` can open the PR once this tap is public on GitHub.

## Status

The cask loads and audits from this tap. End-to-end `brew install` has to be re-verified on a
network that allows HEAD requests to GitHub release assets — it was written and checked where
those requests were blocked.
