-- chunkname: @IQIGame\\Module\\CommonActivity\\PlaceGame\\PlaceGameModule.lua

local m = {
	isAutoFight = false,
	maxFloor = 1,
	isFight = false,
	GlobalCid = 0,
	placeGameSoulDataList = {},
	placeGameSoulPrefabList = {},
	placeGameTowerDataList = {},
	boxExchangeDataList = {},
	placeGameEventList = {},
	placeGameRankList = {},
	cfgPlaceGameWorldDataList = {}
}
local PlaceGameSoulData = require("IQIGame.Module.CommonActivity.PlaceGame.PlaceGameSoulData")
local PlaceGameSoulPrefabData = require("IQIGame.Module.CommonActivity.PlaceGame.PlaceGameSoulPrefabData")
local ChallengeRewardData = require("IQIGame.Module.Challenge.ChallengeRewardData")
local PlaceGameExchangeData = require("IQIGame.Module.CommonActivity.PlaceGame.PlaceGameExchangeData")
local PlaceGameEventData = require("IQIGame.Module.CommonActivity.PlaceGame.PlaceGameEventData")

function m.Reload(dailyDupPOD)
	m.DailyDupPOD = dailyDupPOD

	if m.DailyDupPOD then
		m.GlobalCid = m.DailyDupPOD.common.openCount
		m.currDialog = m.DailyDupPOD.placeGamePOD.dialogId

		m.InitData()
	end

	m.AddListeners()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.InitData()
	m.placeGameSoulDataList = {}

	for i, v in pairs(m.DailyDupPOD.placeGamePOD.placeGameSoulPODs) do
		local placeGameSoulData = PlaceGameSoulData.New(v.cid, v)

		table.insert(m.placeGameSoulDataList, placeGameSoulData)
	end

	table.sort(m.placeGameSoulDataList, function(data1, data2)
		if data1.placeGameSoulPOD.level == data2.placeGameSoulPOD.level then
			return data1.cid < data2.cid
		end

		return data1.placeGameSoulPOD.level > data2.placeGameSoulPOD.level
	end)

	m.placeGameSoulPrefabList = {}

	for i, v in pairs(m.DailyDupPOD.placeGamePOD.placeGameSoulPrefabPODs) do
		local placeGameSoulPrefabData = PlaceGameSoulPrefabData.New(v)

		table.insert(m.placeGameSoulPrefabList, placeGameSoulPrefabData)
	end

	m.placeGameTowerDataList = {}
	m.maxFloor = 1

	for i, v in pairsCfg(CfgPlaceGameTowerTable) do
		if v.Group == m.GlobalCid then
			table.insert(m.placeGameTowerDataList, v)

			if m.maxFloor < v.Floor then
				m.maxFloor = v.Floor
			end
		end
	end

	table.sort(m.placeGameTowerDataList, function(a, b)
		return a.Floor < b.Floor
	end)

	m.boxExchangeDataList = {}

	for i, v in pairsCfg(CfgPlaceGameBoxExchangeTable) do
		if v.Group == m.GlobalCid then
			local data = PlaceGameExchangeData.New(v.Id)

			table.insert(m.boxExchangeDataList, data)
		end
	end

	table.sort(m.boxExchangeDataList, function(a, b)
		return a:GetCfgData().NeedTower < b:GetCfgData().NeedTower
	end)

	m.placeGameEventList = {}

	for i, v in pairsCfg(CfgPlaceGameEventTable) do
		if v.Group == m.GlobalCid then
			local data = PlaceGameEventData.New(v.Id)

			table.insert(m.placeGameEventList, data)
		end
	end

	table.sort(m.placeGameEventList, function(a, b)
		return a:GetCfgData().UnlockTower < b:GetCfgData().UnlockTower
	end)

	m.placeGameRankList = {}

	for i, v in pairsCfg(CfgPlaceGameTowerRankTable) do
		if v.Group == m.GlobalCid then
			table.insert(m.placeGameRankList, v)
		end
	end

	table.sort(m.placeGameRankList, function(tb1, tb2)
		return tb1.Id < tb2.Id
	end)

	m.cfgPlaceGameWorldDataList = {}

	for i, v in pairsCfg(CfgPlaceGameWordTable) do
		if v.Group == m.GlobalCid then
			table.insert(m.cfgPlaceGameWorldDataList, v)
		end
	end

	if not m.IsEnter() then
		m.isAutoFight = false
	end
