# Scrap Mechanic Radio mod for Hytale

## Build

Requires [just](https://github.com/casey/just), `jq` and `zip`.

```bash
just zip   # pack ScrapMechanicRadio/ into ScrapMechanicRadio-<Version>.zip
just mv    # install the zip into the Hytale mods folder, replacing older versions
```

`Version` in `ScrapMechanicRadio/manifest.json` must be `X.Y.Z`.

`just mv` uses the macOS mods folder `~/Library/Application Support/Hytale/UserData/mods`.
On other systems or for a custom location set `HYTALE_MODS_DIR`.

## Release

[release.yml](.github/workflows/release.yml) runs on pull requests to `main` and on every push to `main`:

- on a pull request it builds the zip and fails if the `v<Version>` tag already exists, so bump `Version` in the PR
- on a push (e.g. a merged PR) it builds the zip and creates the `v<Version>` tag and a GitHub release with the zip attached; if the tag already exists, the release is skipped
