-- chunkname: @IQIGame\\Module\\CommonActivity\\MagicTower\\MagicTowerModule.lua

require("IQIGame.Scene.MagicTower.InternalConst.MagicTowerStateEnum")
require("IQIGame.Scene.MagicTower.InternalConst.MagicTowerExecutionType")
require("IQIGame.Scene.MagicTower.InternalConst.MagicTowerConst")
require("IQIGame.Scene.MagicTower.InternalConst.MagicTowerRoleAttrID")

local MagicTowerScene = require("IQIGame.Scene.MagicTower.MagicTowerScene")
local TaskUIData = require("IQIGame.Module.Task.TaskUIData")
local GameSceneUtil = require("IQIGame.Util.GameSceneUtil")
local MagicTowerExecAnimData = require("IQIGame.Scene.MagicTower.MagicTowerExecAnimData")

MagicTowerModule = {
	GlobalCid = 0,
	PlayingExecution = false,
	IsInMagicTowerScene = false,
	__NewTaskCidList = {}
}

function MagicTowerModule.InitMapData(mapPOD)
	MagicTowerModule.MapData = {
		NodeOffsetX = 0,
		NodeOffsetY = 0,
		NodeGapY = 0,
		NodeGapX = 0,
		currentFloor = 0,
		floorStepNodeNumMap = {},
		floorStepMaxNodeNumMap = {},
		floorXYNodeMap = {}
	}

	local gapX, gapY = MagicTowerSceneApi:GetString("NodeGapXY")
	local offsetX, offsetY = MagicTowerSceneApi:GetString("NodeOffsetXY")

	MagicTowerModule.MapData.NodeGapX = gapX
	MagicTowerModule.MapData.NodeGapY = gapY
	MagicTowerModule.MapData.NodeOffsetX = offsetX
	MagicTowerModule.MapData.NodeOffsetY = offsetY
	MagicTowerModule.MapData.mapPOD = mapPOD
end

function MagicTowerModule.Reload(dailyDupPOD)
	MagicTowerModule.DailyDupPOD = dailyDupPOD

	if MagicTowerModule.DailyDupPOD ~= nil then
		MagicTowerModule.GlobalCid = MagicTowerModule.DailyDupPOD.common.openCount
	end
end

function MagicTowerModule.Update(dailyDupPOD)
	MagicTowerModule.DailyDupPOD = deepClonePOD(dailyDupPOD, MagicTowerModule.DailyDupPOD)
	MagicTowerModule.GlobalCid = MagicTowerModule.DailyDupPOD.common.openCount
end

function MagicTowerModule.IsShow()
	local cfgDailyDupData = CfgDailyDupTable[14]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and MagicTowerModule.DailyDupPOD ~= nil and MagicTowerModule.DailyDupPOD.common.status ~= 0
end

function MagicTowerModule.AddListeners()
	EventDispatcher.AddEventListener(EventID.MagicTowerStopInteract, MagicTowerModule.OnStopInteract)
end

function MagicTowerModule.RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.MagicTowerStopInteract, MagicTowerModule.OnStopInteract)
end

function MagicTowerModule.SendEnterMap(mapCid)
	net_magicTower.enterMap(mapCid)
end

function MagicTowerModule.OnEnterMap(mapData)
	MagicTowerModule.IsInMagicTowerScene = true
	MagicTowerModule.__ExecutionQueue = Queue.New()

	MagicTowerModule.AddListeners()
	MagicTowerModule.UpdateMapData(mapData)
	CommonActivitySceneModule.EnterScene(CommonActivityVirtualSceneID.MagicTower, MagicTowerModule.OnSceneLoaded)
end

function MagicTowerModule.OnSceneLoaded()
	MagicTowerModule.MagicTowerScene = MagicTowerScene.New()
end

function MagicTowerModule.ExitScene()
	CommonActivitySceneModule.SwitchScene(MagicTowerModule.ClearOnLeaveMap)
end