end

function m.CheckResumeDialog()
	if m.currDialog ~= nil and m.currDialog ~= 0 then
		DialogModule.OpenDialog(m.currDialog, false, true)

		m.currDialog = nil
	end
end

function m.CheckPlaceGameEventRed()
	for i, v in pairs(m.placeGameEventList) do
		local unlock = v:IsUnlock()
		local completePre = v:IsCompletePrePlot()
		local complete = v:IsComplete()

		if unlock and completePre and not complete then
			return true
		end
	end

	return false
end

function m.PlaceGameIsGerReward()
	local isGerReward = false

	if m.IsShow() then
		local cfgControlData = CfgPlaceGameControlTable[m.GlobalCid]

		isGerReward = m.DailyDupPOD.placeGamePOD.award >= cfgControlData.MainUiGetButton
	end

	return isGerReward
end

function m.RefreshPlaceGameSoul(placeGameSoulPOD)
	local isNew = true

	for i, v in pairs(m.DailyDupPOD.placeGamePOD.placeGameSoulPODs) do
		if v.cid == placeGameSoulPOD.cid then
			v = placeGameSoulPOD
			isNew = false

			local placeGameSoul = m.GetPlaceGameSoulDataByCid(placeGameSoulPOD.cid)

			placeGameSoul:UpdatePOD(placeGameSoulPOD)
		end
	end

	if isNew then
		table.insert(m.DailyDupPOD.placeGamePOD.placeGameSoulPODs, placeGameSoulPOD)

		local placeGameSoulData = PlaceGameSoulData.New(placeGameSoulPOD.cid, placeGameSoulPOD)

		table.insert(m.placeGameSoulDataList, placeGameSoulData)
	end

	EventDispatcher.Dispatch(EventID.PlaceGameSoulDataChange, placeGameSoulPOD.cid)
end

function m.RefreshPlaceGameSoulPrefab(placeGameSoulPrefabPOD)
	for i, v in pairs(m.DailyDupPOD.placeGamePOD.placeGameSoulPrefabPODs) do
		if v.id == placeGameSoulPrefabPOD.id then
			v = placeGameSoulPrefabPOD
		end
	end

	local placeGameSoulPrefabData = m.GetPlaceGameSoulPrefabDataByID(placeGameSoulPrefabPOD.id)

	placeGameSoulPrefabData:UpdatePOD(placeGameSoulPrefabPOD)
	EventDispatcher.Dispatch(EventID.PlaceGameSoulPrefabUpdate, placeGameSoulPrefabPOD.id)
end

function m.IsShow()
	local cfgDailyDupData = CfgDailyDupTable[24]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and m.DailyDupPOD ~= nil and m.DailyDupPOD.common.status ~= 0
end

function m.IsEnter()
	local cfgDailyDupData = CfgDailyDupTable[24]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and m.DailyDupPOD ~= nil and m.DailyDupPOD.common.status == 1
end

function m.GetExploreUIAsset()
	local cfgPlaceGameControlData = CfgPlaceGameControlTable[m.GlobalCid]

	return cfgPlaceGameControlData.ExploreHallUIBG
end

function m.Update(dailyDupPOD)
	m.DailyDupPOD = dailyDupPOD
	m.GlobalCid = m.DailyDupPOD.common.openCount
	m.currDialog = m.DailyDupPOD.placeGamePOD.dialogId

	if m.IsShow() then
		m.InitData()
	end
end

