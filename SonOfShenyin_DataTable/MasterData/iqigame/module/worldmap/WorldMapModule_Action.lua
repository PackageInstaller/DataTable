-- chunkname: @IQIGame\\Module\\WorldMap\\WorldMapModule_Action.lua

local this = WorldMapModule

function this.RPGActionTrigger(ActionType, ActionParam, actionCid)
	if not ActionType then
		return
	end

	if ActionType == Constant.WorldRoomActionType.EnterRoom then
		local x = tonumber(ActionParam[2])
		local y = tonumber(ActionParam[3])
		local z = tonumber(ActionParam[4])
		local pos

		if x and y and z then
			pos = Vector3.New(x, y, z)
		end

		this.EnterRoom(ActionParam[1], true, pos and WorldMapModule.PackingEnterRoomData(pos) or "")
	elseif ActionType == Constant.WorldRoomActionType.GetTask then
		TaskSystemModule.ObtainTask(ActionParam[1])
	elseif ActionType == Constant.WorldRoomActionType.EnterStory then
		this._EnterStoryAction(ActionParam)
	elseif ActionType == Constant.WorldRoomActionType.ShowDialog then
		this._ShowDialogAction(ActionParam)
	elseif ActionType == Constant.WorldRoomActionType.RoomTransport then
		this._RoomTransportSelect(ActionParam)
	elseif ActionType == Constant.WorldRoomActionType.SwitchTime then
		this.ChangeMapTimeSpan(tonumber(ActionParam[1]))
	elseif ActionType == Constant.WorldRoomActionType.RandomSelectAction then
		this._RandomSelectActionTrigger(ActionParam)
	elseif ActionType == Constant.WorldRoomActionType.DailyHunt then
		this.Hunt(ActionParam)
	elseif ActionType == Constant.WorldRoomActionType.OpenHuntUI then
		this.OpenHuntUI(ActionParam)
	end
end

function this.OpenHuntUI()
	UIModule.Open(Constant.UIControllerName.WorldDailyHuntUI, Constant.UILayer.UI)
end

function this.Hunt(ActionParam)
	local userData = {}

	userData.OpenType = 2
	userData.ChapterType = Constant.ChapterPassType.Type_RPGHunt
	userData.StageId = tonumber(ActionParam[1])

	function userData.startFunction()
		local agentSkill = FormationModule.FormationDataList[FormationModule.TeamIndex].agentSkill
		local util = FormationModule.CreateFightData()

		net_crusadeDup.enterDup(tonumber(ActionParam[1]), util, agentSkill)
	end

	UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
end

function this._OpenBox(ActionParam)
	local componentId = tonumber(ActionParam[1])
	local box = HomeModule.GetRoomComponentWithId(componentId)

	if not box then
		logError("【RPG】开启宝箱错误，没有找到目标组件id = " .. componentId)

		return
	end

	coroutine.start(function()
		box:PlayAnimation("open", false)
		coroutine.wait(2)
		net_sceneMap.openBox(componentId)
	end)
end

function this._RandomSelectActionTrigger(ActionParam)
	local len = #ActionParam
	local selectIndex = math.random(1, len)
	local selectActionId = ActionParam[selectIndex]
	local actionData = this.GetComponentActionDataWithId(selectActionId)

	this.TriggerAction(actionData.cid, this.GetActionScheduleWithType(actionData:GetCfg().ActionType))
end

function this._RoomTransportSelect(ActionParam)
	local len = #ActionParam

	if not ActionParam or len <= 0 then
		return
	end

	EventDispatcher.Dispatch(EventID.MainUI_ShowRoomSelectEvent, ActionParam)
end

function this._EnterStoryAction(ActionParam)
	if ActionParam[1] == Constant.ChapterPassType.TYPE_MAINLINE then
		StoryChapterModule.EnterDup(ActionParam[2])
	end
end

function this._ShowDialogAction(ActionParam)
	local componentId = tonumber(ActionParam[1])
	local actor = HomeModule.homeScene.room:GetComponentWithId(componentId)

	if not actor then
		logError("【RPG】显示对话行为组件id = " .. componentId .. "没有找到")

		return
	end

	local args = {}

	args.isFilterPos = false

	if componentId == 0 then
		-- block empty
	else
		local cfgComponent = CfgUtil.GetCfgWorldRoomCompDataWithID(actor:GetComponentId())

		if cfgComponent.Type == Constant.RoomComponentsType.Role then
			args.isFilterPos = true
		end
	end

	args.actor = actor
	args.dialogId = tonumber(ActionParam[2])

	actor:StartTalk(args)
end

