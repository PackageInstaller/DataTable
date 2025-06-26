-- chunkname: @IQIGame\\Module\\Maze\\ActivityMaze\\RpgMazeModule.lua

local RpgMazeDailyDupPOD = {
	common = {
		status = 0,
		openCount = 0,
		openDate = 0,
		cid = 0
	},
	rpgMazePOD = {
		tickets = 0,
		exBossOpen = false,
		freeChallengeBossCount = 0,
		lastAttackExBossTime = 0,
		controlCid = 0,
		dolls = {},
		unlockBoss = {},
		killedBoss = {}
	}
}

RpgMazeModule = {}

function RpgMazeModule.Reload(dailyDupPOD)
	if dailyDupPOD == nil then
		return
	end

	RpgMazeModule.Update(dailyDupPOD)
end

function RpgMazeModule.Update(dailyDupPOD)
	local oldControlCid = 0

	if RpgMazeModule.DailyDupPOD ~= nil then
		oldControlCid = RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid
	end

	local isClear = false

	if dailyDupPOD.rpgMazePOD.controlCid == 0 and oldControlCid ~= 0 then
		isClear = true
	end

	RpgMazeModule.DailyDupPOD = dailyDupPOD

	if isClear then
		RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid = oldControlCid
	end
end

function RpgMazeModule.IsShow()
	local cfgDailyDupData = CfgDailyDupTable[8]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and RpgMazeModule.DailyDupPOD ~= nil and RpgMazeModule.DailyDupPOD.common.status ~= 0
end

function RpgMazeModule.UpdateTickets(value)
	RpgMazeModule.DailyDupPOD.rpgMazePOD.tickets = value

	EventDispatcher.Dispatch(EventID.RpgMazeUpdateTicket)
end

function RpgMazeModule.IsUnlockBoos(boosID)
	if RpgMazeModule.DailyDupPOD.rpgMazePOD then
		return table.indexOf(RpgMazeModule.DailyDupPOD.rpgMazePOD.unlockBoss, boosID) ~= -1
	end

	return false
end

function RpgMazeModule.ExBossOpen()
	if RpgMazeModule.DailyDupPOD.rpgMazePOD then
		return RpgMazeModule.DailyDupPOD.rpgMazePOD.exBossOpen
	end

	return false
end

function RpgMazeModule.ChallengeBoss(formationId, bossCid, isFree)
	if RpgMazeModule.DailyDupPOD.common.status ~= 1 then
		NoticeModule.ShowNotice(21057003)

		return
	end

	net_rpgMaze.challengeBoss(formationId, bossCid, isFree)
end

function RpgMazeModule.ChallengeExBoss(formationId)
	if RpgMazeModule.DailyDupPOD.common.status ~= 1 then
		NoticeModule.ShowNotice(21057003)

		return
	end

	net_rpgMaze.challengeExBoss(formationId)
end

function RpgMazeModule.ChallengeBossResult()
	return
end

function RpgMazeModule.ChallengeExBossResult()
	RpgMazeModule.DailyDupPOD.rpgMazePOD.lastAttackExBossTime = PlayerModule.GetServerTime()

	EventDispatcher.Dispatch(EventID.RpgMazeUpdateExBossCD)
end

function RpgMazeModule.NotifyChallengeBossComplete(win, bossCid, getItems, openExBoss)
	MainCityBattleModule.Instance:QuitBattle()

	local rewardData = ChallengeRewardData.New(1, win, getItems, nil, nil)

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)

	if openExBoss then
		NoticeModule.ShowNoticeByType(1, MazeBossDetailUIApi:GetString("OpenEXBoss"))
	end
end

function RpgMazeModule.NotifyChallengeExBossComplete(win, getItems, dmgRecords)
	MainCityBattleModule.Instance:QuitBattle()

	local rewardData = ChallengeRewardData.New(1, win, getItems, nil, dmgRecords)

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)
end

function RpgMazeModule.GetExploreUIAsset()
	local cfgRPGMazeControlData = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid]

	return cfgRPGMazeControlData.ExploreHallUIBG
end

function RpgMazeModule.GetMallCidList()
	local controlCid = RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid
	local cfgRPGMazeControlData = CfgRPGMazeControlTable[controlCid]

	return cfgRPGMazeControlData.MallIds
end

function RpgMazeModule.Shutdown()
	RpgMazeModule.DailyDupPOD = nil
end
