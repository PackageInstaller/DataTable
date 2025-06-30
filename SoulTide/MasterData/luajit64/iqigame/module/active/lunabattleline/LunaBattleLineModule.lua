-- chunkname: @IQIGame\\Module\\Active\\LunaBattleLine\\LunaBattleLineModule.lua

LunaBattleLineModule = {
	GlobalCid = 0,
	MaxSealNum = 100,
	AssistsCacheCD = 30,
	AssistsCache = {}
}

local TaskUIData = require("IQIGame.Module.Task.TaskUIData")

function LunaBattleLineModule.Reload(dailyDupPOD)
	LunaBattleLineModule.DailyDupPOD = dailyDupPOD

	if LunaBattleLineModule.DailyDupPOD ~= nil then
		LunaBattleLineModule.GlobalCid = LunaBattleLineModule.DailyDupPOD.common.openCount
	end

	LunaBattleLineModule.AssistsCache = {}
end

function LunaBattleLineModule.Update(dailyDupPOD)
	LunaBattleLineModule.DailyDupPOD = deepClonePOD(dailyDupPOD, LunaBattleLineModule.DailyDupPOD)
	LunaBattleLineModule.GlobalCid = LunaBattleLineModule.DailyDupPOD.common.openCount
end

function LunaBattleLineModule.IsShow()
	local cfgDailyDupData = CfgDailyDupTable[10]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and LunaBattleLineModule.DailyDupPOD ~= nil and LunaBattleLineModule.DailyDupPOD.common.status ~= 0
end

function LunaBattleLineModule.IsOutOfMazeLimitTime()
	if not LunaBattleLineModule.IsShow() then
		return true
	end

	local cfgDailyDupData = CfgDailyDupTable[LunaBattleLineModule.DailyDupPOD.common.cid]
	local endTime = LunaBattleLineModule.DailyDupPOD.common.openDate + cfgDailyDupData.AccessibleTime

	return endTime < PlayerModule.GetServerTime()
end

function LunaBattleLineModule.SendGarrison(zoneId, soulPrefabId, callback)
	LunaBattleLineModule.__GarrisonCallback = callback

	net_lunaBattleLine.garrison(zoneId, soulPrefabId)
end

function LunaBattleLineModule.OnGarrison(zoneId, soulPrefabId, garrison)
	local zonePOD = LunaBattleLineModule.DailyDupPOD.lunaBattleLineDataPOD.zones[zoneId]

	zonePOD.garrison = garrison

	EventDispatcher.Dispatch(EventID.LunaBattleLineGarrisonComplete, zoneId)

	if LunaBattleLineModule.__GarrisonCallback ~= nil then
		LunaBattleLineModule.__GarrisonCallback(zoneId)

		LunaBattleLineModule.__GarrisonCallback = nil
	end
end

function LunaBattleLineModule.SendGetAssists(zoneId, callback)
	local cache = LunaBattleLineModule.AssistsCache[zoneId]

	if cache ~= nil and #cache >= 10 then
		callback(cache)

		return
	end

	LunaBattleLineModule.__GetAssistsCallback = callback

	net_lunaBattleLine.getAssists(zoneId)
end

function LunaBattleLineModule.OnGetAssists(zoneId, assistUnits)
	LunaBattleLineModule.AssistsCache[zoneId] = assistUnits

	if LunaBattleLineModule.__GetAssistsCallback ~= nil then
		LunaBattleLineModule.__GetAssistsCallback(assistUnits)

		LunaBattleLineModule.__GetAssistsCallback = nil
	end
end

function LunaBattleLineModule.SendRefreshAssists(zoneId, callback)
	local isCD = LunaBattleLineModule.IsRefreshCD()

	if isCD then
		callback(nil)

		return
	end

	LunaBattleLineModule.__RefreshAssistsCallback = callback

	net_lunaBattleLine.refreshAssist(zoneId)
end

function LunaBattleLineModule.OnRefreshAssists(zoneId, assistUnits)
	LunaBattleLineModule.AssistsCache[zoneId] = assistUnits
	LunaBattleLineModule.LastRequestAssistsTime = UnityEngine.Time.realtimeSinceStartup

	if LunaBattleLineModule.__RefreshAssistsCallback ~= nil then
		LunaBattleLineModule.__RefreshAssistsCallback(assistUnits)

		LunaBattleLineModule.__RefreshAssistsCallback = nil
	end

	EventDispatcher.Dispatch(EventID.LunaBattleLineRefreshAssists, assistUnits)
end

