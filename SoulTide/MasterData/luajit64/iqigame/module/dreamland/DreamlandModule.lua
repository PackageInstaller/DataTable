-- chunkname: @IQIGame\\Module\\Dreamland\\DreamlandModule.lua

require("IQIGame.Scene.Dreamland.InternalConst.DreamExecStateEnum")

local DreamlandScene = require("IQIGame.Scene.Dreamland.DreamlandScene")
local TaskUIData = require("IQIGame.Module.Task.TaskUIData")
local GameSceneUtil = require("IQIGame.Util.GameSceneUtil")

DreamlandModule = {
	IsInDreamlandScene = false,
	GlobalCid = 0,
	MapDataXYMap = {},
	__TempDropList = {},
	__ExecutionDialogReadyIds = {},
	__ServiceDialogReadyIds = {},
	__NewTaskCidList = {}
}

function DreamlandModule.Reload(dailyDupPOD)
	DreamlandModule.DailyDupPOD = dailyDupPOD

	if DreamlandModule.DailyDupPOD ~= nil then
		DreamlandModule.GlobalCid = DreamlandModule.DailyDupPOD.common.openCount
	end
end

function DreamlandModule.Update(dailyDupPOD)
	DreamlandModule.DailyDupPOD = deepClonePOD(dailyDupPOD, DreamlandModule.DailyDupPOD)
	DreamlandModule.GlobalCid = DreamlandModule.DailyDupPOD.common.openCount
end

function DreamlandModule.IsShow()
	local cfgDailyDupData = CfgDailyDupTable[11]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and DreamlandModule.DailyDupPOD ~= nil and DreamlandModule.DailyDupPOD.common.status ~= 0
end

function DreamlandModule.AddListeners()
	EventDispatcher.AddEventListener(EventID.LoadSceneSuccess, DreamlandModule.OnLoadSceneSuccess)
	EventDispatcher.AddEventListener(EventID.CloseDialogUI, DreamlandModule.OnCloseDialogUI)
	EventDispatcher.AddEventListener(EventID.DreamlandStopInteract, DreamlandModule.OnStopInteract)
	EventDispatcher.AddEventListener(EventID.DreamlandElementPrepared, DreamlandModule.OnElementPrepared)
	EventDispatcher.AddEventListener(EventID.DreamlandOpenCellAnimationFinished, DreamlandModule.OnOpenCellAnimationFinished)
end

function DreamlandModule.RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.LoadSceneSuccess, DreamlandModule.OnLoadSceneSuccess)
	EventDispatcher.RemoveEventListener(EventID.CloseDialogUI, DreamlandModule.OnCloseDialogUI)
	EventDispatcher.RemoveEventListener(EventID.DreamlandStopInteract, DreamlandModule.OnStopInteract)
	EventDispatcher.RemoveEventListener(EventID.DreamlandElementPrepared, DreamlandModule.OnElementPrepared)
	EventDispatcher.RemoveEventListener(EventID.DreamlandOpenCellAnimationFinished, DreamlandModule.OnOpenCellAnimationFinished)
end

function DreamlandModule.OnLoadSceneSuccess(sceneID)
	if sceneID == SceneID.Dreamland then
		DreamlandModule.DreamlandScene = DreamlandScene.New()

		DreamlandModule.SetSpeedByPlayerPrefs()
	end
end

function DreamlandModule.SendEnterMap(dreamMapListCid)
	local cfgDreamMapListData = CfgDreamMapListTable[dreamMapListCid]
	local openTime = cfgDateTimeToTimeStamp(cfgDreamMapListData.OpenDate, PlayerModule.TimeZone)
	local endTime = cfgDateTimeToTimeStamp(cfgDreamMapListData.CloseDate, PlayerModule.TimeZone)
	local nowTime = PlayerModule.GetServerTime()

	if nowTime < openTime or endTime < nowTime then
		NoticeModule.ShowNotice(84500004)

		return
	end

	net_dreamMap.enterMap(dreamMapListCid)
end

function DreamlandModule.OnEnterMap(mapData)
	DreamlandModule.IsInDreamlandScene = true

	DreamlandModule.UpdateMapData(mapData)

	DreamlandModule.__ExecutionQueue = Queue.New()

	DreamlandModule.AddListeners()
	SceneManager.ChangeScene(SceneID.Dreamland)
