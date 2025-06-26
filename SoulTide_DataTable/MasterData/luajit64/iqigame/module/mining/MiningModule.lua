-- chunkname: @IQIGame\\Module\\Mining\\MiningModule.lua

local m = {
	isInMiningScene = false,
	isFight = false,
	miningPlantDataTab = {},
	miningPlantTypeDataDic = {}
}
local MiningPlantData = require("IQIGame.Module.Mining.MiningPlantData")
local MiningScene = require("IQIGame.Scene.Mining.MiningScene")
local MiningPlantTypeData = require("IQIGame.Module.Mining.MiningPlantTypeData")
local ChallengeRewardData = require("IQIGame.Module.Challenge.ChallengeRewardData")

function m.Reload(dailyDupPOD)
	m.dailyDupPOD = dailyDupPOD

	if m.dailyDupPOD then
		m.currDialog = m.dailyDupPOD.miningPOD.dialogId
	end

	m.AddListeners()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.IsOpen()
	local cfgDailyDupData = CfgDailyDupTable[19]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and m.dailyDupPOD ~= nil and m.dailyDupPOD.common.status ~= 0
end

function m.Update(dailyDupPOD)
	m.dailyDupPOD = dailyDupPOD

	if m.dailyDupPOD.common.status ~= 1 then
		m.ExitMiningScene()
	end
end

function m.CheckResumeDialog()
	local haveDialog = false

	if m.currDialog ~= nil and m.currDialog ~= 0 then
		DialogModule.OpenDialog(m.currDialog, false, true)

		haveDialog = true
		m.currDialog = nil
	end

	return haveDialog
end

function m.RefreshTypeData()
	m.miningPlantTypeDataDic = {}

	for i, v in pairs(m.miningLayerPOD.grids) do
		local num = 0
		local cfg = CfgMiningElementTable[v.dataCid]

		if m.miningPlantTypeDataDic[cfg.Type] == nil then
			m.miningPlantTypeDataDic[cfg.Type] = MiningPlantTypeData.New(cfg.Type, num)
		end

		if v.state ~= Constant.MiningPlantState.Mining_Plant_Complete and cfg.ServerType ~= nil and cfg.ServerType > 0 then
			m.miningPlantTypeDataDic[cfg.Type].num = m.miningPlantTypeDataDic[cfg.Type].num + 1
		end
	end
end

function m.GetMiningPlantDataById(gridId)
	for i, v in pairs(m.miningPlantDataTab) do
		if v.miningGridPOD.id == gridId then
			return v
		end
	end

	return nil
end

function m.RefreshMiningPlantDataTab()
	m.miningPlantDataTab = {}

	if m.miningLayerPOD then
		for i, v in pairs(m.miningLayerPOD.grids) do
			local plantData = MiningPlantData.New(m.miningLayerPOD.floor, v)

			table.insert(m.miningPlantDataTab, plantData)
		end
	end
end

function m.EnterMiningScene()
	CommonActivitySceneModule.EnterScene(CommonActivityVirtualSceneID.Mining, m.OnSceneLoaded)
end

function m.OnSceneLoaded()
	m.miningScene = MiningScene.New()

	UIModule.Open(Constant.UIControllerName.MiningMainUI, Constant.UILayer.UI)

	m.isInMiningScene = true
end

function m.ExitMiningScene()
	if m.isInMiningScene then
		UIModule.Close(Constant.UIControllerName.MiningMainUI)
		CommonActivitySceneModule.SwitchScene(m.DisposeMiningScene)
	end
end

function m.DisposeMiningScene()
	if m.miningScene then
		m.miningScene:Dispose()
	end

	m.miningScene = nil
	m.isInMiningScene = false
end

function m.Shutdown()
	m.dailyDupPOD = nil
	m.miningLayerPOD = nil
	m.currDialog = nil
	m.isFight = false
	m.miningPlantTypeDataDic = {}
	m.miningPlantDataTab = {}

	m.RemoveListeners()
	CommonActivitySceneModule.Shutdown()
	m.DisposeMiningScene()
end

function m.EnterMap()
	if m.IsOpen() then
		net_mining.enterMap()
	end
end

function m.Excavate(gridId)
	net_mining.excavate(gridId)
end

