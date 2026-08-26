-- chunkname: @modules/logic/pcInput/PCInputController.lua

module("modules.logic.pcInput.PCInputController", package.seeall)

local PCInputController = class("PCInputController", BaseController)

function PCInputController:onInit()
	self.Adapters = self.Adapters or {}
	self.eventMgr = ZProj.GamepadEvent

	self.eventMgr.Instance:AddLuaLisenter(self.eventMgr.UpKey, self.OnKeyUp, self)
	self.eventMgr.Instance:AddLuaLisenter(self.eventMgr.DownKey, self.OnKeyDown, self)

	self.inputInst = ZProj.PCInputManager.Instance
	self.init = not not self:getIsUse()

	logNormal("PCInputController:onInit()" .. tostring(self.init))
end

function PCInputController:PauseListen()
	self._pauseListen = true
end

function PCInputController:resumeListen()
	self._pauseListen = false
end

function PCInputController:getIsUse()
	if BootNativeUtil.isMuMu then
		local ismumu = BootNativeUtil.isMuMu()

		if ZProj.PCInputManager and (BootNativeUtil.isWindows() or BootNativeUtil.isMuMu) then
			if UnityEngine.Application.isEditor then
				return UnityEngine.PlayerPrefs.GetInt("PCInputSwitch", 0) == 1
			else
				return true
			end
		end

		return false
	end
end

function PCInputController:Switch()
	self.init = self:getIsUse()
end

function PCInputController:getCurrentPresskey()
	if self.init then
		return self.inputInst:getCurrentPresskey()
	end

	return nil
end

function PCInputController:onInitFinish()
	return
end

function PCInputController:reInit()
	return
end

function PCInputController:addConstEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenViewCallBack, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseViewCallBack, self)
end

function PCInputController:onOpenViewCallBack(viewName)
	TaskDispatcher.runDelay(function()
		if viewName == ViewName.MainView then
			if self.Adapters[PCInputModel.Activity.MainActivity] == nil then
				self.Adapters[PCInputModel.Activity.MainActivity] = MainActivityAdapter.New()
			end
		elseif viewName == ViewName.ExploreView then
			if self.Adapters[PCInputModel.Activity.thrityDoor] == nil then
				self.Adapters[PCInputModel.Activity.thrityDoor] = ThirdDoorActivtiyAdapter.New()
			end
		elseif viewName == ViewName.FightView then
			if self.Adapters[PCInputModel.Activity.battle] == nil then
				self.Adapters[PCInputModel.Activity.battle] = BattleActivityAdapter.New()
			end
		elseif viewName == ViewName.RoomView then
			if self.Adapters[PCInputModel.Activity.room] == nil then
				self.Adapters[PCInputModel.Activity.room] = RoomActivityAdapter.New()
			end
		elseif viewName == ViewName.WeekWalkDialogView or viewName == ViewName.StoryFrontView or viewName == ViewName.ExploreInteractView or viewName == ViewName.RoomBranchView or viewName.StoryBranchView then
			if self.Adapters[PCInputModel.Activity.storyDialog] == nil then
				self.Adapters[PCInputModel.Activity.storyDialog] = StoryDialogAdapter.New()
			end
		elseif (viewName == ViewName.MessageBoxView or viewName == ViewName.TopMessageBoxView or viewName == ViewName.SDKExitGameView or viewName == ViewName.FightQuitTipView or viewName == ViewName.FixResTipView) and self.Adapters[PCInputModel.Activity.CommonDialog] == nil then
			self.Adapters[PCInputModel.Activity.CommonDialog] = CommonActivityAdapter.New()
		end
	end, self, 0.01)
end

function PCInputController:onCloseViewCallBack(viewName)
	TaskDispatcher.runDelay(function()
		if viewName == ViewName.MainView then
			self:_removeAdapter(PCInputModel.Activity.MainActivity)
		elseif viewName == ViewName.ExploreView then
			self:_removeAdapter(PCInputModel.Activity.thrityDoor)
		elseif viewName == ViewName.FightView then
			self:_removeAdapter(PCInputModel.Activity.battle)
		elseif viewName == ViewName.RoomView then
			self:_removeAdapter(PCInputModel.Activity.room)
		elseif viewName == ViewName.WeekWalkDialogView or viewName == ViewName.StoryFrontView or viewName == ViewName.ExploreInteractView or viewName == ViewName.RoomBranchView or viewName.StoryBranchView then
			self:_removeAdapter(PCInputModel.Activity.storyDialog)
		elseif viewName == ViewName.MessageBoxView or viewName == ViewName.TopMessageBoxView or viewName == ViewName.SDKExitGameView or viewName == ViewName.FightQuitTipView then
			self:_removeAdapter(PCInputModel.Activity.CommonDialog)
		elseif viewName == ViewName.SettingsView then
			self:ReRegisterKeys()
		end
	end, self, 0.01)