end

function DreamlandModule.ExitDreamland()
	DreamlandModule.ClearOnLeaveMap()
	JumpModule.Jump(10901001)
	DreamlandModule.RecoverNormalSpeedWithoutSave()
end

function DreamlandModule.SendOpenCell(x, y)
	net_dreamMap.openCell(x, y)
end

function DreamlandModule.OnOpenCell(executionPODs, combo, movePoint, showCellX, showCellY)
	DreamlandModule.MapData.combo = combo

	DreamlandModule.UpdateMovePoint(movePoint)

	DreamlandModule.__TempOpenCellParam = {
		executionPODs,
		showCellX,
		showCellY
	}

	DreamlandModule.DreamlandScene:OpenHeroCell()
end

function DreamlandModule.OnOpenDialog(dialogCid)
	table.insert(DreamlandModule.__ServiceDialogReadyIds, dialogCid)
	DreamlandModule.__CheckShowDialog()
end

function DreamlandModule.SendResetMap()
	net_dreamMap.resetMap()
end

function DreamlandModule.OnResetMap(mapData)
	DreamlandModule.UpdateMapData(mapData)
	DreamlandModule.__ExecutionQueue:Clear()

	DreamlandModule.__TempDropList = {}
	DreamlandModule.__ExecutionDialogReadyIds = {}
	DreamlandModule.__ServiceDialogReadyIds = {}

	DreamlandModule.DreamlandScene:ShowResetMap()
end

function DreamlandModule.MarkCell(x, y, markType)
	net_dreamMap.markCell(x, y, markType)
end

function DreamlandModule.OnMarkCell(x, y, markType)
	local cellPOD = DreamlandModule.GetCellPODByXY(x, y)

	cellPOD.markType = markType

	DreamlandModule.DreamlandScene:RefreshNode(x, y, cellPOD)
end

function DreamlandModule.UpdateMapData(mapData)
	DreamlandModule.MapData = mapData
	DreamlandModule.MapDataXYMap = {}

	for i = 1, #DreamlandModule.MapData.cells do
		local cellData = DreamlandModule.MapData.cells[i]

		DreamlandModule.MapDataXYMap[cellData.x] = DreamlandModule.MapDataXYMap[cellData.x] or {}
		DreamlandModule.MapDataXYMap[cellData.x][cellData.y] = cellData
	end

	EventDispatcher.Dispatch(EventID.DreamlandUpdateMovePoint)
end

function DreamlandModule.UpdateMovePoint(movePoint)
	DreamlandModule.MapData.movePoint = movePoint

	EventDispatcher.Dispatch(EventID.DreamlandUpdateMovePoint)
end

function DreamlandModule.UpdateSpeRewardCount(cid, deltaCount)
	local rewardMap = DreamlandModule.DailyDupPOD.dreamMapPOD.spRewardsCount
	local count = rewardMap[cid]

	count = (count or 0) + deltaCount
	rewardMap[cid] = count
end

function DreamlandModule.UpdateUnlockMaps(cid)
	table.insert(DreamlandModule.DailyDupPOD.dreamMapPOD.unlockMaps, cid)
end

function DreamlandModule.OnOpenCellAnimationFinished()
	DreamlandModule.PlayExecutionPerformance(unpack(DreamlandModule.__TempOpenCellParam))

	DreamlandModule.__TempOpenCellParam = nil

	EventDispatcher.Dispatch(EventID.DreamlandOpenCellConfirmed)
end

function DreamlandModule.PlayExecutionPerformance(executionPODs, showCellX, showCellY)
	local currentNode = DreamlandModule.DreamlandScene.Hero.Node
	local cellData = DreamlandModule.MapDataXYMap[currentNode.IndexX][currentNode.IndexY]

	cellData.isOpen = true

	DreamlandModule.DreamlandScene:RefreshNode(cellData.x, cellData.y, cellData)

	if showCellX ~= -1 and showCellY ~= -1 then
		cellData = DreamlandModule.MapDataXYMap[showCellX][showCellY]
		cellData.showType = true

		local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Dreamland, function()
			DreamlandModule.DreamlandScene:RefreshNode(cellData.x, cellData.y, cellData)

			local node = DreamlandModule.DreamlandScene:GetNodeByXY(cellData.x, cellData.y)

			node:PlayShowCellType()
		end, 1)

		timer:Start()
	end

	if #executionPODs > 0 then
		for i = 1, #executionPODs do
			local executionItemPOD = executionPODs[i]

			DreamlandModule.__PushDropCache(executionItemPOD)
			DreamlandModule.__ExecutionQueue:Enqueue(executionPODs[i])
		end

		DreamlandModule.__PlayNextExecution()
	else
		DreamlandModule.ShowExecAnimationComplete()
	end