function m.AutoExcavate(num, type)
	net_mining.autoExcavate(num, type)
end

function m.Interact(gridId, formationId)
	if m.isFight then
		return
	end

	net_mining.interact(gridId, formationId)
	log("发起交互 gridId =" .. gridId .. " time:" .. PlayerModule:GetServerTime())

	if formationId ~= nil then
		m.isFight = true
	end
end

function m.EnterMapResult(layer)
	m.miningLayerPOD = layer

	m.RefreshMiningPlantDataTab()
	m.RefreshTypeData()
	m.EnterMiningScene()
end

function m.ExcavateResult(gridId)
	if m.miningLayerPOD and m.miningLayerPOD.grids[gridId] then
		local miningGridPOD = m.miningLayerPOD.grids[gridId]
		local cfg = CfgMiningElementTable[miningGridPOD.dataCid]

		if cfg.Type == Constant.MiningElementType.MiningElementType_Empty then
			m.miningLayerPOD.grids[gridId].state = Constant.MiningPlantState.Mining_Plant_Complete
		else
			m.miningLayerPOD.grids[gridId].state = Constant.MiningPlantState.Mining_Plant_Have_Reward
		end
	end

	EventDispatcher.Dispatch(EventID.UpdateMiningPlantEvent, gridId)
end

function m.AutoExcavateResult(gridIds)
	if m.miningLayerPOD then
		for i, v in pairs(gridIds) do
			if m.miningLayerPOD.grids[v] then
				local miningGridPOD = m.miningLayerPOD.grids[v]
				local cfg = CfgMiningElementTable[miningGridPOD.dataCid]

				if cfg.Type == Constant.MiningElementType.MiningElementType_Empty then
					m.miningLayerPOD.grids[v].state = Constant.MiningPlantState.Mining_Plant_Complete
				else
					m.miningLayerPOD.grids[v].state = Constant.MiningPlantState.Mining_Plant_Have_Reward
				end
			end
		end
	end

	EventDispatcher.Dispatch(EventID.UpdateAutoMiningPlantEvent)
end

function m.InteractResult(gridId)
	return
end

function m.SelectDialogResult(nextDialogId)
	EventDispatcher.Dispatch(EventID.JumpToNextDialog, nextDialogId)

	if nextDialogId == 0 then
		-- block empty
	end
end

function m.NotifyGridComplete(gridId)
	if m.miningLayerPOD and m.miningLayerPOD.grids[gridId] then
		m.miningLayerPOD.grids[gridId].state = Constant.MiningPlantState.Mining_Plant_Complete

		local miningGridPOD = m.miningLayerPOD.grids[gridId]
		local cfg = CfgMiningElementTable[miningGridPOD.dataCid]

		m.miningPlantTypeDataDic[cfg.Type].num = m.miningPlantTypeDataDic[cfg.Type].num - 1
	end

	EventDispatcher.Dispatch(EventID.UpdateMiningPlantEvent, gridId)
end

function m.NotifyEnterLayer(layer)
	m.dailyDupPOD.miningPOD.floorNow = layer.floor
	m.miningLayerPOD = layer

	m.RefreshMiningPlantDataTab()
	m.RefreshTypeData()

	m.miningScene.isLockInput = true

	EventDispatcher.Dispatch(EventID.UpdateMiningLayerEvent)
end

function m.NotifyOpenDialog(dialogCid)
	DialogModule.OpenDialog(dialogCid, false, true)
end

function m.NotifyFightComplete(win, dmgRecords, getItems)
	m.isFight = false

	MiningBattleModule.Instance:QuitBattle()

	local showItems = {}

	for i, v in pairs(getItems) do
		table.insert(showItems, v)
	end

	local rewardData = ChallengeRewardData.New(1, win, showItems, nil, nil)

	rewardData.battleType = 3

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)

	if win then
		UIModule.Close(Constant.UIControllerName.MiningChallengeDetailUI)
	end
end

function m.NotifyGetRewards(getItems)
	if #getItems > 0 then
		local str = ""

		for i, v in pairs(getItems) do
			str = str .. CfgItemTable[v.cid].Name .. " *" .. v.num .. " "
		end

		NoticeModule.ShowNoticeByType(1, MiningMainUIApi:GetString("RewardNotice", str))
	end
end

MiningModule = m