function this.GetComponentActionAndTrigger(componentId)
	local componentData = WorldMapModule.GetComponentDataWithId(componentId)
	local canActActionList = {}

	for _, v in pairs(componentData.actionList) do
		if v:CheckCanAct() and not v:GetCfg().OptionListIsHide then
			table.insert(canActActionList, v)
		end
	end

	local len = #canActActionList

	if len == 0 then
		logError("【RPG】组件 id = " .. componentId .. "没有找到可以触发的行为")

		return
	end

	if len == 1 then
		this.TriggerAction(canActActionList[1].cid, this.GetActionScheduleWithType(canActActionList[1]:GetCfg().ActionType))

		return
	end

	local actor = HomeModule.GetRoomComponentWithId(componentData.cid)
	local actionDataList = {}

	for i = 1, len do
		local actionData = {}

		actionData.textDesc = canActActionList[i]:GetCfg().ActionName
		actionData.actionType = canActActionList[i]:GetCfg().ActionType
		actionData.actionParam = canActActionList[i]:GetCfg().ActionParam
		actionData.iconType = canActActionList[i]:GetCfg().IconType

		table.insert(actionDataList, actionData)
	end

	table.sort(actionDataList, function(a, b)
		return a.iconType < b.iconType
	end)

	local userData = {}

	userData.DialogType = Constant.CommonDialogPanelType.DialogSelect
	userData.mountPoint = actor:GetSelectMountPoint()
	userData.headText = componentData:GetCfg().Name
	userData.actionList = actionDataList

	function userData.clickCallBack(actionType, actionParam)
		WorldMapModule.RPGActionTrigger(actionType, actionParam)
	end

	UIModule.OpenCommonDialogPanel(userData)
end

function this.GetPassivelyActionAndTrigger(componentId)
	local componentData = WorldMapModule.GetComponentDataWithId(componentId)
	local actAction

	for _, v in pairs(componentData.actionList) do
		if v:CheckCanAct() and v:GetCfg().TriggerType == Constant.RPGActionTriggerType.Passively then
			actAction = v

			break
		end
	end

	if not actAction then
		return false
	end

	this.TriggerAction(actAction.cid, this.GetActionScheduleWithType(actAction:GetCfg().ActionType))

	return true
end

function this.CheckUnInterActAction(componentId)
	local componentData = WorldMapModule.GetComponentDataWithId(componentId)
	local actionList = componentData:GetActionList()

	for _, v in pairs(actionList) do
		if v:GetCfg().ActionType == Constant.WorldRoomActionType.BanNpcNameShow and v:CheckCanAct() and not WorldMapModule.GetActionIsFinished(v.cid) then
			return true
		end
	end

	return false
end

function this.GetActionScheduleWithType(actionType)
	if actionType == Constant.WorldRoomActionType.ShowDialog then
		return 1
	end

	return 0
end

function this.GetActionIsFinished(actionId)
	if not this.mapPOD.finishActions[actionId] then
		return false
	end

	return this.mapPOD.finishActions[actionId] >= 1
end

function this.GetActionFinishedCount(actionId)
	if not this.mapPOD.finishActions[actionId] then
		return 0
	end

	return this.mapPOD.finishActions[actionId]
end

function this.GetMainTagRoomId()
	for _, v in pairs(this.componentsActionDataList) do
		if v:CheckCanAct() and v:GetCfg().IconType == Constant.RPGTagType.MainTag and not WorldMapModule.GetActionIsFinished(v.cid) then
			return v:GetRoomId()
		end
	end
end

function this.GetAreaHaveActiveAction(areaId)
	local areaData = this.GetAreaDataWithID(areaId)

	if not areaData then
		logError("【RPG】获取区域可触发行为报错，没有找到区域id = " .. areaId)

		return
	end

	for _, roomData in pairs(areaData:GetUnlockRoomArray()) do
		for _, componentData in pairs(roomData:GetComponentsList()) do
			for _, actionData in pairs(componentData:GetActionList()) do
				if actionData:CheckCanAct() and not WorldMapModule.GetActionIsFinished(actionData.cid) and not actionData:GetCfg().IsNotCalcuate then
					return true
				end
			end
		end
	end

	return false
end

function this.OnActorInteractPlayer(actor)
	EventDispatcher.Dispatch(EventID.MainUI_HideNpcTagEvent, actor:GetTagMountPoint())

	if this.GetPassivelyActionAndTrigger(actor:GetComponentId()) then
		return
	end

	if not this.enabledNpcNameShow then
		return
	end

	if this.CheckUnInterActAction(actor:GetComponentId()) then
		return
	end

	local componentData = this.GetComponentDataWithId(actor:GetComponentId())

	if componentData and componentData:GetActionCount() <= 0 then
		return
	end

	EventDispatcher.Dispatch(EventID.MainUI_ShowNpcNameEvent, actor:GetNameMountPoint(), actor:GetName(), actor:GetComponentId())
