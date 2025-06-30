-- chunkname: @IQIGame\\Module\\Guild\\GuildChallengeModule.lua

local m = {
	score = 0,
	isFight = false,
	getScoreCallBack = Queue.New()
}
local ChallengeRewardData = require("IQIGame.Module.Challenge.ChallengeRewardData")
local GuildChallengeRewardData = require("IQIGame.Module.Guild.GuildChallengeRewardData")

function m.Reload(dailyDupPOD)
	m.DailyDupPOD = dailyDupPOD
	m.getScoreCallBack = Queue.New()

	if m.DailyDupPOD then
		m.CenterGuildChallengePOD = m.DailyDupPOD.common.centerGuildChallengePOD
		m.GuildChallengePOD = m.DailyDupPOD.guildChallengePOD

		m.GetScore()
	end

	m.AddListeners()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.IsShow()
	return false
end

function m.IsOpen()
	local cfgDailyDupData = CfgDailyDupTable[18]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and m.DailyDupPOD ~= nil and m.DailyDupPOD.common.status ~= 0 and PlayerModule.PlayerInfo.guildId > 0
end

function m.Update(dailyDupPOD)
	m.DailyDupPOD = dailyDupPOD
	m.CenterGuildChallengePOD = m.DailyDupPOD.common.centerGuildChallengePOD
	m.GuildChallengePOD = m.DailyDupPOD.guildChallengePOD
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

function m.GetGuildChallengeRewardList()
	local challengeRewards = {}
	local canGetReward = {}

	for i, v in pairsCfg(CfgGuildChallengeChestRewardTable) do
		local state, score, maxScore = m.GetRewardState(v.Id)
		local data = GuildChallengeRewardData.New(v.Id, state, score, maxScore)

		table.insert(challengeRewards, data)

		if data.state == 1 then
			table.insert(canGetReward, data.cid)
		end
	end

	table.sort(canGetReward, function(a, b)
		return CfgGuildChallengeChestRewardTable[a].Sort < CfgGuildChallengeChestRewardTable[b].Sort
	end)

	return challengeRewards, canGetReward
end

function m.GetRewardState(cid)
	local state = 1
	local maxScore = 0
	local score = m.score
	local challengeRewards = {}

	for i, v in pairsCfg(CfgGuildChallengeChestRewardTable) do
		table.insert(challengeRewards, v)
	end

	table.sort(challengeRewards, function(a, b)
		return a.Sort < b.Sort
	end)

	for i = 1, #challengeRewards do
		local cfg = challengeRewards[i]

		if cfg.Id == cid then
			maxScore = cfg.NeedPoints

			break
		end
	end

	state = table.indexOf(m.GuildChallengePOD.getRewards, cid) ~= -1 and 3 or maxScore <= score and 1 or 2

	return state, score, maxScore
end

function m.GetPassMaxBossLevel()
	local historyLv = 1

	if m.GuildChallengePOD then
		historyLv = m.GuildChallengePOD.currBossLevel
	end

	local guildChallengeLayers = m.GetGuildChallengeLayerList()
	local openMaxLv = 1

	for i, v in pairs(guildChallengeLayers) do
		local top = m.ChallengeLayerIsUnlock(v.Id)

		if top and openMaxLv < v.Level then
			openMaxLv = v.Level
		end
	end

	local endLv = math.min(historyLv, openMaxLv)

	return endLv
end

function m.ChallengeLayerIsPass(cid)
	local cfgLayerData = CfgGuildChallengeLayerTable[cid]
	local passLv = m.GetPassMaxBossLevel()

	return passLv >= cfgLayerData.Level
end

function m.ChallengeLayerIsUnlock(cid)
	local cfgLayerData = CfgGuildChallengeLayerTable[cid]

	for i = 1, #cfgLayerData.NeedBuildingLv, 2 do
		local buildID = cfgLayerData.NeedBuildingLv[i]
		local needBuildLv = cfgLayerData.NeedBuildingLv[i + 1]
		local buildLv, buildMaxLv = GuildModule.GetBuildingLevel(buildID)

		if buildLv < needBuildLv then
			return false
		end
	end

	return true
end

function m.Shutdown()
	m.RemoveListeners()
	m.getScoreCallBack:Clear()

	m.isFight = false
	m.CenterGuildChallengePOD = nil
	m.GuildChallengePOD = nil
	m.DailyDupPOD = nil
end

function m.Attack(formationID, layerCid)
	if m.isFight then
		return
	end

	net_guildChallenge.attack(formationID, layerCid)

	m.isFight = true
end

function m.GetRewards(ids)
	net_guildChallenge.getRewards(ids)
end

function m.MoPup(layerCid, count)
	net_guildChallenge.mopup(layerCid, count)
end

function m.GetScore(callBack)
	if callBack then
		m.getScoreCallBack:Enqueue(callBack)
	end

	if m.IsOpen() then
		net_guildChallenge.getScore()
	elseif m.getScoreCallBack.Size > 0 then
		local callBack = m.getScoreCallBack:Dequeue()

		callBack()
	end
end

function m.AttackResult(layerCid)
	return
end

function m.GetRewardsResult(ids, getItems)
	for i, v in pairs(ids) do
		if table.indexOf(m.GuildChallengePOD.getRewards, v) == -1 then
			table.insert(m.GuildChallengePOD.getRewards, v)
		end
	end

	if #getItems > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, getItems)
	end

	m.GetScore()
end

function m.MoPupResult(layerCid, getItems, count)
	if #getItems > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, getItems)
	end

	m.GetScore()
end

function m.GetScoreResult(score)
	m.score = score

	EventDispatcher.Dispatch(EventID.GuildChallengeUpdateEvent)

	if m.getScoreCallBack.Size > 0 then
		local callBack = m.getScoreCallBack:Dequeue()

		callBack()
	end
end

function m.NotifyAttackComplete(win, layerCid, dmgRecords, getItems)
	m.isFight = false

	GuildBattleModule.Instance:QuitBattle()

	local showItems = {}

	for i, v in pairs(getItems) do
		if v.cid ~= 123 then
			table.insert(showItems, v)
		end
	end

	local rewardData = ChallengeRewardData.New(1, win, showItems, nil, nil)

	rewardData.battleType = 2

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)

	if win then
		local level = CfgGuildChallengeLayerTable[layerCid].Level

		if level > m.GuildChallengePOD.currBossLevel then
			m.GuildChallengePOD.currBossLevel = level
		end
	end

	m.GetScore()
end

GuildChallengeModule = m