end

function DreamlandModule.__PlayNextExecution()
	if DreamlandModule.__ExecutionQueue.Size == 0 then
		local isSuccess = DreamlandModule.DreamlandScene:RemoveElementOnHeroNode()

		if not isSuccess then
			DreamlandModule.ShowExecAnimationComplete()
		end

		return
	end

	local executionItemPOD = DreamlandModule.__ExecutionQueue:Dequeue()
	local cfgDreamMapServiceData = CfgDreamMapServiceTable[executionItemPOD.exectionId]

	if cfgDreamMapServiceData.ExecutionType == Constant.Dreamland.ExecutionTypeShowEntity then
		DreamlandModule.DreamlandScene:ShowNpc(tonumber(cfgDreamMapServiceData.ExecutionParams[1]))
	elseif cfgDreamMapServiceData.ExecutionType == Constant.Dreamland.ExecutionTypeGetItem or cfgDreamMapServiceData.ExecutionType == Constant.Dreamland.ExecutionTypeGetSpeItem then
		local type = tonumber(cfgDreamMapServiceData.ExecutionParams[1])

		if type == 1 then
			DreamlandModule.__ShowItemDrop()
		elseif type == 2 then
			DreamlandModule.DreamlandScene:StartGather()
		elseif type == 3 then
			DreamlandModule.DreamlandScene:StartFight()
		end
	elseif cfgDreamMapServiceData.ExecutionType == Constant.Dreamland.ExecutionTypeOpenDialog then
		local dialogCid = tonumber(cfgDreamMapServiceData.ExecutionParams[1])

		table.insert(DreamlandModule.__ExecutionDialogReadyIds, dialogCid)
		DreamlandModule.__CheckShowDialog()
	elseif cfgDreamMapServiceData.ExecutionType == Constant.Dreamland.ExecutionTypeUnlockTask then
		local taskCid = tonumber(cfgDreamMapServiceData.ExecutionParams[1])

		table.insert(DreamlandModule.__NewTaskCidList, taskCid)

		local cfgMainQuestData = CfgMainQuestTable[taskCid]

		NoticeModule.ShowNoticeNoCallback(21063002, cfgMainQuestData.Name)
		DreamlandModule.__PlayNextExecution()
		EventDispatcher.Dispatch(EventID.DreamlandLevelUnlockTask, taskCid)
	elseif cfgDreamMapServiceData.ExecutionType == Constant.Dreamland.ExecutionTypeUnlockMap then
		NoticeModule.ShowNotice(21063005)
		DreamlandModule.UnlockNextMap()
		DreamlandModule.__PlayNextExecution()
	else
		warning("未实现表现的执行类型：" .. cfgDreamMapServiceData.ExecutionType)
		DreamlandModule.__PlayNextExecution()
	end
end

function DreamlandModule.__CheckShowDialog()
	if #DreamlandModule.__ServiceDialogReadyIds > 0 and #DreamlandModule.__ExecutionDialogReadyIds > 0 then
		local removeServiceIndex = -1
		local removeExecutionIndex = -1

		for i = 1, #DreamlandModule.__ServiceDialogReadyIds do
			local serviceDialogId = DreamlandModule.__ServiceDialogReadyIds[i]

			for j = 1, #DreamlandModule.__ExecutionDialogReadyIds do
				local executionDialogId = DreamlandModule.__ExecutionDialogReadyIds[j]

				if serviceDialogId == executionDialogId then
					DreamlandModule.OpenDialog(serviceDialogId)

					removeServiceIndex = i
					removeExecutionIndex = j

					break
				end
			end

			if removeServiceIndex ~= -1 then
				break
			end
		end

		if removeServiceIndex ~= -1 then
			table.remove(DreamlandModule.__ServiceDialogReadyIds, removeServiceIndex)
			table.remove(DreamlandModule.__ExecutionDialogReadyIds, removeExecutionIndex)
		end
	end
