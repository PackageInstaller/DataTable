-- chunkname: @IQIGame\\Net\\NetClimbTowerResponse.lua

function net_climbTowerDup.enterDupResult(code)
	TowerChapterModule.RpcEnterDupResult()
end

function net_climbTowerDup.dailyPrizeResult(code, dailyStatus, items)
	TowerChapterModule.RpcDailyPrizeResult(dailyStatus, items)
end

function net_climbTowerDup.notifyDup(dupPODs)
	TowerChapterModule.RpcNotifyDup(dupPODs)

	PlayerModule.PlayerInfo.climbTowerDups = dupPODs
end
