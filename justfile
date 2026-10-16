mod_name := "ScrapMechanicRadio"
mods_dir := home_directory() / "Library/Application Support/Hytale/UserData/mods"

zip:
    @rm -f {{mod_name}}.zip
    @cd {{mod_name}} && zip -rq ../{{mod_name}}.zip . -x '*.DS_Store'

mv:
    @mv {{mod_name}}.zip "{{mods_dir}}"
