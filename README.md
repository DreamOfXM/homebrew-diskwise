# Homebrew tap for DiskWise

```sh
brew tap DreamOfXM/diskwise
brew install --cask diskwise
```

[DiskWise](https://github.com/DreamOfXM/diskwise) is a free, open-source macOS disk
cleaner: every removal goes to the Trash and stays undoable, no telemetry, no daemon,
no network access.

## Why a tap instead of official homebrew-cask

The published build is ad-hoc signed and not notarized by Apple, which is the one
thing official `homebrew-cask` will not accept today. Once Developer ID signing and
notarization ship, the plan is to submit upstream and retire this tap.

## What `brew install` does about Gatekeeper

Homebrew fetches the DMG without the `com.apple.quarantine` attribute, so an app
installed through this tap launches normally — the right-click → Open dance described
in the main README is only needed when you download the `.dmg` from Releases in a
browser.

## Keeping the cask current

`Casks/diskwise.rb` pins a version and a SHA-256. To bump it:

```sh
brew bump --open-pr diskwise        # or, manually:
shasum -a 256 DiskWise-<version>.dmg
```

Update `version`, `sha256`, and run `brew audit --cask --strict diskwise --tap=DreamOfXM/diskwise`
before pushing.
