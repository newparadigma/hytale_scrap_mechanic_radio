# Scrap Mechanic Radio mod for Hytale

## Build

Requires [just](https://github.com/casey/just).

```bash
just zip   # pack ScrapMechanicRadio/ into ScrapMechanicRadio-<Version>.zip
just mv    # replace old ScrapMechanicRadio*.zip in the Hytale mods folder with the new one
```

## Release

Every push to `main` (e.g. a merged PR) runs [release.yml](.github/workflows/release.yml):
it reads `Version` from `ScrapMechanicRadio/manifest.json`, builds the zip with `just zip`
and creates the `v<Version>` tag and a GitHub release with the zip attached.
If the tag already exists, the release is skipped — bump `Version` in the PR to publish.
