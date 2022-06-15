const watcher = require('filewatcher')()
const {execSync} = require('child_process')
const { existsSync } = require('fs')
const os = require('os')

const watched_files = [
    "/etc/grub.d/10_default",
    "/etc/dracut.conf.d/99-custom.conf",
    "/etc/udev/rules.d/99-input.rules",
    "/etc/pacman.conf",
    "/boot/EFI/refind/refind.conf"
]
const replacer_char = "\\🭹"
const backup_path = `${os.homedir()}/Documents/Backups`

function copy(file, stat) {
    console.log(`File ${stat ? 'modified' : 'deleted'}: ${file}`)

    try {
        //const filename = file.split('/').reverse()[0]
        const filename = file.replace(/\//g, replacer_char)
        const dest = `${backup_path}/${filename}`
        if (stat) {
            execSync(`/bin/cp ${file} ${dest}`, {shell:true})
            console.log(`Copied: ${file} -> ${dest}`)
        } else {
            if (!existsSync(dest)) {
                return
            }
            execSync(`/bin/rm ${dest}`, {shell:true})
            console.log(`Deleted backup.`)
        }
    } catch (e) {
        console.log(`\n${e}\n`)
    }
}

watcher.on('change', copy)

for (const file of watched_files) {
    watcher.add(file)
    console.log(`Watching: ${file}`)

    const filename = file.replace(/\//g, "🭹")
    const dest = `${backup_path}/${filename}`
    if (!existsSync(dest)) {
        copy(file, true)
    }
}

process.on('beforeExit', () => {
    watcher.removeAll()
})