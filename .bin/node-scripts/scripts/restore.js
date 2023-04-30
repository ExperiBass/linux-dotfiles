const args = process.argv.slice(2)
const path = require('path')
const {readdirSync} = require('fs')
const {execSync} = require('child_process')
const os = require('os')
const undo_regex = /🭹/ig
// https://stackoverflow.com/a/36221905
function resolveHome(filepath) {
    if (filepath[0] === '~') {
        return path.join(os.homedir(), filepath.slice(1))
    }
    return filepath
}
const backups_source = resolveHome(args[0])

for (const backup of readdirSync(backups_source)) {
    if (backup === "restore_ignore") {
        continue
    }
    const dest = backup.replace(undo_regex, "/")
    try {
        execSync(`/bin/cp -nv ${backups_source}/${backup.replace(undo_regex, "\\🭹")} ${dest}`, {shell:true})
        console.log(`Restored ${backup} to ${dest}.`)
    } catch (e) {
        console.log(`\n${e}\n`)
    }
}