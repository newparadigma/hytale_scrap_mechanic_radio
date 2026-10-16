mod_name := "ScrapMechanicRadio"
version := `jq -r .Version ScrapMechanicRadio/manifest.json`
zip_file := mod_name + "-" + version + ".zip"
mods_dir := home_directory() / "Library/Application Support/Hytale/UserData/mods"

zip:
    @rm -f {{zip_file}}
    @cd {{mod_name}} && zip -rq ../{{zip_file}} . -x '*.DS_Store'

mv:
    @test -f {{zip_file}}
    @rm -f "{{mods_dir}}"/{{mod_name}}*.zip
    @mv {{zip_file}} "{{mods_dir}}"
