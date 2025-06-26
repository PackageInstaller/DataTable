-- chunkname: @IQIGame\\UI\\StoryScreenEffectUI.lua

local StoryScreenEffectUI = {}

StoryScreenEffectUI = Base:Extend("StoryScreenEffectUI", "IQIGame.Onigao.UI.StoryScreenEffectUI", StoryScreenEffectUI)

local property_show = "_chuxian"
local property_hide = "_xiaoshi"
local property_thinking = "_Control"
local animation_In = "AlphaScreenIn"
local animation_Out = "AlphaScreenOut"

function StoryScreenEffectUI:OnInit()
	self:InitComponent()
	self:InitDelegate()
end

function StoryScreenEffectUI:InitComponent()
	self.mat_BlackScreen = self.BlackInkScreen:GetComponent("Image").material
	self.mat_WhiteInkScreen = self.WhiteInkScreen:GetComponent("Image").material
	self.Mat_thinkingEffect = self.thinkingEffect:GetComponent("Image").material
end

function StoryScreenEffectUI:InitDelegate()
	function self.BlackInkInDelegate(PlayEffect, withNoTime)
		self:BlackInkIn(PlayEffect, withNoTime)
	end

	function self.BlackInkOutDelegate(PlayEffect, withNoTime)
		self:BlackInkOut(PlayEffect, withNoTime)
	end

	function self.WhiteInkInDelegate(PlayEffect, withNoTime)
		self:WhiteInkIn(PlayEffect, withNoTime)
	end

	function self.WhiteInkOutDelegate(PlayEffect, withNoTime)
		self:WhiteInkOut(PlayEffect, withNoTime)
	end

	function self.BlackAlphaInDelegate(PlayEffect)
		self:BlackAlphaIn(PlayEffect)
	end

	function self.BlackAlphaOutDelegate(PlayEffect)
		self:BlackAlphaOut(PlayEffect)
	end

	function self.WhiteAlphaInDelegate(PlayEffect)
		self:WhiteAlphaIn(PlayEffect)
	end

	function self.WhiteAlphaOutDelegate(PlayEffect)
		self:WhiteAlphaOut(PlayEffect)
	end

	function self.playScreenEffectWithTypeDelegate(type, task)
		self:PlayEffectWithType(type, task)
	end

	function self.stopScreenEffectWithTypeDelegate(type, task)
		self:StopEffectWithType(type, task)
	end
end

function StoryScreenEffectUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.StoryBlackInkIn, self.BlackInkInDelegate)
	EventDispatcher.AddEventListener(EventID.StoryBlackInkOut, self.BlackInkOutDelegate)
	EventDispatcher.AddEventListener(EventID.StoryWhiteInkIn, self.WhiteInkInDelegate)
	EventDispatcher.AddEventListener(EventID.StoryWhiteInkOut, self.WhiteInkOutDelegate)
	EventDispatcher.AddEventListener(EventID.StoryBlackAlphaIn, self.BlackAlphaInDelegate)
	EventDispatcher.AddEventListener(EventID.StoryBlackAlphaOut, self.BlackAlphaOutDelegate)
	EventDispatcher.AddEventListener(EventID.StoryWhiteAlphaIn, self.WhiteAlphaInDelegate)
	EventDispatcher.AddEventListener(EventID.StoryWhiteAlphaOut, self.WhiteAlphaOutDelegate)
	EventDispatcher.AddEventListener(EventID.StoryScreenPlayScreenEffectWithType, self.playScreenEffectWithTypeDelegate)
	EventDispatcher.AddEventListener(EventID.StoryScreenStopScreenEffectWithType, self.stopScreenEffectWithTypeDelegate)
	EventUtil.AddEventListener(self, EventID.StoryCutTo)
	UIEventUtil.AddClickEventListener_Button(self, "RepairBtn", self.__OnRepairBtnClick)
end

function StoryScreenEffectUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.StoryBlackInkIn, self.BlackInkInDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryBlackInkOut, self.BlackInkOutDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryWhiteInkIn, self.WhiteInkInDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryWhiteInkOut, self.WhiteInkOutDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryBlackAlphaIn, self.BlackAlphaInDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryBlackAlphaOut, self.BlackAlphaOutDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryWhiteAlphaIn, self.WhiteAlphaInDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryWhiteAlphaOut, self.WhiteAlphaOutDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryScreenPlayScreenEffectWithType, self.playScreenEffectWithTypeDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryScreenStopScreenEffectWithType, self.stopScreenEffectWithTypeDelegate)
	EventUtil.ClearEventListener(self)
	UIEventUtil.ClearEventListener(self)
end

function StoryScreenEffectUI:__OnStoryCutToHandler()
	LuaUtility.SetGameObjectShow(self.storyCutTo, false)
	LuaUtility.SetGameObjectShow(self.storyCutTo, true)
	coroutine.start(function()
		coroutine.wait(2)
		LuaUtility.SetGameObjectShow(self.storyCutTo, false)
	end)
end

function StoryScreenEffectUI:OnOpen(userData)
	self.RepairBtn.gameObject:SetActive(false)

	if userData and userData.event then
		userData.event()
	end
end

function StoryScreenEffectUI:OnClose(userData)
	LuaUtility.SetGameObjectShow(self.thinkingEffect, false)
	LuaUtility.SetGameObjectShow(self.BlackInkScreen, false)
	LuaUtility.SetGameObjectShow(self.WhiteInkScreen, false)
	LuaUtility.SetGameObjectShow(self.BlackAlphaScreen, false)
	LuaUtility.SetGameObjectShow(self.WhiteAlphaScreen, false)
	LuaUtility.SetGameObjectShow(self.storyCutTo, false)
	self:__StopRepairBtnTimer()
end

function StoryScreenEffectUI:OnDestroy()
	self:__StopRepairBtnTimer()
end

function StoryScreenEffectUI:GetPreloadAssetPaths()
	return nil
end

function StoryScreenEffectUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function StoryScreenEffectUI:IsManualShowOnOpen(userData)
	return false
end

function StoryScreenEffectUI:GetBGM(userData)
	return nil
end

function StoryScreenEffectUI:OnPause()
	return
end

function StoryScreenEffectUI:OnResume()
	return
end

function StoryScreenEffectUI:OnCover()
	return
end

function StoryScreenEffectUI:OnReveal()
	return
end

function StoryScreenEffectUI:OnRefocus(userData)
	return
end

function StoryScreenEffectUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.isPlayingBlackScreen then
		self:OnBlackScreenUpdate()
	end
end

function StoryScreenEffectUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function StoryScreenEffectUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function StoryScreenEffectUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function StoryScreenEffectUI:BlackInkIn(PlayEffect, withNoTime)
	self:__OnSetStoryRepairBtnActive(true)

	if withNoTime then
		LuaUtility.SetGameObjectShow(self.BlackInkScreen, true)
		self.mat_BlackScreen:SetFloat(property_show, 10)
		self.mat_BlackScreen:SetFloat(property_hide, 0)

		self.currentActionType = Constant.StoryScreenEffectType.BlackInkIn

		if PlayEffect then
			PlayEffect:LoadSucceed()
		end

		return
	end

	LuaUtility.SetGameObjectShow(self.BlackInkScreen, true)
	self.mat_BlackScreen:SetFloat(property_show, 0)
	self.mat_BlackScreen:SetFloat(property_hide, 0)

	self.dTime = Time.time
	self.currentActionType = Constant.StoryScreenEffectType.BlackInkIn
	self.isPlayingBlackScreen = true

	self:_SetNewStoryEffectTask(PlayEffect)
end