end

function this.OnACtorDisInteractPlayer(actor)
	EventDispatcher.Dispatch(EventID.MainUI_HideNpcNameEvent, actor:GetNameMountPoint())
	actor.controller:InitAction()
end

function this.GetActionByTaskId(taskId)
	for _, v in pairs(this.componentsActionDataList) do
		if v:GetCfg().MainTaskId == taskId and v:CheckCanAct() and not this.GetActionIsFinished(v.cid) then
			return v
		end
	end
end

function this.LockControlByActionStart(actionId)
	if this.lockControlAction then
		return
	end

	this.lockControlAction = actionId

	EventDispatcher.Dispatch(EventID.MainUI_SetRayCastEnabledEvent, false)
	EventDispatcher.Dispatch(EventID.MainUI_HideHudPanelEvent)
end

function this.UnlockControlByActionEnd(actionId)
	if not this.lockControlAction then
		return
	end

	if this.lockControlAction ~= actionId then
		return
	end

	this.lockControlAction = nil

	EventDispatcher.Dispatch(EventID.MainUI_SetRayCastEnabledEvent, true)
	EventDispatcher.Dispatch(EventID.MainUI_ShowHudPanelEvent)
end

function this.CheckNot2ServerAction(actionData)
	if actionData:GetCfg().ActionType == Constant.WorldRoomActionType.RandomSelectAction or actionData:GetCfg().ActionType == Constant.WorldRoomActionType.RoomTransport then
		return true
	end

	return false
end

function this.SpecialActionTrigger(actionData, schedule)
	if actionData:GetCfg().ActionType == Constant.WorldRoomActionType.OpenBox then
		local box = HomeModule.GetRoomComponentWithId(actionData.compCid)

		if not box then
			logError("【RPG】开启宝箱错误，没有找到目标组件id = " .. actionData.compCid)

			return true
		end

		coroutine.start(function()
			box:PlayAnimation("open", false)
			coroutine.wait(2)
			net_sceneMap.triggerAction(actionData.cid, schedule, "")
		end)

		return true
	elseif actionData:GetCfg().ActionType == Constant.WorldRoomActionType.Wish then
		NoticeModule.ShowNotice(20041, function()
			net_sceneMap.triggerAction(actionData.cid, schedule, "")
		end)

		return true
	end
end

function this.TriggerDailyAction(actionId, invite)
	local actionData = WorldMapModule.GetComponentActionDataWithId(actionId)

	if actionData:GetCfg().ActionType == Constant.WorldRoomActionType.DailyEater then
		UIModule.Open(Constant.UIControllerName.WorldDailyUI, Constant.UILayer.UI, {
			actionId = actionId,
			invite = invite
		})
	elseif actionData:GetCfg().ActionType == Constant.WorldRoomActionType.DailyLottery then
		UIModule.Open(Constant.UIControllerName.WorldDailyLotteryUI, Constant.UILayer.UI, {
			actionId = actionId
		})
	elseif actionData:GetCfg().ActionType == Constant.WorldRoomActionType.DailyNonUI then
		this.TriggerAction(actionId, 0, "")
	end
end

function this.GetFoodIsRoleFavor(actionId, invite)
	local favor = false
	local actionData = WorldMapModule.GetComponentActionDataWithId(actionId)

	for i = 1, #actionData:GetCfg().InviteSpecialHero do
		if actionData:GetCfg().InviteSpecialHero[i] == invite then
			favor = true

			break
		end
	end

	return favor
end

function this.DebugFinishedAction()
	local str = "【RPG】完成行为 = "

	for i, v in pairs(this.mapPOD.finishActions) do
		str = str .. string.format(" --%s-- ", i)
	end

	log(str)
end

function this.DebugActorInfo(actorCid)
	local componentData = this.GetComponentDataWithId(actorCid)

	if not componentData then
		return
	end

	log(string.format("【RPG】组件id = %s,组件状态 = %s, 客户端解锁状态 = %s", componentData.cid, componentData.status, componentData:GetActive()))

	for i, v in pairs(componentData:GetActionList()) do
		log(string.format("【RPG】组件id = %s,行为 id = %s,行为tag = %s,完成次数 = %s,状态 = %s,行为状态 = %s", v.compCid, v.cid, v:GetCfg().IconType, this.GetActionFinishedCount(v.cid), v.status, v:CheckCanAct()))
	end
end