function m.GetPlaceGameSoulIndexInFormation(placeGameSoulData, formationIndex)
	local formationPOD = m.GetPlaceGameFormationByIndex(formationIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = m.GetPlaceGameSoulPrefabDataByID(prefabId)

		if soulPrefabData.placeGameSoulPrefabPOD.soulCid ~= nil and soulPrefabData.placeGameSoulPrefabPOD.soulCid == placeGameSoulData.placeGameSoulPOD.soulCid then
			return prefabIndex
		end
	end

	return -1
end

function m.GetPlaceGameSoulPrefabDataByID(id)
	for i, v in pairs(m.placeGameSoulPrefabList) do
		if v.id == id then
			return v
		end
	end

	return nil
end

function m.GetPlaceGameFormationByIndex(index)
	for i, v in pairs(m.DailyDupPOD.placeGamePOD.placeGameFormationPODs) do
		if v.index == index then
			return v
		end
	end

	return nil
end

function m.GetPlaceGameSoulDataByCid(cid)
	for i, v in pairs(m.placeGameSoulDataList) do
		if v.cid == cid then
			return v
		end
	end

	return nil
end

function m.GetPlayerRecruitMaxNum()
	local num = 0
	local cfgControlData = CfgPlaceGameControlTable[m.GlobalCid]
	local currentTower = 0

	if m.DailyDupPOD.placeGamePOD.customs > 0 then
		currentTower = CfgPlaceGameTowerTable[m.DailyDupPOD.placeGamePOD.customs].Floor
	end

	for i = 1, #cfgControlData.NeedTower do
		local needTower = cfgControlData.NeedTower[i]

		if currentTower < needTower then
			return num
		end

		num = cfgControlData.SoulMax[i]
	end

	return num
end

function m.GetPlaceGameEquips(type)
	local items = {}
	local equips = WarehouseModule.GetItemsByType(Constant.ItemType.PlaceGameEquip, false)

	for i, v in pairs(equips) do
		if v.placeGameEquipData and v.SubType == type then
			table.insert(items, v)
		end
	end

	return items
end

function m.PlaceGameEquipSort(items)
	local sortItems = items or {}

	table.sort(sortItems, function(a, b)
		local topA, placeGameSoulCidA = a.placeGameEquipData:IsWearingState()
		local topB, placeGameSoulCidB = b.placeGameEquipData:IsWearingState()
		local numA = topA and 1 or 0
		local numB = topB and 1 or 0

		if numA == numB then
			return a:GetCfg().Sort < b:GetCfg().Sort
		end

		return numB < numA
	end)

	return sortItems
end

function m.GetCurrentTowerData()
	local maxFinish = m.DailyDupPOD.placeGamePOD.customs
	local nextFloor = 1

	if maxFinish > 0 then
		nextFloor = CfgPlaceGameTowerTable[maxFinish].Floor + 1
	end

	if nextFloor > m.maxFloor then
		nextFloor = m.maxFloor
	end

	for i, v in pairs(m.placeGameTowerDataList) do
		if v.Floor == nextFloor then
			return v
		end
	end

	return nil
end

function m.GetPlaceGameLastChooseFormationId()
	local lastChooseFormationIndex = 1
	local playerPrefTabIndex = PlayerPrefsUtil.GetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.PlaceGameFormationTeamIndex, 0)

	if m.DailyDupPOD and playerPrefTabIndex > 0 and playerPrefTabIndex <= #m.DailyDupPOD.placeGamePOD.placeGameFormationPODs then
		lastChooseFormationIndex = playerPrefTabIndex
	end

	return lastChooseFormationIndex
end

function m.GetRankTowerData(ranking, rankingType)
	for i, v in pairs(m.placeGameRankList) do
		if rankingType == v.RankType and ranking >= v.RankLowerLimit and ranking <= v.RankUpperLimit then
			return v
		end
	end

	return nil
end

function m.GetPlayerRecruitLv(cid)
	if m.DailyDupPOD and m.DailyDupPOD.placeGamePOD.firingSoulPODs then
		for i, v in pairs(m.DailyDupPOD.placeGamePOD.firingSoulPODs) do
			if v.cid == cid then
				return v.level
			end
		end
	end

	return 1
end

function m.Shutdown()
	m.RemoveListeners()

	m.currDialog = nil
	m.DailyDupPOD = nil
	m.GlobalCid = 0
	m.isFight = false
	m.isAutoFight = false
	m.placeGameSoulDataList = {}
	m.placeGameSoulPrefabList = {}
	m.placeGameTowerDataList = {}
	m.boxExchangeDataList = {}
	m.placeGameEventList = {}
	m.placeGameRankList = {}
end

function m.Recruit(cid)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	local maxNum = m.GetPlayerRecruitMaxNum()

	if maxNum <= #m.placeGameSoulDataList then
		NoticeModule.ShowNotice(21045100)

		return
	end

	net_placeGame.recruit(cid)
end

function m.LevelUp(id, type)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_placeGame.levelUp(id, type)
end

function m.Dismissal(cid)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_placeGame.dismissal(cid)
end

function m.ChangeFormationName(id, text)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_placeGame.changeFormationName(id, text)
end