function StoryScreenEffectUI:BlackInkOut(PlayEffect, withNoTime)
	self:__OnSetStoryRepairBtnActive(false)

	if withNoTime then
		LuaUtility.SetGameObjectShow(self.BlackInkScreen, false)

		self.currentActionType = Constant.StoryScreenEffectType.BlackInkOut

		if PlayEffect then
			PlayEffect:LoadSucceed()
		end

		return
	end

	LuaUtility.SetGameObjectShow(self.BlackInkScreen, true)
	self.mat_BlackScreen:SetFloat(property_show, 10)
	self.mat_BlackScreen:SetFloat(property_hide, 0)

	self.dTime = Time.time
	self.currentActionType = Constant.StoryScreenEffectType.BlackInkOut
	self.isPlayingBlackScreen = true

	self:_SetNewStoryEffectTask(PlayEffect)
end

function StoryScreenEffectUI:WhiteInkIn(PlayEffect, withNoTime)
	self:__OnSetStoryRepairBtnActive(true)

	if withNoTime then
		LuaUtility.SetGameObjectShow(self.WhiteInkScreen, true)
		self.mat_BlackScreen:SetFloat(property_show, 10)
		self.mat_BlackScreen:SetFloat(property_hide, 0)

		self.currentActionType = Constant.StoryScreenEffectType.WhiteInkIn

		if PlayEffect then
			PlayEffect:LoadSucceed()
		end

		return
	end

	LuaUtility.SetGameObjectShow(self.WhiteInkScreen, true)
	self.mat_WhiteInkScreen:SetFloat(property_show, 0)
	self.mat_WhiteInkScreen:SetFloat(property_hide, 0)

	self.dTime = Time.time
	self.currentActionType = Constant.StoryScreenEffectType.WhiteInkIn
	self.isPlayingBlackScreen = true

	self:_SetNewStoryEffectTask(PlayEffect)
end

function StoryScreenEffectUI:WhiteInkOut(PlayEffect, withNoTime)
	self:__OnSetStoryRepairBtnActive(false)

	if withNoTime then
		LuaUtility.SetGameObjectShow(self.BlackInkScreen, false)

		self.currentActionType = Constant.StoryScreenEffectType.WhiteInkOut

		if PlayEffect then
			PlayEffect:LoadSucceed()
		end

		return
	end

	LuaUtility.SetGameObjectShow(self.WhiteInkScreen, true)
	self.mat_WhiteInkScreen:SetFloat(property_show, 10)
	self.mat_WhiteInkScreen:SetFloat(property_hide, 0)

	self.dTime = Time.time
	self.currentActionType = Constant.StoryScreenEffectType.WhiteInkOut
	self.isPlayingBlackScreen = true

	self:_SetNewStoryEffectTask(PlayEffect)
end

function StoryScreenEffectUI:BlackAlphaIn(PlayEffect)
	self:__OnSetStoryRepairBtnActive(true)
	LuaUtility.SetGameObjectShow(self.BlackAlphaScreen, true)

	if StoryModule.blackScreenDuration <= 0 then
		LuaUtility.SetImageColorWithGameObject(self.BlackAlphaScreen, 0, 0, 0, 1)

		return
	end

	self.currentActionType = Constant.StoryScreenEffectType.BlackAlphaIn

	LuaUtility.PlayAnimationWithSpeed(self.BlackAlphaScreen, animation_In, 2.5 / StoryModule.blackScreenDuration, nil, function()
		if PlayEffect then
			PlayEffect:LoadSucceed()
		end
	end)
end

