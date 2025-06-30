-- chunkname: @IQIGame\\Module\\WorldMap\\WorldMapModule.lua

WorldMapModule = {}

local AreaDataClass = require("IQIGame/Module/WorldMap/WorldMapAreaData")
local ActionClass = require("IQIGame/Module/WorldMap/WorldMapComponentActionData")
local this = WorldMapModule

function this.Initialize()
	this.areaDataList = {}
	this.roomDataList = {}
	this.componentsActionDataList = {}
	this.componentsDataList = {}
	this.enabledNpcNameShow = true
end

function this.Reload(sceneMapPOD)
	this.mapPOD = sceneMapPOD

	for i, _ in pairsCfg(CfgWorldMapAreaTable) do
		this._GenerateAreaData(i, this.mapPOD.areas[i] and this.mapPOD.areas[i] or nil, this.mapPOD.rooms, this.mapPOD.comps, this.mapPOD.actions)
	end

	for _, cfgAction in pairsCfg(CfgWorldRoomActionTable) do
		if cfgAction.CompId == 0 then
			local ac = ActionClass.New(cfgAction)

			if this.mapPOD.actions[cfgAction.Id] then
				ac:ReloadPodsData(this.mapPOD.actions[cfgAction.Id])
			end

			WorldMapModule.componentsActionDataList[cfgAction.Id] = ac
		end
	end
end

function this._GenerateAreaData(areaId, areaPod, roomsPod, compsPod, actionsPod)
	local cfg = CfgUtil.GetCfgWorldMapAreaDataWithID(areaId)
	local areaData = AreaDataClass.New(cfg, areaPod, roomsPod, compsPod, actionsPod)

	this.areaDataList[areaId] = areaData
end

function this.ShutDown()
	return
end

function this.GetAreaDataWithID(id)
	return this.areaDataList[id]
end

function this.GetCurrentAreaData()
	local currentAreaPOD

	currentAreaPOD = this.areaDataList[this.mapPOD.currentAreaCid]

	if not currentAreaPOD then
		logError("【RPG】没有找到当前地图区域的服务器数据 currentAreaCid = " .. this.mapPOD.currentAreaCid)

		return
	end

	return currentAreaPOD
end

function this.GetCurrentHomeData()
	local currentAreaData = this.GetCurrentAreaData()

	if not currentAreaData then
		return
	end

	local roomData = currentAreaData:GetCurrentRoomData()

	if not roomData then
		logError("【RPG】没有找到当前房间的服务器数据 id = " .. currentAreaData:GetCurrentRoomId())
	end

	return roomData
end

function this.GetCurrentRoomId()
	local currentAreaData = this.GetCurrentAreaData()

	if not currentAreaData then
		return
	end

	return currentAreaData:GetCurrentRoomId()
end

function this.GetCurrentStory()
	local currentRoom = this.GetCurrentHomeData()

	if not currentRoom then
		logError("【RPG】试图访问当前剧情，但没有找到当前房间数据")

		return
	end

	return currentRoom.currentPlot
end

function this.GetRoomDataWithRoomID(roomID)
	return this.roomDataList[roomID]
end

function this.GetRoomSceneCfgWithRoomId(roomId)
	local roomData = this.GetRoomDataWithRoomID(roomId)

	if roomData then
		return roomData:GetCfgRoomScene()
	end
end

function this.GetComponentsWithRoomId(roomId, needAll)
	local roomData = this.GetRoomDataWithRoomID(roomId)

	if not roomData then
		return nil
	end

	local componentList = roomData:GetComponentsList()

	if needAll then
		return componentList
	end

	local data = {}

	for _, v in pairs(componentList) do
		if v:GetActive() then
			table.insert(data, v)
		end
	end

	return data
end

function this.GetComponentDataWithId(componentId)
	return this.componentsDataList[componentId]
end

function this.GetComponentActionDataWithId(actionId)
	return this.componentsActionDataList[actionId]
end

function this.GetAreaName(cfgWorldArea)
	local name = "null"
	local len = #cfgWorldArea.Name

	for i = 1, len do
		if ConditionModule.Check(cfgWorldArea.NameCondition[i]) and not LuaUtility.StrIsNullOrEmpty(cfgWorldArea.Name[i]) then
			name = cfgWorldArea.Name[i]
		end
	end

	return name