end

function DreamlandModule.OpenDialog(cid)
	DreamlandModule.RecoverNormalSpeedWithoutSave()
	DialogModule.OpenDialog(cid, false, true)
end

function DreamlandModule.OnCloseDialogUI(startDialogCid)
	DreamlandModule.SetSpeedByPlayerPrefs()

	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Dreamland, function()
		DreamlandModule.__PlayNextExecution()
	end, 1)

	timer:Start()
end

function DreamlandModule.OnStopInteract(element, changedStates)
	if not element.IsHero then
		DreamlandModule.__ShowItemDrop()
	end
end

function DreamlandModule.OnElementPrepared(element)
	DreamlandModule.__PlayNextExecution()
end

function DreamlandModule.__PushDropCache(executionItemPOD)
	if executionItemPOD.getItems ~= nil and #executionItemPOD.getItems > 0 then
		for i = 1, #executionItemPOD.getItems do
			local itemShowPOD = executionItemPOD.getItems[i]
			local data = {}

			data.itemCid = itemShowPOD.cid
			data.itemNum = itemShowPOD.num

			table.insert(DreamlandModule.__TempDropList, data)
		end
	end

	if executionItemPOD.getSpAwardId ~= nil and executionItemPOD.getSpAwardId ~= 0 then
		local cfgDreamMapSPRewardDataData = CfgDreamMapSPRewardDataTable[executionItemPOD.getSpAwardId]
		local data = {}

		data.itemCid = cfgDreamMapSPRewardDataData.RewardID
		data.itemNum = cfgDreamMapSPRewardDataData.RewardNum
		data.speRewardCid = executionItemPOD.getSpAwardId

		table.insert(DreamlandModule.__TempDropList, data)
	end

	if executionItemPOD.getMovePoint ~= nil and executionItemPOD.getMovePoint > 0 then
		local data = {}

		data.movePoint = executionItemPOD.getMovePoint

		table.insert(DreamlandModule.__TempDropList, data)
	end
end

function DreamlandModule.__ShowItemDrop()
	for i = 1, #DreamlandModule.__TempDropList do
		local data = DreamlandModule.__TempDropList[i]

		if data.itemCid ~= nil then
			if data.speRewardCid ~= nil then
				NoticeModule.ShowFloatGetItem(data.itemCid, data.itemNum)
				DreamlandModule.UpdateSpeRewardCount(data.speRewardCid, 1)
			else
				NoticeModule.ShowFloatGetItem(data.itemCid, data.itemNum)
			end
		elseif data.movePoint ~= nil and data.movePoint > 0 then
			NoticeModule.ShowFloatGetItem(Constant.ItemID.DREAM_MOVE_POINT_FAKE_ITEM, data.movePoint)
			DreamlandModule.UpdateMovePoint(DreamlandModule.MapData.movePoint + data.movePoint)
		end
	end

	DreamlandModule.__TempDropList = {}

	DreamlandModule.__PlayNextExecution()
end

function DreamlandModule.CheckResumeDialog()
	if DreamlandModule.MapData ~= nil and DreamlandModule.MapData.currDialog ~= 0 then
		DreamlandModule.OpenDialog(DreamlandModule.MapData.currDialog)
	end
end

function DreamlandModule.GetCellPODByXY(x, y)
	local yNodes = DreamlandModule.MapDataXYMap[x]

	if yNodes == nil then
		return nil
	end

	return yNodes[y]
end

function DreamlandModule.GetAroundCellPODs(x, y)
	local aroundIndexes = GameSceneUtil.GetHexagonAroundXY(x, y)
	local cellPODs = {}

	for i = 1, #aroundIndexes do
		local indexGroup = aroundIndexes[i]
		local cellPOD = DreamlandModule.GetCellPODByXY(indexGroup[1], indexGroup[2])

		if cellPOD ~= nil then
			table.insert(cellPODs, cellPOD)
		end
	end

	return cellPODs
end