function MagicTowerModule.SendMoveArrive(cellId)
	net_magicTower.move(cellId)
end

function MagicTowerModule.OnMoveArrive(cellId)
	MagicTowerModule.MapData.mapPOD.role.cellId = cellId

	EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MagicTowerExecution, true)
	MagicTowerModule.MagicTowerScene:ResetHeroPos()
end

function MagicTowerModule.OnExecution(executionItem)
	warning("OnExecution " .. executionItem.executionType)

	local dataList = MagicTowerExecAnimData.CreateDataGroup(executionItem)

	for j = 1, #dataList do
		MagicTowerModule.__ExecutionQueue:Enqueue(dataList[j])
	end

	if not MagicTowerModule.PlayingExecution then
		MagicTowerModule.PlayNextExecution()
	end
end

function MagicTowerModule.OnOpenDialog(dialogCid)
	MagicTowerModule.MapData.mapPOD.currDialog = dialogCid

	MagicTowerModule.OpenDialog(dialogCid)
end

function MagicTowerModule.OnSelectDialog(nextDialogCid)
	EventDispatcher.Dispatch(EventID.JumpToNextDialog, nextDialogCid)

	if nextDialogCid == 0 then
		local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.MagicTower, function()
			MagicTowerModule.PlayNextExecution()

			MagicTowerModule.MapData.mapPOD.currDialog = 0
		end, 1)

		timer:Start()
	else
		MagicTowerModule.MapData.mapPOD.currDialog = nextDialogCid
	end
end

function MagicTowerModule.UpdateMapData(mapPOD)
	MagicTowerModule.InitMapData(mapPOD)

	local heroNodePOD

	for i = 1, #MagicTowerModule.MapData.mapPOD.cells do
		local cellData = MagicTowerModule.MapData.mapPOD.cells[i]
		local floorCellMap = MagicTowerModule.MapData.floorXYNodeMap[cellData.floor]

		floorCellMap = floorCellMap or {}
		MagicTowerModule.MapData.floorXYNodeMap[cellData.floor] = floorCellMap
		floorCellMap[cellData.x] = floorCellMap[cellData.x] or {}
		floorCellMap[cellData.x][cellData.y] = cellData

		local floorStepNodeNumMap = MagicTowerModule.MapData.floorStepNodeNumMap[cellData.floor]

		floorStepNodeNumMap = floorStepNodeNumMap or {}
		MagicTowerModule.MapData.floorStepNodeNumMap[cellData.floor] = floorStepNodeNumMap

		local stepNodeNum = floorStepNodeNumMap[cellData.x]

		stepNodeNum = stepNodeNum or 0
		stepNodeNum = stepNodeNum + 1
		floorStepNodeNumMap[cellData.x] = stepNodeNum

		if cellData.id == MagicTowerModule.MapData.mapPOD.role.cellId then
			heroNodePOD = cellData
		end
	end

	for floor, steNodeNumMap in pairs(MagicTowerModule.MapData.floorStepNodeNumMap) do
		local maxNum = 0

		for step, nodeNum in pairs(steNodeNumMap) do
			maxNum = math.max(maxNum, nodeNum)
		end

		MagicTowerModule.MapData.floorStepMaxNodeNumMap[floor] = maxNum
	end

	MagicTowerModule.MapData.currentFloor = heroNodePOD.floor
end