function m.GoIntoBattle(id, beforeIndex, afterIndex)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_placeGame.goIntoBattle(id, beforeIndex, afterIndex)
end

function m.ModifySoul(prefabId, soulId)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_placeGame.modifySoul(prefabId, soulId)
end

function m.ChangePosition(prefabId, position)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_placeGame.changePosition(prefabId, position)

	local soulPrefabData = m.GetPlaceGameSoulPrefabDataByID(prefabId)

	soulPrefabData.placeGameSoulPrefabPOD.position = position
end

function m.ModifyWeapon(prefabId, eId, state)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_placeGame.modifyWeapon(prefabId, eId, state)
end

function m.ClimbingTower(formationId, isAutoFight)
	if m.isFight then
		return
	end

	local floor = 0

	if m.DailyDupPOD.placeGamePOD.customs > 0 then
		floor = CfgPlaceGameTowerTable[m.DailyDupPOD.placeGamePOD.customs].Floor
	end

	if floor >= m.maxFloor then
		NoticeModule.ShowNotice(21045112)

		return
	end

	m.isAutoFight = isAutoFight

	net_placeGame.climbingTower(formationId)

	m.isFight = true
end

function m.OpenTheBox()
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	if m.DailyDupPOD.placeGamePOD.award <= 0 then
		if m.DailyDupPOD.placeGamePOD.award == 0 then
			NoticeModule.ShowNotice(21045109)
		end

		return
	end

	net_placeGame.openTheBox()
end

function m.BuyATreasureChest(number, index)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_placeGame.buyATreasureChest(number, index)
end

function m.AllSoulUnload(id)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_placeGame.allSoulUnload(id)
end

function m.AllEquipUnload(id)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_placeGame.allEquipUnload(id)
end

function m.SoulEquipUnload(id)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_placeGame.soulEquipUnload(id)
end

function m.OpenDialog(eventId, isReview)
	if isReview then
		DialogModule.OpenDialog(CfgPlaceGameEventTable[eventId].Parameter, false, false)

		return
	end

	if not m.IsEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_placeGame.openDialog(eventId)
end

function m.EquipmentLock(eId, state)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_placeGame.equipmentLock(eId, state)
end

function m.EquipmentResolve(eIds)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21045095)

		return
	end

	net_placeGame.equipmentResolve(eIds)
end

function m.RecruitResult(placeGameSoulPOD, firingSoulPODs)
	NoticeModule.ShowNotice(21045101)

	m.DailyDupPOD.placeGamePOD.firingSoulPODs = firingSoulPODs

	m.RefreshPlaceGameSoul(placeGameSoulPOD)
end

function m.LevelUpResult(placeGameSoulPOD)
	m.RefreshPlaceGameSoul(placeGameSoulPOD)
end

function m.DismissalResult(id, firingSoulPODs)
	m.DailyDupPOD.placeGamePOD.firingSoulPODs = firingSoulPODs

	local index = -1

	for i = 1, #m.DailyDupPOD.placeGamePOD.placeGameSoulPODs do
		local pod = m.DailyDupPOD.placeGamePOD.placeGameSoulPODs[i]

		if pod.cid == id then
			index = i

			break
		end
	end

	if index ~= -1 then
		table.remove(m.DailyDupPOD.placeGamePOD.placeGameSoulPODs, index)
	end

	index = -1

	for i = 1, #m.placeGameSoulDataList do
		local placeGameSoul = m.placeGameSoulDataList[i]

		if placeGameSoul.cid == id then
			index = i

			break
		end
	end

	if index ~= -1 then
		table.remove(m.placeGameSoulDataList, index)
	end

	EventDispatcher.Dispatch(EventID.PlaceGameSoulDataChange, id)
end

function m.ChangeFormationNameResult(id, name)
	for i, v in pairs(m.DailyDupPOD.placeGamePOD.placeGameFormationPODs) do
		if v.id == id then
			v.name = name
		end
	end

	if string.match(name, "*") then
		NoticeModule.ShowNotice(21046001)
	end

	EventDispatcher.Dispatch(EventID.PlaceGameFormationUpdate)
end

