-- chunkname: @IQIGame\\UI\\Dialog\\CommonDialogController.lua

local CommonDialogController = {}

function CommonDialogController.New()
	local o = Clone(CommonDialogController)

	o:Initialize()

	return o
end

function CommonDialogController:Initialize()
	self:InitDelegate()
	self:AddEventListener()

	self.executeActionQueue = {}
	self.showDialogList = {}
	self.timer = ModuleTimerUtil.NewFrameTimer(Constant.ModuleTimerName.DialogControlTimer, self.upDateEvent, 1, -1)

	self.timer:Start()
end

function CommonDialogController:InitDelegate()
	function self.onActionCompleteEvent(actionType)
		self:OnActionComplete(actionType)
	end

	function self.onDialogShowOverEvent(mountPoint)
		self:_OnDialogShowOver(mountPoint)
	end

	function self.onStandPaintDialogShowOverEvent()
		self:_OnStandPaintDialogShowOver()
	end

	function self.upDateEvent()
		self:Update()
	end

	function self.onSkipEvent()
		self:Skip()
	end

	function self.clearEvent()
		self:Clear()
	end
end

function CommonDialogController:AddEventListener()
	EventDispatcher.AddEventListener(EventID.CommonDialogPanel_OnBubbleShowComplete, self.onDialogShowOverEvent)
	EventDispatcher.AddEventListener(EventID.CommonDialogPanel_OnStandPaintShowComplete, self.onStandPaintDialogShowOverEvent)
	EventDispatcher.AddEventListener(EventID.CommonDialogControl_OnActionComplete, self.onActionCompleteEvent)
	EventDispatcher.AddEventListener(EventID.CommonDialogControl_SkipEvent, self.onSkipEvent)
	EventDispatcher.AddEventListener(EventID.CommonDialogControl_ClearEvent, self.clearEvent)
end

function CommonDialogController:RemoveEventListener()
	EventDispatcher.RemoveEventListener(EventID.CommonDialogPanel_OnBubbleShowComplete, self.onDialogShowOverEvent)
	EventDispatcher.RemoveEventListener(EventID.CommonDialogPanel_OnStandPaintShowComplete, self.onStandPaintDialogShowOverEvent)
	EventDispatcher.RemoveEventListener(EventID.CommonDialogControl_OnActionComplete, self.onActionCompleteEvent)
	EventDispatcher.RemoveEventListener(EventID.CommonDialogControl_SkipEvent, self.onSkipEvent)
	EventDispatcher.RemoveEventListener(EventID.CommonDialogControl_ClearEvent, self.clearEvent)
end

function CommonDialogController:Clear()
	self.executeActionQueue = {}
	self.showDialogList = {}

	UIModule.Close(Constant.UIControllerName.CommonDialogPanel)
end

function CommonDialogController:OnActionComplete(actionType)
	if not self.currentExecuteAction then
		return
	end

	if self.currentExecuteAction:GetActionType() ~= actionType then
		return
	end

	self.currentExecuteAction.isComplete = true
end

function CommonDialogController:RegisterActionCallBack(func)
	self.actionSelectCallBackFunc = func
end

function CommonDialogController:ShowDialogAction(actorId, dialogId, cfgType)
	local param = {}

	param.cfgType = cfgType
	param.dialogueController = self

	local action = CommonDialogueActionUtil.CreateAction(Constant.WorldRoomActionType.ShowDialog, {
		actorId,
		dialogId
	}, param)

	table.insert(self.executeActionQueue, action)
end