function MagicTowerModule.PlayNextExecution()
	if MagicTowerModule.__ExecutionQueue.Size == 0 then
		warning("PlayNextExecution complete")

		MagicTowerModule.PlayingExecution = false

		MagicTowerModule.MagicTowerScene:KillElementsOnHeroIndexX()
		EventDispatcher.Dispatch(EventID.LockInput, Constant.LockInputReason.MagicTowerExecution, false)

		return
	end

	MagicTowerModule.PlayingExecution = true

	local animData = MagicTowerModule.__ExecutionQueue:Dequeue()

	if animData.ExecutionType ~= nil then
		if animData.ExecutionType == MagicTowerExecutionType.Battle then
			MagicTowerModule.MagicTowerScene:SetHeroNodeState(MagicTowerStateEnum.Fight)
		elseif animData.ExecutionType == MagicTowerExecutionType.GetItem then
			MagicTowerModule.PlayNextExecution()
		elseif animData.ExecutionType == MagicTowerExecutionType.AddAttr then
			local willCostKeySuccessfully = MagicTowerModule.CheckCostKeyState(animData.ExecutionParam, 4)

			if willCostKeySuccessfully then
				MagicTowerModule.MagicTowerScene:SetHeroNodeState(MagicTowerStateEnum.Gather)
			else
				MagicTowerModule.PlayNextExecution()
			end
		elseif animData.ExecutionType == MagicTowerExecutionType.Dialog then
			MagicTowerModule.PlayNextExecution()
		elseif animData.ExecutionType == MagicTowerExecutionType.ModifyPlayerParam then
			MagicTowerModule.PlayNextExecution()
		elseif animData.ExecutionType == MagicTowerExecutionType.GetEquip then
			MagicTowerModule.PlayNextExecution()
		elseif animData.ExecutionType == MagicTowerExecutionType.GoNextFloor then
			MagicTowerModule.PlayNextExecution()
		elseif animData.ExecutionType == MagicTowerExecutionType.GetKey then
			MagicTowerModule.PlayNextExecution()
		else
			logError("未知的执行类型：" .. animData.ExecutionType)
			MagicTowerModule.PlayNextExecution()
		end
	elseif animData.DropItemList ~= nil then
		for i = 1, #animData.DropItemList do
			local showItemPOD = animData.DropItemList[i]

			NoticeModule.ShowFloatGetItem(showItemPOD.cid, showItemPOD.num)
		end

		MagicTowerModule.PlayNextExecution()
	elseif animData.RoleUpdate ~= nil then
		local role = MagicTowerModule.MapData.mapPOD.role
		local changedAttrMap = animData:GetChangedAttrMap(role)

		if changedAttrMap ~= nil then
			for attrId = 1, MagicTowerRoleAttrID.LENGTH do
				local deltaValue = changedAttrMap[attrId]

				if deltaValue ~= nil then
					NoticeModule.ShowNoticeByType(1, MagicTowerSceneApi:GetString("AttrChangeText", attrId, deltaValue))
				end
			end
		end

		local getEquipIdList = animData:GetChangedEquip(role)

		if getEquipIdList ~= nil then
			for i = 1, #getEquipIdList do
				local equipId = getEquipIdList[i]
				local cfgMagicTowerEquipData = CfgMagicTowerEquipTable[equipId]

				NoticeModule.ShowFloatGetItem(cfgMagicTowerEquipData.ItemID, 1)
			end
		end

		local getKeyChangedList = animData:GetChangedKeyMap(role)

		if getKeyChangedList ~= nil then
			for i = 1, MagicTowerConst.KeyTypeNum do
				local deltaValue = getKeyChangedList[i]
				local keyFakeItemCid = MagicTowerModule.GetKeyItemId(i)

				if deltaValue ~= nil then
					if deltaValue > 0 then
						NoticeModule.ShowFloatGetItem(keyFakeItemCid, deltaValue)
					else
						local cfgItemData = CfgItemTable[keyFakeItemCid]

						NoticeModule.ShowNoticeByType(1, MagicTowerSceneApi:GetString("CostKeyText", cfgItemData.Name, deltaValue))
					end
				end
			end
		end

		local oldCellId = role.cellId

		MagicTowerModule.UpdateRoleData(animData.RoleUpdate)

		local oldCellPOD = MagicTowerModule.GetCellPODByID(oldCellId)
		local newCellPOD = MagicTowerModule.GetCellPODByID(animData.RoleUpdate.cellId)

		if newCellPOD.floor ~= oldCellPOD.floor then
			MagicTowerModule.MapData.currentFloor = newCellPOD.floor

			MagicTowerModule.MagicTowerScene:GoToNextFloor(MagicTowerModule.PlayNextExecution)
		else
			MagicTowerModule.PlayNextExecution()
		end
	end