function DreamlandModule.GetTaskDataList(childType)
	local taskUIDataList = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.DREAM_LAND_TASK, {
		childType
	})
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.DREAM_LAND_TASK, {
		childType
	})

	for i = 1, #processing do
		local taskData = processing[i]
		local taskUIData = TaskUIData.New(taskData.cid, taskData.finNum, taskData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, taskData.createTime)

		table.insert(taskUIDataList, taskUIData)
	end

	for i = 1, #finished do
		local taskCid = finished[i]
		local cfgMainQuestData = CfgMainQuestTable[taskCid]

		if cfgMainQuestData.FinishIsShow == 1 then
			local cfgTargetData = CfgTargetTable[cfgMainQuestData.TargetId]
			local taskUIData = TaskUIData.New(taskCid, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

			table.insert(taskUIDataList, taskUIData)
		end
	end

	return taskUIDataList
end

function DreamlandModule.GetSerialTaskData(childType)
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.DREAM_LAND_TASK, {
		childType
	})
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.DREAM_LAND_TASK, {
		childType
	})
	local targetTaskUIData
	local processingMap = {}

	for i = 1, #processing do
		local taskData = processing[i]
		local taskUIData = TaskUIData.New(taskData.cid, taskData.finNum, taskData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, taskData.createTime)

		processingMap[taskUIData.cid] = taskUIData

		local cfgMainQuestData = CfgMainQuestTable[taskUIData.cid]

		if cfgMainQuestData.DefaultDisplay == 1 then
			targetTaskUIData = taskUIData
		end
	end

	if targetTaskUIData ~= nil then
		return targetTaskUIData
	end

	local finishedMap = {}
	local firstCfgData

	for i = 1, #finished do
		local taskCid = finished[i]
		local cfgMainQuestData = CfgMainQuestTable[taskCid]
		local cfgTargetData = CfgTargetTable[cfgMainQuestData.TargetId]
		local taskUIData = TaskUIData.New(taskCid, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

		finishedMap[taskUIData.cid] = taskUIData

		if cfgMainQuestData.DefaultDisplay == 1 then
			firstCfgData = cfgMainQuestData
		end
	end

	if firstCfgData ~= nil then
		targetTaskUIData = DreamlandModule.GetUnfinishedSerialTask(firstCfgData.UnLockDisplay, processingMap, finishedMap)
	end

	return targetTaskUIData
end

function DreamlandModule.GetUnfinishedSerialTask(taskCid, processingMap, finishedMap)
	local targetData = processingMap[taskCid]

	if targetData ~= nil then
		return targetData
	end

	local cfgMainQuestData = CfgMainQuestTable[taskCid]

	if cfgMainQuestData.UnLockDisplay ~= 0 then
		return DreamlandModule.GetUnfinishedSerialTask(cfgMainQuestData.UnLockDisplay, processingMap, finishedMap)
	end

	targetData = finishedMap[taskCid]

	return targetData
end

function DreamlandModule.IsNewTask(taskCid)
	return table.indexOf(DreamlandModule.__NewTaskCidList, taskCid) ~= -1
end

function DreamlandModule.RemoveNewTask(taskCid)
	local index = table.indexOf(DreamlandModule.__NewTaskCidList, taskCid)

	if index ~= -1 then
		table.remove(DreamlandModule.__NewTaskCidList, index)
	end
end

function DreamlandModule.ShowExecAnimationComplete()
	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DreamlandExecution, false)
	DreamlandModule.CheckPerfectExplore()
end

function DreamlandModule.CheckPerfectExplore()
	local node = DreamlandModule.DreamlandScene.Hero.Node
	local cfgDreamMapCellDataData = CfgDreamMapCellDataTable[node.CellPOD.dataId]

	if cfgDreamMapCellDataData.Type == 1 and DreamlandModule.IsPerfectExplore() then
		UIModule.Open(Constant.UIControllerName.DreamlandPerfectFinishUI, Constant.UILayer.UI)
		EventDispatcher.Dispatch(EventID.DreamlandPerfectExplore)
	end
end

function DreamlandModule.IsPerfectExplore()
	for i = 1, #DreamlandModule.MapData.cells do
		local cellData = DreamlandModule.MapData.cells[i]

		if cellData.dataId ~= 0 then
			local cfgDreamMapCellDataData = CfgDreamMapCellDataTable[cellData.dataId]

			if cfgDreamMapCellDataData.Type == 1 and not cellData.isOpen then
				return false
			end
		end
	end

	return true