end

function PCInputController:ReRegisterKeys()
	for _, v in pairs(self.Adapters) do
		if v then
			v:unRegisterFunction()
			v:registerFunction()
		end
	end
end

function PCInputController:_removeAdapter(activityid)
	local adapter = self.Adapters[activityid]

	if adapter then
		self.Adapters[activityid]:destroy()

		self.Adapters[activityid] = nil
	end
end

function PCInputController:registerKey(key, keyEvent)
	if key and self.inputInst then
		self.inputInst:RegisterKey(key, keyEvent)
	end
end

function PCInputController:unregisterKey(key, keyEvent)
	if key and self.inputInst then
		self.inputInst:UnregisterKey(key, keyEvent)
	end
end

function PCInputController:registerKeys(keys, keyEvent)
	if keys and self.inputInst then
		for _, v in pairs(keys) do
			if v then
				self.inputInst:RegisterKey(v, keyEvent)
			end
		end
	end
end

function PCInputController:unregisterKeys(keys, keyEvent)
	if keys and self.inputInst then
		for _, v in pairs(keys) do
			if v then
				self.inputInst:UnregisterKey(v, keyEvent)
			end
		end
	end
end

function PCInputController:getKeyPress(key)
	if self.init and self.inputInst and not GuideController.instance:isAnyGuideRunning() then
		return self.inputInst:getKeyPress(key)
	end

	return false
end

function PCInputController:getActivityFunPress(activityid, funid)
	local keys = PCInputModel.instance:getActivityKeys(activityid)

	if keys then
		local key = keys[funid]

		if key then
			return self:getKeyPress(key[4])
		else
			return false
		end
	end

	return false
end

function PCInputController:OnKeyDown(key)
	if not self.init or not self.inputInst or self._pauseListen then
		return
	end

	if GuideController.instance:isAnyGuideRunning() then
		return
	end

	local keyName = self.inputInst:keyCodeToKey(key)
	local adaptersList = {}

	for _, v in pairs(self.Adapters) do
		table.insert(adaptersList, v)
	end

	table.sort(adaptersList, function(a, b)
		return a:getPriorty() > b:getPriorty()
	end)

	for _, v in ipairs(adaptersList) do
		if v and v:OnkeyDown(keyName) then
			return
		end
	end
end

function PCInputController:OnKeyUp(key)
	if not self.init or not self.inputInst or self._pauseListen then
		return
	end

	if GuideController.instance:isAnyGuideRunning() then
		return
	end

	local keyName = self.inputInst:keyCodeToKey(key)
	local adaptersList = {}

	for _, v in pairs(self.Adapters) do
		table.insert(adaptersList, v)
	end

	table.sort(adaptersList, function(a, b)
		return a:getPriorty() > b:getPriorty()
	end)

	for _, v in ipairs(adaptersList) do
		if v and v:OnkeyUp(keyName) then
			return
		end
	end
end

function PCInputController:getThirdMoveKey()
	return PCInputModel.instance:getThirdDoorMoveKey()
end

function PCInputController:getKeyMap()
	local keys = PCInputModel.instance:getKeyBinding()

	return LuaUtil.deepCopy(keys)
end

function PCInputController:saveKeyMap(keys)
	PCInputModel.instance:Save(keys)
end

function PCInputController:showkeyTips(go, activityId, keyid, keyName)
	if go == nil or not self.init then
		return
	end

	local tipsview = MonoHelper.addLuaComOnceToGo(go, keyTipsView, {
		keyname = keyName,
		activityId = activityId,
		keyid = keyid
	})

	if not keyName then
		tipsview:Refresh(activityId, keyid)
	else
		tipsview:RefreshByKeyName(keyName)
	end

	return tipsview
end

function PCInputController:KeyNameToDescName(keyname)
	return PCInputModel.instance:ReplaceKeyName(keyname)
end

function PCInputController:isPopUpViewOpen(exludeViewList)
	local viewList = ViewMgr.instance:getOpenViewNameList()

	for i = #viewList, 1, -1 do
		local viewName = viewList[i]
		local setting = ViewMgr.instance:getSetting(viewName)

		if (setting.layer == UILayerName.PopUpTop or setting.layer == UILayerName.PopUp or setting.layer == UILayerName.Guide) and not self:viewInList(viewName, exludeViewList) then
			return true
		end
	end

	return false
end

function PCInputController:viewInList(viewName, viewList)
	for _, v in pairs(viewList) do
		if v == viewName then
			return true
		end
	end

	return false
end

PCInputController.instance = PCInputController.New()

return PCInputController
