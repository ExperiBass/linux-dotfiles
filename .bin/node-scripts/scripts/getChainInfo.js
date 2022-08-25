const mempoolJS = require('@mempool/mempool.js')
const chalk = require('chalk')
const {get, default: axios} = require('axios')
const Numeral = require("numeral")

const init = async () => {
    // try to use self-hosted node over mempool.space
    let server = 'mempool.space'
    let flag = ''
    try {
        await axios.get("localhost:4998")
        server = 'localhost:4998'
        flag = '﨩 '
    } catch (e) {
	    // ignore, cant connect
    }
    const { bitcoin: { fees, difficulty, blocks, mempool } } = mempoolJS({
        hostname: server
    })

    const recomendedFees = await fees.getFeesRecommended()
    const x = chalk.gray.underline("sat/vB")
    const x2 = chalk.gray.underline("EH/s")

    // its done this way for ease of reading
    // its probably bad practice but better than one loooooooooong line
    const feeInfo = [
        ` ${chalk.green(recomendedFees.economyFee)}`,
        `廒 ${chalk.green(recomendedFees.hourFee)}`,
        `ﰌ ${chalk.green(recomendedFees.halfHourFee)}`,
        `省 ${chalk.green(recomendedFees.fastestFee)}`
    ]

    const diffAdjustInfo = await difficulty.getDifficultyAdjustment()
    let diffChange = ` ${diffAdjustInfo.difficultyChange.toFixed(2)}%`
    if (diffAdjustInfo.difficultyChange > 0) {
        diffChange = chalk.green(`${diffChange}`)
    } else if (diffAdjustInfo.difficultyChange < 0) {
        diffChange = chalk.red(`${diffChange}`)
    } else {
        // Mimick mempool.space and display no percentage 
        diffChange = chalk.green(` —.——`)
    }
    const diffInfo = [
        ` ${chalk.yellow(diffAdjustInfo.progressPercent.toFixed(2) + "%")}`,
        `${diffChange}`,
        ` ${Numeral(diffAdjustInfo.remainingBlocks).format()}`
    ]

    const currHeight = await blocks.getBlocksTipHeight()

    const currMempool = await mempool.getMempool()

    const mempoolInfo = [
        `ﬅ ${Numeral(currMempool.count).format()} ${chalk.gray.underline("TXs")}`,
        ` ${(currMempool.vsize / 1000000).toFixed(2)} ${chalk.gray.underline("MvB")}`
    ]

    // the rest of this isnt in the mempool module
    const {currentHashrate} = (await get('https://mempool.space/api/v1/mining/hashrate/3d')).data

    const currHashrate = (currentHashrate / Number(1000000000000000000n)).toFixed(2) // EH/s

    const finalInfo = [
        `${feeInfo.join(` ${x} | `)} ${x}`,
        `${mempoolInfo.join(" | ")}`,
        `${diffInfo.join(" | ")}`,
        `ﲗ ${Numeral(currHeight).format()} | ﬙ ${currHashrate} ${x2}`
    ]

    console.log(`${flag}${finalInfo.join(" | ")}`)
}

init()