function CommonDialogController:ShowDialog(params)
	local dialogueId = params.dialogueId
	local mountPoint = params.mountPoint
	local nameString = params.nameString

	if LuaUtility.GameObjectIsNullOrEmpty(mountPoint) then
		logError(string.format("【RPG】显示对话行为错误，对话 id = %s,角色id = %s没有对话挂点，请策划检查。", dialogueId, params.roleId))

		return
	end

	local instanceId = LuaUtility.GetGameObjectInstanceID(mountPoint)

	if not params.cfgType then
		logError("【公共对话】请指定对话id = " .. dialogueId .. "的对话配置类型")

		return
	end

	local cfgDialogue = self:_GetDialogCfg(params.cfgType, dialogueId)
	local len = #cfgDialogue.ActionType

	for i = 1, len do
		if cfgDialogue.ActionType[i] ~= 0 then
			self:AddActionOnActionQueue(cfgDialogue.ActionType[i], cfgDialogue.ActionParam[i], params.cfgType)
		end
	end

	local showDialogData = {}

	showDialogData.dialogueId = dialogueId
	showDialogData.cfgType = params.cfgType
	showDialogData.mountPoint = mountPoint
	showDialogData.instanceId = instanceId
	showDialogData.roleId = params.roleId

	table.insert(self.showDialogList, showDialogData)

	if cfgDialogue.DialogType == Constant.CommonDialogPanelType.Bubble then
		local strContent = self:_GetTextWithSex(cfgDialogue)
		local userData = {}

		userData.DialogType = cfgDialogue.DialogType
		userData.mountPoint = mountPoint
		userData.name = nameString
		userData.text = strContent
		userData.duration = cfgDialogue.StayTime
		userData.showDialogButtons = true
		userData.pictureId = cfgDialogue.PictureID

		UIModule.OpenCommonDialogPanel(userData)
	elseif cfgDialogue.DialogType == Constant.CommonDialogPanelType.StandPaint then
		local userData = {}

		userData.DialogType = cfgDialogue.DialogType
		userData.name = nameString
		userData.text = self:_GetTextWithSex(cfgDialogue)
		userData.duration = cfgDialogue.StayTime
		userData.showDialogButtons = true
		userData.pictureId = cfgDialogue.PictureID

		UIModule.OpenCommonDialogPanel(userData)
	else
		logError(string.format("【对话】对话id = %s配置了不存在的对话类型 id = ,请策划检查！！！！", cfgDialogue.Id, cfgDialogue.DialogType))
	end
end

function CommonDialogController:_OnDialogShowOver(mountPoint)
	local instanceId = LuaUtility.GetGameObjectInstanceID(mountPoint)
	local showDialogData = self:_GetShowDialogDataWithInstanceId(instanceId)

	if not showDialogData then
		return
	end

	local cfgDialogue = CfgUtil.GetCfgMainDialogueDataWithID(showDialogData.dialogueId)
	local len = #cfgDialogue.ActionEndType

	for i = 1, len do
		if cfgDialogue.ActionEndType[i] ~= 0 then
			self:AddActionOnActionQueue(cfgDialogue.ActionEndType[i], cfgDialogue.ActionEndParam[i], showDialogData.cfgType)
		end
	end

	self:_RemoveDialogDataWithInstanceId(instanceId)
end

function CommonDialogController:_OnStandPaintDialogShowOver()
	local showDialogData = self:_GetShowDialogDataWithDialogType(Constant.CommonDialogPanelType.StandPaint)

	if not showDialogData then
		return
	end

	local cfgDialogue = CfgUtil.GetCfgMainDialogueDataWithID(showDialogData.dialogueId)
	local len = #cfgDialogue.ActionEndType

	for i = 1, len do
		if cfgDialogue.ActionEndType[i] ~= 0 then
			self:AddActionOnActionQueue(cfgDialogue.ActionEndType[i], cfgDialogue.ActionEndParam[i], showDialogData.cfgType)
		end
	end

	self:_RemoveDialogDataWithDialogType(Constant.CommonDialogPanelType.StandPaint)
end

function CommonDialogController:_GetTextWithSex(cfgDialogue)
	if PlayerModule.GetSex() == Constant.PlayerSex.Man then
		return cfgDialogue.TextMan
	elseif PlayerModule.GetSex() == Constant.PlayerSex.WoMen then
		if LuaUtility.StrIsNullOrEmpty(cfgDialogue.TextWoMan) then
			return cfgDialogue.TextMan
		end

		return cfgDialogue.TextWoMan
	else
		return cfgDialogue.TextMan
	end