function m.GoIntoBattleResult(placeGameFormationPOD)
	for i, v in pairs(m.DailyDupPOD.placeGamePOD.placeGameFormationPODs) do
		if v.id == placeGameFormationPOD.id then
			m.DailyDupPOD.placeGamePOD.placeGameFormationPODs[i] = placeGameFormationPOD
		end
	end

	EventDispatcher.Dispatch(EventID.PlaceGameFormationUpdate)
	EventDispatcher.Dispatch(EventID.PlaceGameFormationChooseSoulComplete)
end

function m.ModifySoulResult(placeGameSoulPrefabPOD)
	for i, v in pairs(m.DailyDupPOD.placeGamePOD.placeGameSoulPrefabPODs) do
		if v.id == placeGameSoulPrefabPOD.id then
			v = placeGameSoulPrefabPOD
		end
	end

	local soulPrefabData = m.GetPlaceGameSoulPrefabDataByID(placeGameSoulPrefabPOD.id)

	soulPrefabData:UpdatePOD(placeGameSoulPrefabPOD)
	EventDispatcher.Dispatch(EventID.PlaceGameFormationChooseSoulComplete)
	EventDispatcher.Dispatch(EventID.PlaceGameSoulPrefabUpdate, placeGameSoulPrefabPOD.id)
end

function m.ChangePositionResult(position)
	return
end

function m.ModifyWeaponResult(placeSoulPrefabPODs)
	for i, v in pairs(placeSoulPrefabPODs) do
		m.RefreshPlaceGameSoulPrefab(v)
	end
end

function m.ClimbingTowerResult()
	return
end

function m.OpenTheBoxResult(items)
	if #items > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
	end

	m.NotifyBoxAdd(0)
end

function m.BuyATreasureChestResult(items)
	if #items > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
	end

	EventDispatcher.Dispatch(EventID.PlaceGameUpdateExchange)
end

function m.AllSoulUnloadResult(placeSoulPrefabPODs)
	for i, v in pairs(placeSoulPrefabPODs) do
		m.RefreshPlaceGameSoulPrefab(v)
	end
end

function m.AllEquipUnloadResult(placeSoulPrefabPODs)
	for i, v in pairs(placeSoulPrefabPODs) do
		m.RefreshPlaceGameSoulPrefab(v)
	end
end

function m.SoulEquipUnloadResult(placeSoulPrefabPOD)
	m.RefreshPlaceGameSoulPrefab(placeSoulPrefabPOD)
end

function m.OpenDialogResult(dialogCid)
	DialogModule.OpenDialog(dialogCid, false, true)
end

function m.SelectDialogResult(nextDialogId, items)
	EventDispatcher.Dispatch(EventID.JumpToNextDialog, nextDialogId)

	if nextDialogId == 0 and #items > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
	end
end

function m.EquipmentLockResult()
	return
end

function m.EquipmentResolveResult(items)
	if #items > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
	end
end

function m.NotifyBoss(win, cid, dmgRecords, items)
	m.isFight = false

	MainCityBattleModule.Instance:QuitBattle()

	local rewardData = ChallengeRewardData.New(1, win, items, nil, dmgRecords)

	rewardData.isAutoClose = true

	function rewardData.onBtnCloseCallBack()
		m.isAutoFight = false
	end

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)

	if win then
		m.DailyDupPOD.placeGamePOD.customs = cid

		EventDispatcher.Dispatch(EventID.PlaceGameUpdateEvent)
	else
		m.isAutoFight = false
	end

	EventDispatcher.Dispatch(EventID.PlaceGameUpdateTower)
end

function m.NotifyFormation(placeGameSoulPrefabPOD)
	m.RefreshPlaceGameSoulPrefab(placeGameSoulPrefabPOD)
end

function m.NotifyEventIsFinish(eventId)
	if table.indexOf(m.DailyDupPOD.placeGamePOD.plot, eventId) == -1 then
		table.insert(m.DailyDupPOD.placeGamePOD.plot, eventId)
	end

	EventDispatcher.Dispatch(EventID.PlaceGameUpdateEvent)
end

function m.NotifyBoxAdd(num)
	m.DailyDupPOD.placeGamePOD.award = num

	EventDispatcher.Dispatch(EventID.PlaceGameUpdateAward)
end

function m.NotifyChallengeLevel(cid)
	m.DailyDupPOD.placeGamePOD.customs = cid

	EventDispatcher.Dispatch(EventID.PlaceGameUpdateTower)
end

PlaceGameModule = m
