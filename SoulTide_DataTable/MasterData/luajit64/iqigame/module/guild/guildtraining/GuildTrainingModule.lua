-- chunkname: @IQIGame\\Module\\Guild\\GuildTraining\\GuildTrainingModule.lua

local m = {
	myGuildScore = 0,
	myGuildRanking = -1,
	isFight = false,
	guildRankings = {},
	centerGuildTrainingPlayerRanks = {}
}
local ChallengeRewardData = require("IQIGame.Module.Challenge.ChallengeRewardData")

function m.Reload(dailyDupPOD)
	m.DailyDupPOD = dailyDupPOD

	if m.DailyDupPOD then
		m.CenterGuildTrainingPOD = m.DailyDupPOD.common.centerGuildTrainingPOD
		m.GuildTrainingPOD = m.DailyDupPOD.guildTrainingPOD

		m.GetGuildTrainingIntegral()
	end

	m.InitData()
	m.AddListeners()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.InitData()
	m.guildRankMaxNum = 0

	for i, v in pairsCfg(CfgGuildTrainingRankRewardTable) do
		if v.RankType == 1 and v.RankUpperLimit > m.guildRankMaxNum then
			m.guildRankMaxNum = v.RankUpperLimit
		end
	end
end

function m.GetGuildChallengeLayerList()
	local tab = {}

	if m.CenterGuildChallengePOD then
		for i, v in pairsCfg(CfgGuildChallengeLayerTable) do
			if v.BossType == m.CenterGuildChallengePOD.bossType then
				table.insert(tab, v)
			end
		end
	end

	table.sort(tab, function(a, b)
		return a.Level < b.Level
	end)

	return tab
end

function m.IsShow()
	return false
end

function m.IsOpen()
	local cfgDailyDupData = CfgDailyDupTable[22]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and m.DailyDupPOD ~= nil and m.DailyDupPOD.common.status ~= 0 and PlayerModule.PlayerInfo.guildId > 0
end

function m.IsGetReward(cid)
	if m.GuildTrainingPOD and m.GuildTrainingPOD.getAward and table.indexOf(m.GuildTrainingPOD.getAward, cid) ~= -1 then
		return true
	end

	return false
end

function m.Update(dailyDupPOD)
	m.DailyDupPOD = dailyDupPOD
	m.CenterGuildTrainingPOD = m.DailyDupPOD.common.centerGuildTrainingPOD
	m.GuildTrainingPOD = m.DailyDupPOD.guildTrainingPOD

	m.GetGuildTrainingIntegral()
	m.GetRanking()
end

function m.Refresh()
	m.GetGuildTrainingIntegral()
	m.GetRanking()
end

function m.ResetIntegral()
	if m.DailyDupPOD and m.DailyDupPOD.guildTrainingPOD then
		m.DailyDupPOD.guildTrainingPOD.maxIntegral = 0
	end

	if m.GuildTrainingPOD then
		m.GuildTrainingPOD.maxIntegral = 0

		EventDispatcher.Dispatch(EventID.GuildUpdateTrainingMemberEvent)
	end
end

function m.Shutdown()
	m.RemoveListeners()

	m.isFight = false
	m.DailyDupPOD = nil
	m.CenterGuildTrainingPOD = nil
	m.GuildTrainingPOD = nil
	m.guildRankMaxNum = nil
	m.centerGuildTrainingPlayerRanks = {}
end

function m.GetGuildTrainingIntegral()
	if PlayerModule.PlayerInfo.guildId == 0 then
		return
	end

	if not m.IsOpen() then
		return
	end

	net_centerGuild.getGuildTrainingIntegral()
end

function m.GetRanking()
	if PlayerModule.PlayerInfo.guildId == 0 then
		return
	end

	if not m.IsOpen() then
		return
	end

	CenterRankModule.GetRanking(Constant.RankingType.GuildTrainingRank, m.guildRankMaxNum, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		m.guildRankings = rankings
		m.myGuildRanking = myRanking

		log("排行数据更新 " .. myScore)

		m.myGuildScore = tonumber(myScore)
		m.myGuildRankType = rankType

		if GameEntry.Base.DevMode then
			log("获取公会排名数据： m.myGuildRanking =" .. m.myGuildRanking .. " m.myGuildScore = " .. m.myGuildScore .. " m.myGuildRankType =" .. m.myGuildRankType)
		end

		EventDispatcher.Dispatch(EventID.GuildUpdateTrainingRankEvent)
	end)
end

function m.Attack(formationId, id)
	if not m.IsOpen() then
		return
	end

	if m.isFight then
		return
	end

	net_guildTraining.attack(formationId, id)

	m.isFight = true
end

function m.GetGuildTrainingIntegralResult(centerGuildTrainingPlayerRanks)
	m.centerGuildTrainingPlayerRanks = centerGuildTrainingPlayerRanks

	if GameEntry.Base.DevMode then
		log("返回:获取工会试炼积分以及试炼贡献列表 列表长度 " .. #centerGuildTrainingPlayerRanks)
	end

	EventDispatcher.Dispatch(EventID.GuildUpdateTrainingMemberEvent)
end

function m.AttackResult()
	return
end

function m.NotifyAttackEnd(win, dmgRecords, items, maxScore, getAward)
	m.isFight = false
	m.GuildTrainingPOD.maxIntegral = maxScore
	m.GuildTrainingPOD.getAward = getAward

	GuildBattleModule.Instance:QuitBattle()

	local rewardData = ChallengeRewardData.New(1, win, items, nil, nil)

	rewardData.battleType = 2

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)
	m.Refresh()
end

GuildTrainingModule = m