end

function DreamlandModule.OpenHeroCell()
	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.DreamlandExecution, true)
	DreamlandModule.SendOpenCell(DreamlandModule.MapData.roleX, DreamlandModule.MapData.roleY)
end

function DreamlandModule.UnlockNextMap()
	local cfgDreamMapGlobalData = CfgDreamMapGlobalTable[DreamlandModule.GlobalCid]
	local curIndex = table.indexOf(cfgDreamMapGlobalData.DreamMapList, DreamlandModule.MapData.mapId)
	local nextIndex = curIndex + 1

	if nextIndex > #cfgDreamMapGlobalData.DreamMapList then
		return
	end

	local nextCid = cfgDreamMapGlobalData.DreamMapList[nextIndex]

	DreamlandModule.UpdateUnlockMaps(nextCid)
end

function DreamlandModule.GetLevelSpeedRatio()
	local data = PlayerPrefsUtil.GetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.DreamlandSpeed .. "_" .. DreamlandModule.MapData.mapId)

	if data == nil then
		return 1
	end

	if data.time < DreamlandModule.DailyDupPOD.common.openDate then
		return 1
	end

	return data.speed
end

function DreamlandModule.SetLevelSpeedRatio(value)
	DreamlandModule.__SetLevelSpeedRatioSpeed(value)
	PlayerPrefsUtil.SetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.DreamlandSpeed .. "_" .. DreamlandModule.MapData.mapId, {
		speed = value,
		time = math.floor(PlayerModule.GetServerTime())
	})
end

function DreamlandModule.RecoverNormalSpeedWithoutSave()
	DreamlandModule.__SetLevelSpeedRatioSpeed(1)
end

function DreamlandModule.SetSpeedByPlayerPrefs()
	local speed = DreamlandModule.GetLevelSpeedRatio()

	DreamlandModule.__SetLevelSpeedRatioSpeed(speed)
end

function DreamlandModule.__SetLevelSpeedRatioSpeed(value)
	UnityEngine.Time.timeScale = value

	GameEntry.Sound:SetGroupPitch(Constant.SoundGroup.ENVIRONMENT, value)
	GameEntry.Sound:SetGroupPitch(Constant.SoundGroup.UI, value)
end

function DreamlandModule.GetExploreUIAsset()
	local cfgDreamMapGlobalData = CfgDreamMapGlobalTable[DreamlandModule.GlobalCid]

	return cfgDreamMapGlobalData.ExploreHallUIBG
end

function DreamlandModule.GetHeroNodeData()
	local targetData

	for i = 1, #DreamlandModule.MapData.cells do
		local cellData = DreamlandModule.MapData.cells[i]

		if cellData.x == DreamlandModule.MapData.roleX and cellData.y == DreamlandModule.MapData.roleY then
			targetData = cellData

			break
		end
	end

	return targetData
end

function DreamlandModule.GetMallCidList()
	local cfgDreamMapGlobalData = CfgDreamMapGlobalTable[DreamlandModule.GlobalCid]

	return cfgDreamMapGlobalData.MallGoods
end

function DreamlandModule.ClearOnLeaveMap()
	if not DreamlandModule.IsInDreamlandScene then
		return
	end

	DreamlandModule.IsInDreamlandScene = false

	ModuleTimerUtil.Stop(Constant.ModuleTimerName.Dreamland)
	DreamlandModule.RemoveListeners()
	DreamlandModule.DreamlandScene:Dispose()

	DreamlandModule.DreamlandScene = nil
	DreamlandModule.MapData = nil
	DreamlandModule.MapDataXYMap = {}

	DreamlandModule.__ExecutionQueue:Clear()

	DreamlandModule.__TempDropList = {}
	DreamlandModule.__ExecutionDialogReadyIds = {}
	DreamlandModule.__ServiceDialogReadyIds = {}
	DreamlandModule.__NewTaskCidList = {}
	DreamlandModule.__TempOpenCellParam = nil
end

function DreamlandModule.Shutdown()
	DreamlandModule.ClearOnLeaveMap()
	DreamlandModule.RecoverNormalSpeedWithoutSave()

	DreamlandModule.DailyDupPOD = nil
	DreamlandModule.GlobalCid = 0
end