end

function this.EnterRoomWithRoomId(roomId, playerBornPos)
	local roomSceneCfg = this.GetRoomSceneCfgWithRoomId(roomId)

	if not roomSceneCfg then
		logError("【RPG】进入房间失败，没有找到房间id = " .. roomId .. "的场景房间配置")

		return
	end

	if not HomeModule.homeScene then
		return
	end

	HomeModule.homeScene:ChangeRoom(roomSceneCfg.Id, playerBornPos)
end

function this.EnterRoomCheck(areaCid, roomCid, enterRoomData)
	if this.mapPOD.rooms[roomCid].currentPlot and this.mapPOD.rooms[roomCid].currentPlot ~= 0 then
		StoryChapterModule.EnterDup(this.mapPOD.rooms[roomCid].currentPlot)

		return
	end

	if StoryModule.IsStoring then
		SceneTransferModule.StoryToMainCity(nil, {
			revertUI = false
		})
	else
		this.EnterRoomWithRoomId(roomCid, enterRoomData.playerBornPos)
	end
end

function this.ExitStoryOrLevel()
	local roomId = CfgUtil.GetCfgDiscreteFirstDataWithID(Constant.DiscreteData.WorldMapRPGResetRoom)

	this.EnterRoom(roomId, true)
end

function this.BanNpcNameShow()
	this.enabledNpcNameShow = false

	local room = HomeModule.GetCurrentHomeRoom()

	if not room then
		return
	end

	room:HideAllNpcName()
end

function this.EnabledNpcNameShow()
	this.enabledNpcNameShow = true
end

function this.GetRoomIDWithTag(tagType)
	for _, v in pairs(this.roomDataList) do
		if v.currentPlot and v.currentPlot ~= 0 then
			local cfgWorldMapItem = CfgUtil.GetCfgWorldMapItemDataWithID(v.currentPlot)

			if cfgWorldMapItem.IconType == tagType then
				return v.cid
			end
		end
	end
end

function this.GetSoloInviteCount()
	return this.mapPOD.info.todayAloneCount and this.mapPOD.info.todayAloneCount or 0
end

function this.PackingEnterRoomData(playerBornPos)
	local allStr
	local strPos = string.format("%s,%s,%s", playerBornPos.x, playerBornPos.y, playerBornPos.z)

	allStr = string.format("%s|", strPos)

	return allStr
end

function this.UnPackingEnterRoomData(data)
	if not data then
		return
	end

	local tb = {}
	local allArray = string.split(data, "|")

	if not allArray then
		return
	end

	if allArray[1] then
		local posArray = string.split(allArray[1], ",")

		if not LuaUtility.StrIsNullOrEmpty(posArray[1]) and not LuaUtility.StrIsNullOrEmpty(posArray[2]) and not LuaUtility.StrIsNullOrEmpty(posArray[3]) then
			tb.playerBornPos = Vector3.New(tonumber(posArray[1]), tonumber(posArray[2]), tonumber(posArray[3]))
		end
	end

	return tb
end

function this.GetCurrentMainTask()
	local mainTask
	local mainTaskArray = TaskSystemModule.GetSortForTypeDataList(Constant.MainTaskType.RPGMain, Constant.ExtendTaskType.RPGMain_Main, TaskSystemModule.sortType.Id, true, true)
	local len = #mainTaskArray

	for i = 1, len do
		if not TaskSystemModule.GetFinishedTaskWithID(mainTaskArray[i].cid) and mainTaskArray[i].status == Constant.TaskStatus.doing then
			mainTask = mainTaskArray[i]

			break
		end
	end

	if not mainTask then
		return
	end

	local childTaskArray = TaskSystemModule.GetSortForTypeDataList(Constant.MainTaskType.RPGMain, {
		mainTask.cid
	}, TaskSystemModule.sortType.Id, true, false)
	local len = #childTaskArray

	for i = 1, len do
		if not TaskSystemModule.GetFinishedTaskWithID(childTaskArray[i].cid) and childTaskArray[i].status == Constant.TaskStatus.doing then
			return mainTask, childTaskArray[i]
		end
	end
