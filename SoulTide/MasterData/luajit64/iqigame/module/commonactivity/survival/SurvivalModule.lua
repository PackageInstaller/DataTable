-- chunkname: @IQIGame\\Module\\CommonActivity\\Survival\\SurvivalModule.lua

local m = {
	GlobalCid = 0,
	isFight = false,
	survivalPlayer = {},
	survivalChallengeLevels = {}
}

require("IQIGame.Module.CommonActivity.Survival.FlyGame.FlyGameConstant")

local SurvivalPlayerData = require("IQIGame.Module.CommonActivity.Survival.SurvivalPlayerData")
local SurvivalChallengeLevelData = require("IQIGame.Module.CommonActivity.Survival.SurvivalChallengeLevelData")

function m.Reload(dailyDupPOD)
	m.dailyDupPOD = dailyDupPOD

	if m.dailyDupPOD then
		m.GlobalCid = m.dailyDupPOD.common.openCount

		if m.dailyDupPOD.survivalPOD then
			m.InitData()
			FlyGameModule.Reload()
		end
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
	local cfgDailyDupData = CfgDailyDupTable[26]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and m.dailyDupPOD ~= nil and m.dailyDupPOD.common.status ~= 0
end

function m.IsEnter()
	local cfgDailyDupData = CfgDailyDupTable[26]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and m.dailyDupPOD ~= nil and m.dailyDupPOD.common.status == 1
end

function m.GetExploreUIAsset()
	local cfgSurvivalChallengeControlData = CfgSurvivalChallengeControlTable[m.GlobalCid]

	return cfgSurvivalChallengeControlData.ExploreHallUIBG
end

function m.GetFlightGameCost()
	local cfgSurvivalChallengeControlData = CfgSurvivalChallengeControlTable[m.GlobalCid]

	return cfgSurvivalChallengeControlData.Cost
end

function m.Update(dailyDupPOD)
	m.dailyDupPOD = dailyDupPOD

	if m.IsShow() and m.GlobalCid ~= m.dailyDupPOD.common.openCount then
		m.GlobalCid = m.dailyDupPOD.common.openCount

		m.InitData()
		FlyGameModule.Reload()
	end

	if m.dailyDupPOD.common.status ~= 1 then
		m.EndOfActivity()
	end
end

function m.InitData()
	m.CurrDialog = m.dailyDupPOD.survivalPOD.dialogId
	m.survivalPlayer = {}

	for i, v in pairsCfg(CfgSurvivalChallengePlayerTable) do
		if v.Group == m.GlobalCid then
			local playerGameData = SurvivalPlayerData.New(v.Id, m.dailyDupPOD.survivalPOD.level)

			m.survivalPlayer[v.Id] = playerGameData
		end
	end

	m.survivalChallengeLevels = {}

	for i, v in pairsCfg(CfgSurvivalChallengeLevelTable) do
		local podData

		if v.Group == m.GlobalCid then
			for k, pod in pairs(m.dailyDupPOD.survivalPOD.pass) do
				if pod.id == v.Id then
					podData = pod

					break
				end
			end

			local survivalLevelData = SurvivalChallengeLevelData.New(v.Id, podData)

			table.insert(m.survivalChallengeLevels, survivalLevelData)
		end
	end
end

function m.GetSurvivalChallengeLevelDataByID(cid)
	for i, v in pairs(m.survivalChallengeLevels) do
		if v.cid == cid then
			return v
		end
	end

	return nil
end

function m.CheckRedPoint()
	local top = false

	if m.IsShow() then
		for i, v in pairs(m.survivalPlayer) do
			top = v:CanBeUpgraded()

			if top then
				return top
			end
		end
	end

	return top
end

function m.EndOfActivity()
	if not FlyGameModule.isGameOver then
		FlyGameModule.ExitFlightGame()
	end
end

function m.CheckFlyChallengeCost(cost)
	for i = 1, #cost, 2 do
		local needId = cost[i]
		local needNum = cost[i + 1]
		local haveNum = WarehouseModule.GetItemNumByCfgID(needId)

		if haveNum < needNum then
			NoticeModule.ShowNotice(21045026)

			return false
		end
	end

	return true
end

function m.CheckResumeDialog()
	if m.CurrDialog ~= nil and m.CurrDialog ~= 0 then
		DialogModule.OpenDialog(m.CurrDialog, false, true)

		m.CurrDialog = nil
	end
end

