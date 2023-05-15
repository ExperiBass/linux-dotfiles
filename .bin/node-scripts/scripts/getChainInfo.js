const mempoolJS = require('@mempool/mempool.js')
const chalk = require('chalk')
const { get } = require('axios')
const Numeral = require("numeral")

function clamp(num, min, max) {
    return Math.min(Math.max(num, min), max)
}
const main = async () => {
    const satvb = chalk.gray.underline("sat/vB")

    const { bitcoin: { fees, difficulty, blocks, mempool } } = mempoolJS({
        hostname: 'mempool.space'
    })

    const recomendedFees = await fees.getFeesRecommended()

    const feeInfo = [
        `󰁬 ${chalk.green(recomendedFees.economyFee)}`,
        `󰖃 ${chalk.green(recomendedFees.hourFee)}`,
        `󰜎 ${chalk.green(recomendedFees.halfHourFee)}`,
        `󰑮 ${chalk.green(recomendedFees.fastestFee)}`
    ]

    const diffAdjustInfo = await difficulty.getDifficultyAdjustment()
    let diffChange = ` ${diffAdjustInfo.difficultyChange.toFixed(2)}%`
    if (diffAdjustInfo.difficultyChange > 0) {
        diffChange = chalk.green(`󰁡${diffChange}`)
    } else if (diffAdjustInfo.difficultyChange < 0) {
        diffChange = chalk.red(`󰁉${diffChange}`)
    } else {
        // Mimick mempool.space and display no percentage
        diffChange = chalk.green(`󰋙 —.——`)
    }

    const PROGRESS_ICONS = ['󰋙', '󰫃', '󰫄', '󰫅', '󰫆', '󰫇', '󰫈']
    const segmentSize = 100 / PROGRESS_ICONS.length
    const index = Math.floor(diffAdjustInfo.progressPercent.toFixed(2) / segmentSize)
    const icon = PROGRESS_ICONS[clamp(index, 0, PROGRESS_ICONS.length)]
    const diffInfo = [
        `${icon} ${chalk.yellow(diffAdjustInfo.progressPercent.toFixed(2) + "%")}`,
        `${diffChange}`,
        ` ${Numeral(diffAdjustInfo.remainingBlocks).format()}`
    ]

    const currHeight = await blocks.getBlocksTipHeight()

    const currMempool = await mempool.getMempool()

    const mempoolInfo = [
        `󰘆 ${Numeral(currMempool.count).format()} ${chalk.gray.underline("TXs")}`,
        ` ${(currMempool.vsize / 1000000).toFixed(2)} ${chalk.gray.underline("MvB")}`
    ]

    // the rest of this isnt in the mempool module
    const { currentHashrate } = (await get('https://mempool.space/api/v1/mining/hashrate/3d')).data

    const currHashrate = (currentHashrate / Number(1000000000000000000n)).toFixed(2) // EH/s

    const finalInfo = [
        `${feeInfo.join(` ${satvb} | `)} ${satvb}`,
        `${mempoolInfo.join(" | ")}`,
        `${diffInfo.join(" | ")}`,
        ` ${Numeral(currHeight).format()} | ﬙ ${currHashrate} ${chalk.gray.underline("EH/s")}`
    ]

    return `${finalInfo.join(" | ")}`
    // array.join is my favorite function
}

main().then(console.log).catch(e => console.log(`Failed to fetch info.\n${e}`))
