-- chunkname: @IQIGame\\Module\\PlotChallenge\\PlotChallengeModule.lua

local m = {
	RewardPoolDataNum = 0,
	CurrentRewardPoolDataNum = 0,
	GlobalCid = 0,
	PrizeDrawPoolRewardList = {}
}
local ChallengeRewardData = require("IQIGame.Module.Challenge.ChallengeRewardData")
local PrizeDrawPoolRewardData = require("IQIGame.Module.PlotChallenge.PrizeDrawPoolRewardData")

function m.Reload(dailyDupPOD)
	m.DailyDupPOD = dailyDupPOD

	if m.DailyDupPOD ~= nil then
		m.GlobalCid = m.DailyDupPOD.common.openCount
		m.currDialog = m.DailyDupPOD.challengeDataPOD.dialogId
		m.RewardPoolData = m.DailyDupPOD.challengeDataPOD.taleChallengeRewardPoolData
	end

	m.RefreshPrizeDrawPoolData()
	m.AddListeners()
end

function m.Update(dailyDupPOD)
	m.DailyDupPOD = dailyDupPOD
	m.RewardPoolData = m.DailyDupPOD.challengeDataPOD.taleChallengeRewardPoolData
	m.GlobalCid = m.DailyDupPOD.common.openCount

	m.RefreshPrizeDrawPoolData()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.GetMonsterWeakTypes(monsterTeamID)
	local sortTab = {}
	local tab = {}
	local cfgMonsterTeam = CfgMonsterTeamTable[monsterTeamID]

	for i = 1, #cfgMonsterTeam.TeamUnit do
		local monsterID = cfgMonsterTeam.TeamUnit[i]

		if monsterID > 0 then
			local cfgMonster = CfgMonsterTable[monsterID]

			if #cfgMonster.WeakType > 0 then
				for i = 1, #cfgMonster.WeakType do
					local id = cfgMonster.WeakType[i]

					if tab[id] == nil then
						local t = {}

						t.weakType = id
						t.num = 1
						tab[id] = t
					else
						tab[id].num = tab[id].num + 1
					end
				end
			end
		end
	end

	for i, v in pairs(tab) do
		table.insert(sortTab, v)
	end

	table.sort(sortTab, function(a, b)
		local res = false

		if a.num == b.num then
			res = a.weakType < b.weakType
		else
			res = a.num > b.num
		end

		return res
	end)

	return sortTab
end

function m.IsShow()
	local cfgDailyDupData = CfgDailyDupTable[12]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and m.DailyDupPOD ~= nil and m.DailyDupPOD.common.status ~= 0
end

function m.ExecutionEvent(plotCid, state)
	local cfg = CfgPlotChallengeActivityTable[plotCid]
	local isPass = m.GetPlotIsOpen(cfg.Id)

	if isPass == false and #cfg.ChallengeNeed > 1 then
		local have = WarehouseModule.GetItemNumByCfgID(cfg.ChallengeNeed[1])
		local need = cfg.ChallengeNeed[2]

		if have < need then
			NoticeModule.ShowNotice(21045026)

			return
		end
	end

	if cfg.Type == 1 then
		m.TriggerChallengeStory(plotCid)
	elseif cfg.Type == 2 then
		UIModule.Open(Constant.UIControllerName.ChallengeDramaBossFormationUI, Constant.UILayer.UI, {
			plotCid,
			state
		})
	end
end

function m.GetExploreUIAsset()
	local cfgPlotChallengeActivityGlobalData = CfgPlotChallengeActivityGlobalTable[m.GlobalCid]

	return cfgPlotChallengeActivityGlobalData.ExploreHallUIBG
end

function m.GetPlotIsOpen(nodeId)
	if m.DailyDupPOD and table.indexOf(m.DailyDupPOD.challengeDataPOD.passedNode, nodeId) ~= -1 then
		return true
	end

	return false
end

function m.CheckResumeDialog()
	if m.currDialog ~= nil and m.currDialog ~= 0 then
		DialogModule.OpenDialog(m.currDialog, false, true)

		m.currDialog = nil
	end
end

function m.GetExploreHallCustomTabText()
	return CfgPlotChallengeActivityGlobalTable[m.GlobalCid].ButtonName
end

function m.Shutdown()
	m.RemoveListeners()

	m.DailyDupPOD = nil
	m.GlobalCid = 0
	m.currDialog = nil
end