function m.Shutdown()
	m.GlobalCid = 0
	m.isFight = false

	m.RemoveListeners()

	m.dailyDupPOD = nil
	m.survivalPlayer = {}
	m.survivalChallengeLevels = {}
	m.CurrDialog = nil

	FlyGameModule.Shutdown()
end

function m.StartChallenge(cid, levelCid)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21057003)

		return
	end

	local isCheck = m.CheckFlyChallengeCost(CfgSurvivalChallengeLevelTable[levelCid].Cost)

	if not isCheck then
		NoticeModule.ShowNotice(21040130)

		return
	end

	FlyGameModule.startPlayerCid = cid

	net_survival.startChallenge(levelCid)
end

function m.EndChallenge(playerCid, levelCid, killMonsterNum, killBossNum)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21057003)

		return
	end

	net_survival.endChallenge(playerCid, levelCid, killMonsterNum, killBossNum)
end

function m.Level()
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21057003)

		return
	end

	net_survival.level()
end

function m.StartChallengeUnlimited(cid)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21057003)

		return
	end

	local isCheck = m.CheckFlyChallengeCost(m.GetFlightGameCost())

	if not isCheck then
		NoticeModule.ShowNotice(21040130)

		return
	end

	FlyGameModule.startPlayerCid = cid

	net_survival.startChallengeUnlimited()
end

function m.EndChallengeUnlimited(playerCid, killBossNum)
	net_survival.endChallengeUnlimited(playerCid, killBossNum)
end

function m.StartChallengeResult(cid)
	if CfgSurvivalChallengeLevelTable[cid].Type == 1 then
		FlyGameModule.StartFlightGame(FlyGameConstant.ChallengeType.Challenge_Level_Mode, cid)
	end
end

function m.EndChallengeResult(getItems, monsterNum, bossNum, playerCid, levelCid)
	UIModule.Open(Constant.UIControllerName.SurvivalFlyGameSettlementUI, Constant.UILayer.UI, {
		OpenType = FlyGameConstant.ChallengeType.Challenge_Level_Mode,
		Reward = getItems,
		PlayerCid = playerCid,
		MonsterNum = monsterNum,
		BossNum = bossNum,
		LevelCid = levelCid
	})

	if #getItems then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, getItems)
	end
end

function m.LevelResult(lv)
	m.dailyDupPOD.survivalPOD.level = lv

	for i, v in pairs(m.survivalPlayer) do
		v.grade = lv
	end

	NoticeModule.ShowNotice(21045120)
	EventDispatcher.Dispatch(EventID.SurvivalUpgradeEvent)
end

function m.StartChallengeUnlimitedResult()
	FlyGameModule.StartFlightGame(FlyGameConstant.ChallengeType.Challenge_Endless_Mode)
end

function m.EndChallengeUnlimitedResult(playerCid, bossNum, items)
	UIModule.Open(Constant.UIControllerName.SurvivalFlyGameSettlementUI, Constant.UILayer.UI, {
		MonsterNum = 0,
		LevelCid = 0,
		OpenType = FlyGameConstant.ChallengeType.Challenge_Endless_Mode,
		Reward = items,
		PlayerCid = playerCid,
		BossNum = bossNum
	})

	if #items then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
	end
end

function m.SelectDialogResult(nextDialogCid)
	EventDispatcher.Dispatch(EventID.JumpToNextDialog, nextDialogCid)

	if nextDialogCid == 0 then
		-- block empty
	end
end

function m.NotifyOpenDialog(dialogCid)
	DialogModule.OpenDialog(dialogCid, false, true)
end

function m.NotifyUpdateSurvivalPassStatus(survivalPassStatusPOD)
	m.dailyDupPOD.survivalPOD.pass = m.dailyDupPOD.survivalPOD.pass or {}

	local isNew = true

	for i, v in pairs(m.dailyDupPOD.survivalPOD.pass) do
		if v.id == survivalPassStatusPOD.id then
			m.dailyDupPOD.survivalPOD.pass[i] = survivalPassStatusPOD
			isNew = false
		end
	end

	if isNew then
		table.insert(m.dailyDupPOD.survivalPOD.pass, survivalPassStatusPOD)
	end

	local levelData = m.GetSurvivalChallengeLevelDataByID(survivalPassStatusPOD.id)

	levelData:UpdateData(survivalPassStatusPOD)
	EventDispatcher.Dispatch(EventID.SurvivalUpDateLevelEvent)
end

function m.NotifyDialogRewards(getItems)
	if #getItems > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, getItems)
	end
end

SurvivalModule = m