end

function CommonDialogController:Update()
	if not self.executeActionQueue then
		return
	end

	if not self.currentExecuteAction then
		local len = #self.executeActionQueue

		if len <= 0 then
			if self.isSkip then
				self.isSkip = false

				BehaviorTreeUtility.PlayBlackInkScreenEffect(2, 0.5)
			end

			return
		end

		self.currentExecuteAction = self.executeActionQueue[1]

		table.remove(self.executeActionQueue, 1)
		self.currentExecuteAction:OnStart()

		if self.currentExecuteAction.args.actionType == Constant.CommonDialogActionType.ShowDialog then
			log(string.format("【RPG】执行对话行为 actionType = %s,对话id  = %s", self.currentExecuteAction.args.actionType, self.currentExecuteAction.args.dialogId))
		else
			log(string.format("【RPG】执行行为 actionType = %s", self.currentExecuteAction.args.actionType))
		end
	end

	if not self.currentExecuteAction then
		return
	end

	if self.isSkip then
		self.currentExecuteAction:OnSkip()

		if self.currentExecuteAction.args.actionType == Constant.CommonDialogActionType.ShowActionSelect or self.currentExecuteAction.args.actionType == Constant.CommonDialogActionType.OpenInteractionUI or self.currentExecuteAction.args.actionType == Constant.CommonDialogActionType.OpenBox then
			self.isSkip = false

			BehaviorTreeUtility.PlayBlackInkScreenEffect(2, 0.5)
		end
	else
		self.currentExecuteAction:OnUpdate()
	end

	local isActionComplete = self.currentExecuteAction:GetIsComplete()

	if isActionComplete then
		log("【RPG】完成行为 actionType =" .. self.currentExecuteAction.args.actionType)
		self.currentExecuteAction:OnDestroy()

		self.currentExecuteAction = nil
	end
end

function CommonDialogController:Skip()
	local len = #self.showDialogList

	for i = 1, len do
		local cfgDialogue = CommonDialogueActionUtil.GetDialogCfgWithCfgType(self.showDialogList[i].cfgType, self.showDialogList[i].dialogueId)

		if cfgDialogue.DialogType == Constant.CommonDialogPanelType.Bubble then
			local actorData = CommonDialogueActionUtil.GetActorDataWithCfgType(self.showDialogList[i].cfgType, self.showDialogList[i].roleId)

			if not actorData then
				return
			end

			EventDispatcher.Dispatch(EventID.CommonDialogPanel_HideBubble, actorData.mountPoint)
		elseif cfgDialogue.DialogType == Constant.CommonDialogPanelType.StandPaint then
			EventDispatcher.Dispatch(EventID.CommonDialogPanel_HideStandPaintEvent)
		end

		local nextDialogId

		for j = 1, #cfgDialogue.ActionEndType do
			if cfgDialogue.ActionEndType[j] == Constant.CommonDialogActionType.ShowDialog then
				nextDialogId = tonumber(cfgDialogue.ActionEndParam[j][2])
			else
				self:AddActionOnActionQueue(cfgDialogue.ActionEndType[j], cfgDialogue.ActionEndParam[j], self.showDialogList[i].cfgType)
			end
		end

		if nextDialogId then
			self:_AddActionRecur(nextDialogId, self.showDialogList[i].cfgType)
		end

		if cfgDialogue.DialogType == Constant.CommonDialogPanelType.Bubble then
			self:_RemoveDialogDataWithInstanceId(self.showDialogList[i].instanceId)
		elseif cfgDialogue.DialogType == Constant.CommonDialogPanelType.StandPaint then
			self:_RemoveDialogDataWithDialogType(Constant.CommonDialogPanelType.StandPaint)
		end
	end

	UIModule.Close(Constant.UIControllerName.CommonDialogPanel)

	self.isSkip = true

	BehaviorTreeUtility.PlayBlackInkScreenEffect(1, 0.5)
end