function m.RefreshPrizeDrawPoolData()
	m.PrizeDrawPoolRewardList = {}

	for i, v in pairs(CfgPlotChallengeActivityRewardPoolTable) do
		local PoolId = m.GetItemsNumByToggle(i).Id
		local RewardCount = 0

		for j = 1, #v.ItemID do
			local RewardId = v.ItemID[j]
			local RewardTime = v.ItemTime[j]
			local RewardNum = v.ItemNum[j]
			local RewardWeight = v.ItemWeight[j]
			local CurrentRewardTime = v.ItemTime[j] - RewardCount
			local RewardQuality = CfgItemTable[v.ItemID[j]].Quality

			table.insert(m.PrizeDrawPoolRewardList, PrizeDrawPoolRewardData.New(PoolId, RewardId, RewardNum, CurrentRewardTime, RewardTime, RewardWeight, RewardQuality))
		end
	end

	if m.RewardPoolData ~= nil then
		for i = 1, #m.RewardPoolData do
			local PoolId = m.RewardPoolData[i].id

			for k, v in pairs(m.RewardPoolData[i].drawCount) do
				local RewardCount = v
				local CurrentRewardTime = m.GetItemsNumByToggle(PoolId).ItemTime[k + 1] - RewardCount

				for j = 1, #m.PrizeDrawPoolRewardList do
					if m.PrizeDrawPoolRewardList[j].PrizeDrawPoolId == PoolId and m.PrizeDrawPoolRewardList[j].Id == m.GetItemsNumByToggle(PoolId).ItemID[k + 1] then
						m.PrizeDrawPoolRewardList[j].CurrentItemTime = CurrentRewardTime
					end
				end
			end
		end
	end

	print(m.PrizeDrawPoolRewardList)
end

function m.GetPlotChallengeTable()
	return CfgPlotChallengeActivityGlobalTable[PlotChallengeModule.GlobalCid]
end

function m.GetItemsNumByToggle(toggle)
	local RewardPool = CfgPlotChallengeActivityRewardPoolTable[toggle]

	return RewardPool
end

function m.GetCurrentItemsNumByToggle(toggle)
	return m.RewardPoolData[toggle]
end

function m.GetCurrentPrizeDrawPoolId()
	for k, v in pairs(m.RewardPoolData) do
		m.TempRewardPool = m.GetItemsNum(m.RewardPoolData[k].id)

		if m.TempRewardPool ~= m.GetCurrentItemsNum(m.RewardPoolData[k].id) then
			return m.RewardPoolData[k].id
		end
	end
end

function m.GetItemsNum(id)
	m.RewardPoolDataNum = 0

	for i = 1, #CfgPlotChallengeActivityRewardPoolTable[id].ItemTime do
		m.RewardPoolDataNum = m.RewardPoolDataNum + CfgPlotChallengeActivityRewardPoolTable[id].ItemTime[i]
	end

	return m.RewardPoolDataNum
end

function m.GetCurrentItemsNum(id)
	m.CurrentRewardPoolDataNum = 0

	for i = 0, #m.RewardPoolData[id].drawCount do
		if m.RewardPoolData[id].drawCount[i] ~= nil then
			m.CurrentRewardPoolDataNum = m.CurrentRewardPoolDataNum + m.RewardPoolData[id].drawCount[i]
		end
	end

	return m.CurrentRewardPoolDataNum
end

function m.GetCurrentItemNum(id, index)
	if m.RewardPoolData[id].drawCount[index] == nil then
		return 0
	end

	return m.RewardPoolData[id].drawCount[index]
end

function m.GetItemNum(id, index)
	return CfgPlotChallengeActivityRewardPoolTable[id].ItemTime[index + 1]
end

function m.TriggerChallengeStory(nodeId)
	if m.DailyDupPOD.common.status ~= 1 then
		NoticeModule.ShowNotice(21057003)

		return
	end

	net_taleChallenge.triggerChallengeStory(nodeId)
end

function m.TriggerChallengeFight(nodeId, formationId)
	if m.DailyDupPOD.common.status ~= 1 then
		NoticeModule.ShowNotice(21057003)

		return
	end

	net_taleChallenge.triggerChallengeFight(nodeId, formationId)
end

function m.TriggerChallengeBoss(formationId)
	if m.DailyDupPOD.common.status ~= 1 then
		NoticeModule.ShowNotice(21057003)

		return
	end

	net_taleChallenge.triggerChallengeBoss(formationId)
end

function m.Draw(id, count)
	net_taleChallenge.draw(id, count)
end

function m.TriggerChallengeStoryResult()
	return
end

function m.TriggerChallengeFightResult()
	UIModule.Close(Constant.UIControllerName.ChallengeDramaBossFormationUI)
end

function m.TriggerChallengeBossResult()
	return
end

function m.NotifyTaleChallengeStoryFinished(nodeId, list)
	if #list > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, list)
	end
end

function m.NotifyChallengeFightRet(nodeId, win, showList)
	MainCityBattleModule.Instance:QuitBattle()

	local rewardData = ChallengeRewardData.New(1, win, showList, nil, nil)

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)
end

function m.NotifyChallengeBossRet(win, showList)
	MainCityBattleModule.Instance:QuitBattle()

	local rewardData = ChallengeRewardData.New(1, win, showList, nil, nil)

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)
end

function m.DrawResult(code, id, count, rewardList, drawInfo)
	EventDispatcher.Dispatch(EventID.APUpdateCurrentPrizeDrawPool)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewardList)

	if m.CurrentRewardPoolDataNum == 0 and m.GetCurrentPrizeDrawPoolId() <= 4 then
		EventDispatcher.Dispatch(EventID.NextPrizeDrawPool)
	end
end

PlotChallengeModule = m
