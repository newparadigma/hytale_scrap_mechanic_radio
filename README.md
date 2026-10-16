# Scrap Mechanic Radio mod for Hytale

## Build

Requires [just](https://github.com/casey/just), `jq` and `zip`.

```bash
just zip   # pack ScrapMechanicRadio/ into ScrapMechanicRadio-<Version>.zip
just mv    # install the zip into the Hytale mods folder, replacing older versions
```

`Version` in `ScrapMechanicRadio/manifest.json` must be `X.Y.Z`.

```bash
just test  # lint workflows with actionlint and tracked *.sh files with shellcheck
```

`just test` requires [actionlint](https://github.com/rhysd/actionlint) and [shellcheck](https://www.shellcheck.net)
(`brew install actionlint shellcheck`); actionlint also runs shellcheck on the workflows' `run:` scripts.

`just mv` uses the macOS mods folder `~/Library/Application Support/Hytale/UserData/mods`.
On other systems or for a custom location set `HYTALE_MODS_DIR`.

## Release

[release.yml](.github/workflows/release.yml) runs on pull requests to `main` and on every push to `main`:

- on a pull request it builds the zip and fails if the mod (`ScrapMechanicRadio/`) changed but the `v<Version>` tag already exists, so bump `Version` in the PR
- on a push (e.g. a merged PR) it builds the zip and creates the `v<Version>` tag and a GitHub release with the zip attached; if the tag already exists, the release is skipped

Bump `Version` only for changes to the mod itself. Changes to the build, CI or docs don't need a new version and don't make a release.

### CurseForge

After the GitHub release the `curseforge` job uploads the release zip to the CurseForge project
(this mod: [1707079](https://authors.curseforge.com/#/projects/1707079/files)) with the release notes as changelog,
game version `Early Access` (`CURSEFORGE_GAME_VERSION` in the workflow) and `isMarkedForManualRelease: true`,
so after moderation the file still waits for a manual release.

The Upload API host `1430699.curseforge.com` is fixed in the workflow:
`hytale.curseforge.com` is the promo site and returns 404 for `/api`.

The job is skipped until `CURSEFORGE_PROJECT_ID` is set. Configure in Settings → Secrets and variables → Actions:

- repository variable `CURSEFORGE_PROJECT_ID` — numeric project ID, `1707079`
  (must be a repository variable, not an environment one: the job condition is checked before the environment is entered)
- secret `CURSEFORGE_TOKEN` — upload token from authors.curseforge.com → API Tokens
  (repository secret, or a secret of the `curseforge` environment, where you can also require manual approval)

To upload an existing release (e.g. one made before CurseForge was configured), run the workflow manually
from Actions → Release → Run workflow with its tag, e.g. `v1.0.2`.

CurseForge doesn't reject duplicates. If the upload step fails, check the project's Files before re-running:
the file may have been accepted anyway.