function LunaBattleLineModule.IsRefreshCD()
	if LunaBattleLineModule.LastRequestAssistsTime ~= nil and UnityEngine.Time.realtimeSinceStartup - LunaBattleLineModule.LastRequestAssistsTime < LunaBattleLineModule.AssistsCacheCD then
		return true
	end

	return false
end

function LunaBattleLineModule.CreateEquipData(equipPOD, index, isWore)
	local itemData = ItemData.New()

	itemData.id = index
	itemData.cid = equipPOD.cid
	itemData.num = 1
	itemData.usedNum = 1

	local cfgItemData = CfgItemTable[itemData.cid]

	itemData.Type = cfgItemData.Type
	itemData.SubType = cfgItemData.SubType
	itemData.IsMazeItem = false
	itemData.equipData = {
		isWore = false,
		lv = 1,
		star = 1,
		exp = 0,
		lock = false,
		upCostGold = 0,
		soulPrefabIds = {}
	}
	itemData.equipData.star = equipPOD.star
	itemData.equipData.lv = equipPOD.lv
	itemData.equipData.isWore = isWore

	return itemData
end

function LunaBattleLineModule.SendGetStrengthenSoulPrefab(zoneId, callback)
	LunaBattleLineModule.__GetStrengthenSoulPrefabCallback = callback

	net_lunaBattleLine.getStrengthenSoulPrefab(zoneId)
end

function LunaBattleLineModule.OnGetStrengthenSoulPrefab(zoneId, soulPrefabs)
	if LunaBattleLineModule.__GetStrengthenSoulPrefabCallback ~= nil then
		LunaBattleLineModule.__GetStrengthenSoulPrefabCallback(soulPrefabs)

		LunaBattleLineModule.__GetStrengthenSoulPrefabCallback = nil
	end
end

function LunaBattleLineModule.GetRecoverMazeEntranceData(zoneId)
	local data = {
		uiName = Constant.UIControllerName.LunaBattleLineEntryUI,
		uiLayer = Constant.UILayer.UI,
		validateFunc = LunaBattleLineModule.IsShow
	}

	return {
		data
	}
end

function LunaBattleLineModule.IsAnyZoneCompleteSealing()
	if not LunaBattleLineModule.IsShow() then
		return false
	end

	local dailyDupPOD = LunaBattleLineModule.DailyDupPOD

	for zoneId, zonePOD in pairs(dailyDupPOD.lunaBattleLineDataPOD.zones) do
		local sealNum = dailyDupPOD.common.centerLunaBattleLineDataPOD.zoneSealPercentage[zoneId]
		local cfgLunaBattleLineZoneData = CfgLunaBattleLineZoneTable[zoneId]
		local isSealMazeFinished = table.indexOf(PlayerModule.PlayerInfo.finishMazes, cfgLunaBattleLineZoneData.SealedLevel) ~= -1

		if isSealMazeFinished and sealNum == LunaBattleLineModule.MaxSealNum then
			return true
		end
	end

	return false
end

function LunaBattleLineModule.GetTaskDataList(childType)
	local taskDataList = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.LUNA_BATTLE_LINE_TASK, {
		childType
	})
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.LUNA_BATTLE_LINE_TASK, {
		childType
	})

	for i = 1, #processing do
		local taskData = processing[i]
		local uiTaskData = TaskUIData.New(taskData.cid, taskData.finNum, taskData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, taskData.createTime)

		table.insert(taskDataList, uiTaskData)
	end

	for i = 1, #finished do
		local taskCid = finished[i]
		local cfgMainQuestData = CfgMainQuestTable[taskCid]

		if cfgMainQuestData.FinishIsShow == 1 then
			local cfgTargetData = CfgTargetTable[cfgMainQuestData.TargetId]
			local uiTaskData = TaskUIData.New(taskCid, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

			table.insert(taskDataList, uiTaskData)
		end
	end

	return taskDataList
end

function LunaBattleLineModule.GetMallCidList()
	local cfgLunaBattleLineGlobalData = CfgLunaBattleLineGlobalTable[LunaBattleLineModule.GlobalCid]

	return cfgLunaBattleLineGlobalData.MallGoods
end

function LunaBattleLineModule.Shutdown()
	LunaBattleLineModule.__GarrisonCallback = nil
	LunaBattleLineModule.__GetAssistsCallback = nil
	LunaBattleLineModule.__RefreshAssistsCallback = nil
	LunaBattleLineModule.__GetStrengthenSoulPrefabCallback = nil
	LunaBattleLineModule.LastRequestAssistsTime = nil
	LunaBattleLineModule.AssistsCache = nil
end