function StoryScreenEffectUI:BlackAlphaOut(PlayEffect)
	self:__OnSetStoryRepairBtnActive(false)
	LuaUtility.SetGameObjectShow(self.BlackAlphaScreen, true)

	if StoryModule.blackScreenDuration <= 0 then
		LuaUtility.SetImageColorWithGameObject(self.BlackAlphaScreen, 0, 0, 0, 0)
		LuaUtility.SetGameObjectShow(self.BlackAlphaScreen, false)

		return
	end

	self.currentActionType = Constant.StoryScreenEffectType.BlackAlphaIn

	LuaUtility.PlayAnimationWithSpeed(self.BlackAlphaScreen, animation_Out, 2.5 / StoryModule.blackScreenDuration, nil, function()
		LuaUtility.SetGameObjectShow(self.BlackAlphaScreen, false)

		if PlayEffect then
			PlayEffect:LoadSucceed()
		end
	end)
end

function StoryScreenEffectUI:WhiteAlphaIn(PlayEffect)
	self:__OnSetStoryRepairBtnActive(true)
	LuaUtility.SetGameObjectShow(self.WhiteAlphaScreen, true)

	self.currentActionType = Constant.StoryScreenEffectType.WhiteAlphaIn

	LuaUtility.PlayAnimationWithSpeed(self.WhiteAlphaScreen, animation_In, 2.5 / StoryModule.blackScreenDuration, nil, function()
		if PlayEffect then
			PlayEffect:LoadSucceed()
		end
	end)
end

function StoryScreenEffectUI:WhiteAlphaOut(PlayEffect)
	self:__OnSetStoryRepairBtnActive(false)
	LuaUtility.SetGameObjectShow(self.WhiteAlphaScreen, true)

	self.currentActionType = Constant.StoryScreenEffectType.WhiteAlphaIn

	LuaUtility.PlayAnimationWithSpeed(self.WhiteAlphaScreen, animation_Out, 2.5 / StoryModule.blackScreenDuration, nil, function()
		LuaUtility.SetGameObjectShow(self.WhiteAlphaScreen, false)

		if PlayEffect then
			PlayEffect:LoadSucceed()
		end
	end)
end

function StoryScreenEffectUI:ShowBlackScreen()
	self:__OnSetStoryRepairBtnActive(true)
	self.mat_BlackScreen:SetFloat(property_show, 10)
	self.mat_BlackScreen:SetFloat(property_hide, 0)
	LuaUtility.SetGameObjectShow(self.BlackInkScreen, true)
end

function StoryScreenEffectUI:OnBlackScreenUpdate()
	local t = Time.time - self.dTime
	local paramData = CfgUtil.GetPublicParametersData()
	local duration

	if StoryModule.blackScreenDuration and StoryModule.blackScreenDuration >= 0 then
		duration = StoryModule.blackScreenDuration
	else
		duration = paramData.StoryBlackScreen_duration
	end

	if duration < t then
		self:OnBlackScreenComplete()

		return
	end

	local curveTime = math.MapClamped(t, 0, duration, 0, 1)
	local v

	if self.currentActionType == Constant.StoryScreenEffectType.BlackInkIn then
		v = duration ~= 0 and paramData.StoryBlackScreen_curve:Evaluate(curveTime) or 10

		self.mat_BlackScreen:SetFloat(property_show, v)
	elseif self.currentActionType == Constant.StoryScreenEffectType.BlackInkOut then
		v = duration ~= 0 and paramData.StoryBlackScreenOut_Curve:Evaluate(curveTime) or 10

		self.mat_BlackScreen:SetFloat(property_hide, v)
	elseif self.currentActionType == Constant.StoryScreenEffectType.WhiteInkIn then
		v = duration ~= 0 and paramData.StoryBlackScreen_curve:Evaluate(curveTime) or 10

		self.mat_WhiteInkScreen:SetFloat(property_show, v)
	elseif self.currentActionType == Constant.StoryScreenEffectType.WhiteInkOut then
		v = duration ~= 0 and paramData.StoryBlackScreenOut_Curve:Evaluate(curveTime) or 10

		self.mat_WhiteInkScreen:SetFloat(property_hide, v)
	end
end