end

function MagicTowerModule.CheckCostKeyState(executionParam, startIndex)
	local role = MagicTowerModule.MapData.mapPOD.role
	local sampleKeyCost

	for i = 1, MagicTowerConst.KeyTypeNum do
		local keyCost = tonumber(executionParam[startIndex - 1 + i]) or 0

		if keyCost > 0 then
			local canCostKeyNum = role["key" .. i] - keyCost >= 0 and keyCost or 0

			if sampleKeyCost == nil then
				sampleKeyCost = canCostKeyNum
			else
				sampleKeyCost = sampleKeyCost > 0 and canCostKeyNum or 0
			end
		end
	end

	return sampleKeyCost ~= nil and sampleKeyCost > 0
end

function MagicTowerModule.UpdateRoleData(newRoleData)
	local role = MagicTowerModule.MapData.mapPOD.role

	role.cellId = newRoleData.cellId
	role.hp = newRoleData.hp
	role.atk = newRoleData.atk
	role.def = newRoleData.def
	role.equipments = newRoleData.equipments
	role.key1 = newRoleData.key1
	role.key2 = newRoleData.key2
	role.key3 = newRoleData.key3

	EventDispatcher.Dispatch(EventID.MagicTowerUpdateRoleData)
end

function MagicTowerModule.GetKeyItemId(index)
	if index == 1 then
		return 611
	elseif index == 2 then
		return 612
	else
		return 613
	end
end

function MagicTowerModule.OpenDialog(cid)
	DialogModule.OpenDialog(cid, false, true)
end

function MagicTowerModule.CheckResumeDialog()
	if MagicTowerModule.MapData.mapPOD ~= nil and MagicTowerModule.MapData.mapPOD.currDialog ~= 0 then
		MagicTowerModule.OpenDialog(MagicTowerModule.MapData.mapPOD.currDialog)
	end
end

function MagicTowerModule.OnStopInteract()
	MagicTowerModule.MagicTowerScene:OnElementStopInteract()
	MagicTowerModule.PlayNextExecution()
end

function MagicTowerModule.GetCellPODByXY(floor, x, y)
	local floorNodes = MagicTowerModule.MapData.floorXYNodeMap[floor]

	if floorNodes == nil then
		return nil
	end

	local yNodes = floorNodes[x]

	if yNodes == nil then
		return nil
	end

	return yNodes[y]
end

function MagicTowerModule.GetCellPODByID(cellId)
	for i = 1, #MagicTowerModule.MapData.mapPOD.cells do
		local cellPOD = MagicTowerModule.MapData.mapPOD.cells[i]

		if cellPOD.id == cellId then
			return cellPOD
		end
	end

	return nil
end

function MagicTowerModule.GetTaskDataList()
	local taskUIDataList = {}
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.MAGIC_TOWER_TASK, nil)
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.MAGIC_TOWER_TASK, nil)

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

function MagicTowerModule.GetUnfinishedSerialTask(taskCid, processingMap, finishedMap)
	local targetData = processingMap[taskCid]

	if targetData ~= nil then
		return targetData
	end

	local cfgMainQuestData = CfgMainQuestTable[taskCid]

	if cfgMainQuestData.UnLockDisplay ~= 0 then
		return MagicTowerModule.GetUnfinishedSerialTask(cfgMainQuestData.UnLockDisplay, processingMap, finishedMap)
	end

	targetData = finishedMap[taskCid]

	return targetData
end

function MagicTowerModule.IsNewTask(taskCid)
	return table.indexOf(MagicTowerModule.__NewTaskCidList, taskCid) ~= -1
end

