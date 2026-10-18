# adstenographer-releases

Published builds of Stenographer, a macOS app that records Claude Code session
activity. This repo holds release output only; the source lives elsewhere.

`scripts/release.py` in the Stenographer repo writes everything here. Don't
edit these files by hand.

| Path | What it is | Who reads it |
|---|---|---|
| GitHub Release `vX.Y.Z` | `Stenographer-X.Y.Z.pkg` (first install) and `Stenographer-X.Y.Z.zip` (Sparkle update) | people installing Stenographer, and Sparkle |
| `releases.json` | release metadata (schema 1), newest first | agenticdeveloperstenographer.com `/downloads` |
| `appcast.xml` | EdDSA-signed Sparkle feed | agenticdeveloperstenographer.com `/appcast.xml`, which installed apps poll |
| `notes/X.Y.Z.md` | release notes | `/downloads` and Sparkle's update dialog |

The website reads these files at request time, so publishing a release never
needs a site deploy. Installed apps poll the site's `/appcast.xml`
(`https://agenticdeveloperstenographer.com/appcast.xml` from 1.2.118;
`https://agenticstenographer.app/appcast.xml` before it), never this repo directly. That way the storage can move without leaving
installed copies behind.