function CommonDialogController:_AddActionRecur(dialogId, cfgType)
	local cfgDialogue = CommonDialogueActionUtil.GetDialogCfgWithCfgType(cfgType, dialogId)
	local len = #cfgDialogue.ActionType

	for i = 1, len do
		if cfgDialogue.ActionType[i] ~= 0 then
			self:AddActionOnActionQueue(cfgDialogue.ActionType[i], cfgDialogue.ActionParam[i], cfgType)
		end
	end

	local nextId

	len = #cfgDialogue.ActionEndType

	for i = 1, len do
		if cfgDialogue.ActionEndType[i] == Constant.CommonDialogActionType.ShowDialog then
			nextId = tonumber(cfgDialogue.ActionEndParam[i][2])
		elseif cfgDialogue.ActionEndType[i] ~= 0 then
			self:AddActionOnActionQueue(cfgDialogue.ActionEndType[i], cfgDialogue.ActionEndParam[i], cfgType)
		end
	end

	if nextId then
		self:_AddActionRecur(nextId, cfgType)
	end
end

function CommonDialogController:_CheckMountActionAllCompleteWithInstanceId(instanceId)
	local len = #self.executeActionQueue

	for i = 1, len do
		if self.executeActionQueue[i].instanceId == instanceId and not self.executeActionQueue[i].isComplete then
			return false
		end
	end

	return true
end

function CommonDialogController:_CheckMountActionAllCompleteDialogId(dialogId)
	local len = #self.executeActionQueue

	for i = 1, len do
		if self.executeActionQueue[i].dialogueId == dialogId and not self.executeActionQueue[i].isComplete then
			return false
		end
	end

	return true
end

function CommonDialogController:_GetDialogCfg(cfgType, dialogueId)
	local cfgDialogue

	if cfgType == Constant.CommonDialogCfgType.Main then
		cfgDialogue = CfgUtil.GetCfgMainDialogueDataWithID(dialogueId)
	end

	if not cfgDialogue then
		logError("【公共对话】没有找到对话 id = " .. dialogueId .. "的配置")

		return
	end

	return cfgDialogue
end

function CommonDialogController:_GetShowDialogDataWithInstanceId(instanceId)
	local showDialogData
	local count = 0

	for _, v in pairs(self.showDialogList) do
		if v.instanceId == instanceId then
			showDialogData = v
			count = count + 1
		end
	end

	if count > 1 then
		logError(string.format("【对话】警告！！对话错误，同一个instancesId，存在多个显示对话实例。dialogueId = %s,roleId = %s", showDialogData.dialogueId, showDialogData.roleId))
	end

	return showDialogData
end

function CommonDialogController:_RemoveDialogDataWithInstanceId(instanceId)
	for i, v in pairs(self.showDialogList) do
		if v.instanceId == instanceId then
			table.remove(self.showDialogList, i)
		end
	end
end

function CommonDialogController:_GetShowDialogDataWithDialogType(dialogType)
	for _, v in pairs(self.showDialogList) do
		local cfgDialog = self:_GetDialogCfg(v.cfgType, v.dialogueId)

		if cfgDialog and cfgDialog.DialogType == dialogType then
			return v
		end
	end
end

function CommonDialogController:_RemoveDialogDataWithDialogType(dialogType)
	for i, v in pairs(self.showDialogList) do
		local cfgDialog = self:_GetDialogCfg(v.cfgType, v.dialogueId)

		if cfgDialog and cfgDialog.DialogType == dialogType then
			table.remove(self.showDialogList, i)
		end
	end
end

function CommonDialogController:AddActionOnActionQueue(actionType, actionParam, cfgType)
	if actionType == 0 then
		return
	end

	local createParam = {}

	createParam.cfgType = cfgType
	createParam.dialogueController = self
	createParam.clickCallBack = self.actionSelectCallBackFunc

	local action = CommonDialogueActionUtil.CreateAction(actionType, actionParam, createParam)

	table.insert(self.executeActionQueue, action)
end

function CommonDialogController:OnDestroy()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.currentExecuteAction = nil

	self:RemoveEventListener()
end

return CommonDialogController
