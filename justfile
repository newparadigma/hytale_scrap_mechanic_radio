mod_name := "ScrapMechanicRadio"
_manifest_version := `jq -r '.Version // empty' ScrapMechanicRadio/manifest.json`
version := if _manifest_version =~ '^[0-9]+\.[0-9]+\.[0-9]+$' { _manifest_version } else { error("Version in manifest.json must be X.Y.Z, got: " + _manifest_version) }
zip_file := mod_name + "-" + version + ".zip"
mods_dir := env("HYTALE_MODS_DIR", home_directory() / "Library/Application Support/Hytale/UserData/mods")

zip:
    @rm -f {{quote(mod_name)}}-[0-9]*.zip
    @cd {{quote(mod_name)}} && zip -rq {{quote("../" + zip_file)}} . -x '*.DS_Store'

mv:
    @test -f {{quote(zip_file)}} || { echo "{{zip_file}} not found, run 'just zip' first" >&2; exit 1; }
    @test -d {{quote(mods_dir)}} || { echo "mods folder not found: {{mods_dir}}" >&2; exit 1; }
    @mv {{quote(zip_file)}} {{quote(mods_dir + "/")}}
    @find {{quote(mods_dir)}} -maxdepth 1 -type f \( -name {{quote(mod_name + "-[0-9]*.zip")}} -o -name {{quote(mod_name + ".zip")}} \) ! -name {{quote(zip_file)}} -delete

test: actionlint shellcheck

actionlint:
    @command -v shellcheck > /dev/null || { echo "shellcheck not found: actionlint would skip run: scripts" >&2; exit 1; }
    @actionlint

shellcheck:
    @git ls-files -z '*.sh' | xargs -0 -r shellcheck