function StoryScreenEffectUI:OnBlackScreenComplete()
	self:__OnSetStoryRepairBtnActive(false)

	self.isPlayingBlackScreen = false

	if self.currentActionType == Constant.StoryScreenEffectType.BlackInkOut then
		LuaUtility.SetGameObjectShow(self.BlackInkScreen, false)
	elseif self.currentActionType == Constant.StoryScreenEffectType.BlackInkIn then
		self.mat_BlackScreen:SetFloat(property_show, 10)
		self.mat_BlackScreen:SetFloat(property_hide, 0)
	elseif self.currentActionType == Constant.StoryScreenEffectType.WhiteInkIn then
		self.mat_WhiteInkScreen:SetFloat(property_show, 10)
		self.mat_WhiteInkScreen:SetFloat(property_hide, 0)
	elseif self.currentActionType == Constant.StoryScreenEffectType.WhiteInkOut then
		LuaUtility.SetGameObjectShow(self.WhiteInkScreen, false)
	end

	if self.playEffect then
		self.playEffect:LoadSucceed()

		self.playEffect = nil
		StoryModule.blackScreenDuration = nil
	end
end

function StoryScreenEffectUI:PlayEffectWithType(type, task)
	if type == Constant.StoryScreenEffectType.BlackInkScreen then
		self:ShowBlackScreen()
	elseif type == Constant.StoryScreenEffectType.ThinkingFilter then
		self:ShowThinkingFilter(task)
	end
end

function StoryScreenEffectUI:StopEffectWithType(type, task)
	self:__OnSetStoryRepairBtnActive(false)

	if type == Constant.StoryScreenEffectType.BlackInkScreen then
		LuaUtility.SetGameObjectShow(self.BlackInkScreen, false)
	elseif type == Constant.StoryScreenEffectType.ThinkingFilter then
		self:HideThinkingFilter(task)
	end
end

function StoryScreenEffectUI:ShowThinkingFilter(task)
	self.Mat_thinkingEffect:SetFloat(property_thinking, 0)
	LuaUtility.SetGameObjectShow(self.thinkingEffect, true)
	LuaUtility.DoTweenTo_Float(0, 1, StoryModule.thinkFilterDuration, function(v)
		self.Mat_thinkingEffect:SetFloat(property_thinking, v)

		if v >= 1 and task then
			task:SetComplete()
		end

		self:__OnSetStoryRepairBtnActive(false)
	end)
end

function StoryScreenEffectUI:HideThinkingFilter(task)
	LuaUtility.SetGameObjectShow(self.thinkingEffect, false)
	LuaUtility.DoTweenTo_Float(1, 0, StoryModule.thinkFilterDuration, function(v)
		self.Mat_thinkingEffect:SetFloat(property_thinking, v)

		if v <= 0 then
			self:__OnSetStoryRepairBtnActive(false)

			if task then
				task:SetComplete()
			end
		end
	end)
end

function StoryScreenEffectUI:_SetNewStoryEffectTask(playEffect)
	if not playEffect then
		return
	end

	if self.playEffect then
		self.playEffect:LoadSucceed()

		self.playEffect = nil
	end

	self.playEffect = playEffect
end

function StoryScreenEffectUI:__OnSetStoryRepairBtnActive(active)
	self.RepairBtn.gameObject:SetActive(false)
end

function StoryScreenEffectUI:__StartRepairBtnTimer()
	self:__StopRepairBtnTimer()

	self.__RepairBtnTimer = Timer.New(function()
		self.RepairBtn.gameObject:SetActive(true)
	end, 5)

	self.__RepairBtnTimer:Start()
end

function StoryScreenEffectUI:__StopRepairBtnTimer()
	self.RepairBtn.gameObject:SetActive(false)

	if self.__RepairBtnTimer == nil then
		return
	end

	self.__RepairBtnTimer:Stop()

	self.__RepairBtnTimer = nil
end

function StoryScreenEffectUI:__OnRepairBtnClick()
	SceneTransferModule.ReEnterStory()
end

return StoryScreenEffectUI