function MagicTowerModule.RemoveNewTask(taskCid)
	local index = table.indexOf(MagicTowerModule.__NewTaskCidList, taskCid)

	if index ~= -1 then
		table.remove(MagicTowerModule.__NewTaskCidList, index)
	end
end

function MagicTowerModule.GetExploreUIAsset()
	return "Activity_MagicTower"
end

function MagicTowerModule.NodeSeqXYToPosition(floor, seqX, seqY)
	local indexX, indexY = MagicTowerModule.NodeSeqXYToIndexXY(floor, seqX, seqY)
	local x, y = MagicTowerModule.NodeIndexXYToPositionXY(indexX, indexY)

	return Vector3(x, y, 0)
end

function MagicTowerModule.NodeIndexXYToPositionXY(indexX, indexY)
	local gapX = MagicTowerModule.MapData.NodeGapX
	local gapY = MagicTowerModule.MapData.NodeGapY
	local offsetX = MagicTowerModule.MapData.NodeOffsetX
	local offsetY = MagicTowerModule.MapData.NodeOffsetY
	local x = (indexX - 1) * gapX + offsetX
	local y = (indexY - 1) * gapY + gapY / 2 * (indexX % 2 == 0 and 1 or 0) + offsetY

	return x, y
end

function MagicTowerModule.NodeSeqXYToIndexXY(floor, seqX, seqY)
	local maxStepNodeNum = MagicTowerModule.MapData.floorStepMaxNodeNumMap[floor]
	local firstNodeIndexY = math.floor(maxStepNodeNum / 2) + 1
	local indexX = seqX
	local stepNodeNumMap = MagicTowerModule.MapData.floorStepNodeNumMap[floor]
	local currentStepNodeNum = stepNodeNumMap[indexX]
	local indexY = firstNodeIndexY - math.ceil((currentStepNodeNum - 1) / 2) - 1 + seqY

	return indexX, indexY
end

function MagicTowerModule.IsNearBy(cellPOD1, cellPOD2)
	local floor = MagicTowerModule.MapData.currentFloor
	local indexX1, indexY1 = MagicTowerModule.NodeSeqXYToIndexXY(floor, cellPOD1.x, cellPOD1.y)
	local indexX2, indexY2 = MagicTowerModule.NodeSeqXYToIndexXY(floor, cellPOD2.x, cellPOD2.y)
	local aroundIndexes = GameSceneUtil.GetHexagonAroundXY(indexX1, indexY1, true)

	for i = 1, #aroundIndexes do
		local indexGroup = aroundIndexes[i]

		if indexX2 == indexGroup[1] and indexY2 == indexGroup[2] then
			return true
		end
	end

	return false
end

function MagicTowerModule.GiveUp()
	net_magicTower.giveup()
end

function MagicTowerModule.OnSettlement(isSuccess)
	UIModule.Open(Constant.UIControllerName.MagicTowerSettlementUI, Constant.UILayer.UI, {
		isSuccess = isSuccess
	})

	MagicTowerModule.DailyDupPOD.magicTowerPOD.currMapId = 0
end

function MagicTowerModule.ClearOnLeaveMap()
	if not MagicTowerModule.IsInMagicTowerScene then
		return
	end

	ModuleTimerUtil.Stop(Constant.ModuleTimerName.MagicTower)

	MagicTowerModule.IsInMagicTowerScene = false

	MagicTowerModule.RemoveListeners()
	MagicTowerModule.MagicTowerScene:Dispose()

	MagicTowerModule.MagicTowerScene = nil

	MagicTowerModule.InitMapData()

	MagicTowerModule.__NewTaskCidList = {}

	MagicTowerModule.__ExecutionQueue:Clear()

	MagicTowerModule.PlayingExecution = false
end

function MagicTowerModule.Shutdown()
	CommonActivitySceneModule.Shutdown()
	MagicTowerModule.ClearOnLeaveMap()

	MagicTowerModule.DailyDupPOD = nil
	MagicTowerModule.GlobalCid = 0
end
