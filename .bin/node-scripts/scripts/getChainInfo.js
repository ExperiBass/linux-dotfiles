const mempoolJS = require('@mempool/mempool.js')
const chalk = require('chalk')
const {get} = require('axios')

const init = async () => {
    const { bitcoin: { fees, difficulty, blocks, mempool } } = mempoolJS({
        hostname: 'mempool.space'
    })

    const recomendedFees = await fees.getFeesRecommended()
    const x = chalk.gray.underline("sat/vB")
    const x2 = chalk.gray.underline("EH/s")

    // its done this way for ease of reading
    // its probably bad practice but better than one loooooooooong line
    const feeInfo = [
        `省 ${chalk.green(recomendedFees.fastestFee)}`,
        `ﰌ ${chalk.green(recomendedFees.halfHourFee)}`,
        `廒 ${chalk.green(recomendedFees.hourFee)}`,
        ` ${chalk.green(recomendedFees.economyFee)}`
    ]

    const diffAdjustInfo = await difficulty.getDifficultyAdjustment()
    let diffChange = ` ${diffAdjustInfo.difficultyChange.toFixed(2)}`
    if (diffAdjustInfo.difficultyChange >= 0) {
        diffChange = chalk.green(`${diffAdjustInfo.difficultyChange === 0 ? " " : ""}${diffChange}`)
    } else if (diffAdjustInfo.difficultyChange < 0) {
        diffChange = chalk.red(`${diffChange}`)
    }
    const diffInfo = [
        ` ${chalk.yellow(diffAdjustInfo.progressPercent.toFixed(2) + "%")}`,
        `${diffChange}`,
        ` ${diffAdjustInfo.remainingBlocks}`
    ]

    const currHeight = await blocks.getBlocksTipHeight()

    const currMempool = await mempool.getMempool()

    const mempoolInfo = [
        `ﬅ ${currMempool.count} ${chalk.gray.underline("TXs")}`,
        ` ${(currMempool.vsize / 1000000).toFixed(2)} ${chalk.gray.underline("MvB")}`
    ]

    // the rest of this isnt in the mempool module
    const {currentHashrate} = (await get('https://mempool.space/api/v1/mining/hashrate/3d')).data

    const currHashrate = (currentHashrate / Number(1000000000000000000n)).toFixed(2) // EH/s

    const finalInfo = [
        `${feeInfo.join(` ${x} | `)} ${x}`,
        `${mempoolInfo.join(" | ")}`,
        `${diffInfo.join(" | ")}`,
        `ﲗ ${currHeight} | ﬙ ${currHashrate} ${x2}`
    ]

    console.log(`ﴑ | ${finalInfo.join(" | ")}`)
}

init()