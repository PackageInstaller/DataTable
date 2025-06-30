-- chunkname: @IQIGame\\Net\\NetLotteryResponse.lua

NetLotteryResponse = {}

function net_lottery.lotteryResult(code, lotteryShowPOD, lotteryCid, lotteryRecords, baseShowItems, showItems)
	LotteryModule.LotteryResult(lotteryShowPOD, lotteryCid, lotteryRecords, baseShowItems, showItems)
end

function net_lottery.getLotteryHistoryResult(code, lotteryHistoryList)
	LotteryModule.OnGetHistory(lotteryHistoryList)
end