end

function this.GetCurrentChildTaskByParentTaskId(parentTaskId, taskType)
	local mainTask = TaskSystemModule.GetTaskByConfig(parentTaskId)
	local childTaskArray = TaskSystemModule.GetSortForTypeDataList(taskType, {
		mainTask.cid
	}, TaskSystemModule.sortType.Id, true, false)
	local len = #childTaskArray

	for i = 1, len do
		if not TaskSystemModule.GetFinishedTaskWithID(childTaskArray[i].cid) and childTaskArray[i].status == Constant.TaskStatus.doing then
			return childTaskArray[i]
		end
	end
end

function this.GetChildTaskType(taskId)
	local task = CfgUtil.GetTaskCfgWithID(taskId)

	return task.TypeExtend[2]
end

function this.TaskGo()
	return
end

function this.GetTimeState()
	return this.mapPOD.timeSpan
end

function this.EnterArea(areaId, active)
	if this.mapPOD.currentAreaCid == areaId then
		logError("【RPG】当前已在该区域")

		return
	end

	net_sceneMap.enterArea(areaId, active)
end

function this.EnterRoom(roomId, active, data, hideNotice)
	if roomId == this.GetCurrentHomeData().cid then
		if not hideNotice then
			NoticeModule.ShowNotice(11027)
		else
			log("EnterRoom RoomID:{0} active:{1} data:{2}", roomId, active, data)
		end

		return
	end

	net_sceneMap.enterRoom(roomId, active, data and data or "")
end

function this.TriggerAction(actionCid, schedule, triggerParam)
	if actionCid == 0 then
		return
	end

	local actionData = this.GetComponentActionDataWithId(actionCid)

	if not actionData then
		logError("【RPG】没有找到行为 id =" .. actionCid)

		return
	end

	if actionData:GetCfg().ActionTag == Constant.RPGActionTagType.Saunter and this.mapPOD.info.todayShoppingCount >= CfgUtil.GetCfgDiscreteFirstDataWithID(Constant.DiscreteData.TodayShoppingCount) then
		NoticeModule.ShowNotice(12018)

		return
	end

	if actionData:GetCfg().TriggerTimesMax ~= 0 and this.GetActionFinishedCount(actionData.cid) >= actionData:GetCfg().TriggerTimesMax and schedule ~= -1 then
		return
	end

	local canTrigger = actionData:GetCfg().ExecutableCondition

	if not ConditionModule.Check(canTrigger) then
		NoticeModule.ShowNotice(actionData:GetCfg().FailNotice)
		EventDispatcher.Dispatch(EventID.CommonDialogControl_Action_EndDialog, actionCid, triggerParam)

		return
	end

	if this.CheckNot2ServerAction(actionData) then
		this.RPGActionTrigger(actionData:GetCfg().ActionType, actionData:GetCfg().ActionParam, actionData.cid)

		return
	end

	if this.SpecialActionTrigger(actionData, schedule) then
		return
	end

	net_sceneMap.triggerAction(actionCid, schedule, triggerParam and triggerParam or "")
	log(string.format("【行为】客户端请求 --> id = %s,schedule = %s", actionCid, schedule))
end

function this.ChangeMapTimeSpan(timeSpan)
	if this.GetTimeState() == timeSpan then
		return
	end

	net_sceneMap.changeMapTimeSpan(timeSpan)
end

function this.EnterAreaResult(areaCid, roomCid, active)
	this.mapPOD.currentAreaCid = areaCid
	this.mapPOD.areas[areaCid].currentRoomCid = roomCid
	this.areaDataList[areaCid].currentRoomCid = roomCid

	if not active then
		return
	end

	this.EnterRoomCheck(areaCid, roomCid)
end

function this.EnterRoomResult(areaCid, roomCid, active, data)
	log(string.format("【RPG】切换房间, 当前区域 = %s，房间 = %s,切换至区域 = %s,房间 = %s ；active = %s", this.mapPOD.currentAreaCid, this.mapPOD.areas[this.mapPOD.currentAreaCid].currentRoomCid, areaCid, roomCid, tostring(active)))

	this.mapPOD.currentAreaCid = areaCid
	this.mapPOD.areas[areaCid].currentRoomCid = roomCid
	this.areaDataList[areaCid].currentRoomCid = roomCid

	EventDispatcher.Dispatch(EventID.WorldMapRoom_EnterRoomResultEvent)

	if not active then
		return
	end

	local enterRoomData = this.UnPackingEnterRoomData(data)

	this.EnterRoomCheck(areaCid, roomCid, enterRoomData)
