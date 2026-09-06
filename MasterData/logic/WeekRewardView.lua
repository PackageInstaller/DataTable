-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weekreward/view/WeekRewardView.lua

module("logic.extensions.weekreward.view.WeekRewardView", package.seeall)

local WeekRewardView = class("WeekRewardView", ViewComponent)

function WeekRewardView:ctor()
	return
end

function WeekRewardView:bindEvents()
	for _, signInBtn in ipairs(self._rewards) do
		signInBtn:bindEvents()
	end
end

function WeekRewardView:unbindEvents()
	if self._rewards then
		for k, v in ipairs(self._rewards) do
			v:Dispose()

			self._rewards[k] = nil
		end

		self._rewards = nil
	end
end

function WeekRewardView:buildUI()
	WeekRewardView.super.buildUI(self)

	self._rewards = {}
	self._ovalmove = self:getGo("Nego_Center"):GetComponent("UIOvalMove")

	local num = 7

	self._ovalmove:CreateObjs(num)

	for i = 1, num do
		local go = self:getGo("Nego_Center/" .. tostring(i - 1))

		self._rewards[i] = ItemSignReward.New(go, self)
	end

	self._magicEffect = PhotoEffect.Get(self:getGo("Nego_Center/magiceffect"))

	self._magicEffect._go:SetActive(false)

	self._rawImage = self._magicEffect._go:GetComponent("RawImage")
	self._Nego_SignInEffect = self:getGo("Nego_SignInEffect")
	self._txtTips = self:getGo("Nego_Top/tips"):GetComponent("Text")

	if self._txtTips then
		self._txtTips.text = "累计签到7天即可领取豪华奖励"
	end
end

function WeekRewardView:destroyUI()
	return
end

function WeekRewardView:onEnter()
	self._uiCanvas = Framework.UIGlobalTouchTrigger.uiCanvas
	self._uiCam = Framework.UIGlobalTouchTrigger.uiCamera

	WeekRewardFacade.instance:enterSignIn()
	MaterialUtils.SetRTRawImageAlpha(self._rawImage, 0)
	WeekRewardController.instance:registerLocalNotify("WeekInfoGot", self.RefreshRewards, self)
	WeekRewardController.instance:registerLocalNotify("WeekSignIn", self._onWeekSignIn, self)
	GlobalDispatcher:addListener(GlobalNotify.ItemGetViewClosed, self._OnItemGetViewClosed, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.reloadData, self)
end

function WeekRewardView:onEnterFinished()
	self._magicEffect:showEffects("effect/prefabs/ui/fx_ui_7ri/fx_ui_mofang_xu.prefab")
	self._magicEffect:setCameraPosition(0, 0, -10)

	self._rtCamera = self._magicEffect._photo.producer.rtCamera

	if self._rtCamera then
		self._rtCamera.orthographic = true
	end
end

function WeekRewardView:onExit()
	WeekRewardController.instance:unregisterLocalNotify("WeekInfoGot", self.RefreshRewards, self)
	WeekRewardController.instance:unregisterLocalNotify("WeekSignIn", self._onWeekSignIn, self)
	GlobalDispatcher:removeListener(GlobalNotify.ItemGetViewClosed, self._OnItemGetViewClosed, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self.reloadData, self)
end

function WeekRewardView:onExitFinished()
	if self._magicEffect then
		self._magicEffect:clear()
	end

	self._ovalmove:Dispose()
	self._magicEffect:clear()
end

function WeekRewardView:reloadData()
	WeekRewardAgent.instance:sendSignInInfoReq()
end

function WeekRewardView:RefreshRewards()
	for key, item in ipairs(self._rewards) do
		item:SetData(key)
	end

	local centerDay = WeekRewardModel.instance:getCurCanSignDay()

	self._ovalmove:CenterOn(centerDay >= 0 and centerDay or 0, false)
	self._ovalmove:IsPause(centerDay >= 0)
end

function WeekRewardView:_onClickClose()
	UIStateManager.instance:pop()
end

function WeekRewardView:_onWeekSignIn()
	self:playEffect()
	self:RefreshRewards()
end

function WeekRewardView:_OnItemGetViewClosed()
	if ViewMgr.instance:isOpen("weekreward") then
		local centerDay = WeekRewardModel.instance:getCurCanSignDay()

		self._ovalmove:CenterOn(WeekRewardModel.instance:getPrizedDay() % 7, true)
		self._ovalmove:IsPause(centerDay >= 0)
	end
end

function WeekRewardView:playEffect(day)
	local prizeDay = WeekRewardModel.instance:getPrizedDay()
	local bIsTheEnd = prizeDay > 0 and prizeDay / 7 == 0
	local resPath = bIsTheEnd and "fx_ui_7ri/fx_ui_mofang_baokai.prefab" or "fx_ui_7ri/fx_ui_fangkuai_baokai.prefab"

	UIEffectManager.instance:playEffect(self, resPath, self.Nego_SignInEffect, 0, 0, false, nil, nil, nil, self)
end

return WeekRewardView