end

function this.TriggerActionResult(actionCid, schedule, pod)
	EventDispatcher.Dispatch(EventID.CommonDialogControl_Action_EndDialog, actionCid, pod)

	local actionData = this.GetComponentActionDataWithId(actionCid)

	if this.GetActionScheduleWithType(actionData:GetCfg().ActionType) ~= schedule then
		return
	end

	this.RPGActionTrigger(actionData:GetCfg().ActionType, actionData:GetCfg().ActionParam, actionCid)
	log(string.format("【行为】服务器回复 --> id = %s,schedule = %s", actionCid, schedule))
end

function this.MoveCompResult()
	return
end

function this.NotifyAreas(areas)
	for id, v in pairs(areas) do
		this.mapPOD.areas[id] = v

		if this.areaDataList[id] then
			this.areaDataList[id]:ReloadPodData(v)
		end
	end
end

function this.NotifyRooms(rooms)
	for _, roomPod in pairs(rooms) do
		this.mapPOD.rooms[roomPod.cid] = roomPod

		for i, v in pairs(this.mapPOD.rooms) do
			local roomData = this.GetRoomDataWithRoomID(roomPod.cid)

			if roomData then
				roomData:ReloadPodData(roomPod)
			end
		end
	end
end

function this.NotifyComps(comps)
	local room = HomeModule.GetCurrentHomeRoom()

	for _, v in pairs(comps) do
		local comp = this.GetComponentDataWithId(v.cid)

		if comp then
			comp:ReloadPodData(v)

			if room and comp.roomCid == this.GetCurrentRoomId() then
				room:RefreshComponentWithId(v.cid)
			end
		end
	end
end

function this.NotifyActions(actions)
	local room = HomeModule.GetCurrentHomeRoom()

	for _, v in pairs(actions) do
		local action = this.GetComponentActionDataWithId(v.cid)

		if action then
			action:ReloadPodsData(v)
		else
			local cfgAction = CfgUtil.GetCfgWorldRoomActionDataWithID(v.cid)

			action = ActionClass.New(cfgAction, v)
			WorldMapModule.componentsActionDataList[v.cid] = action
		end

		local componentData = WorldMapModule.GetComponentDataWithId(action.compCid)

		if room and componentData and componentData.roomCid == this.GetCurrentRoomId() then
			room:RefreshComponentWithId(action.compCid)
		end
	end
end

function this.NotifyFinishActions(finishActions)
	local componentId

	for i, v in pairs(finishActions) do
		log(string.format("【RPG】完成行为 id = %s, val = %s", i, v))

		if this.mapPOD.finishActions[i] then
			local actionData = this.GetComponentActionDataWithId(i)

			componentId = actionData.compCid

			if v <= 0 then
				this.mapPOD.finishActions[i] = nil
			else
				this.mapPOD.finishActions[i] = v
			end
		elseif v > 0 then
			this.mapPOD.finishActions[i] = v
		end
	end

	if componentId and componentId ~= 0 then
		local actor = HomeModule.GetRoomComponentWithId(componentId)

		if actor then
			EventDispatcher.Dispatch(EventID.MainUI_HideNpcTagEvent, actor:GetTagMountPoint())
		end
	end
end

function this.ChangeMapTimeSpanResult()
	return
end

function this.NotifyMapTimeSpan(timeSpan)
	this.mapPOD.timeSpan = timeSpan

	EventDispatcher.Dispatch(EventID.WorldMapRPG_NotifyTimeChangeEvent)
	EventDispatcher.Dispatch(EventID.CommonDialogControl_OnActionComplete, Constant.CommonDialogActionType.SwitchTime)
	log("NotifyMapTimeSpan")
end

function this.NotifySceneMapInfo(info)
	this.mapPOD.info = info
end
