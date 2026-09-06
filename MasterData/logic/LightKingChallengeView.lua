-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingChallengeView.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingChallengeView", package.seeall)

local LightKingChallengeView = class("LightKingChallengeView", ViewComponent)

function LightKingChallengeView:unbindEvents()
	LightKingChallengeView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnAddTimes:RemoveClickListener()
end

function LightKingChallengeView:bindEvents()
	LightKingChallengeView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
	self._btnAddTimes:AddClickListener(self._onClickAddTimes, self)
end

function LightKingChallengeView:onExit()
	LightKingChallengeView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	GlobalDispatcher:removeListener(GlobalNotify.LightKingBuyTimes, self._onBuyTimesRes, self)
end

function LightKingChallengeView:buildUI()
	LightKingChallengeView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("upInfoTran/titleTxt")
	self._txtBubble = self:getTxt("bubble/Text")
	self._roleCon = self:getGo("roleCon")
	self._btnRule = self:getBtn("btnRule")
	self._container = self:getGo("container")
	self._bubble = self:getGo("bubble")
	self._dailyUsedTimes = self:getGo("dailyUsedTimes")
	self._btnAddTimes = self:getBtn("dailyUsedTimes/btn_add")
	self._txtDailyUsedTimes = goutil.findChildTextComponent(self._dailyUsedTimes, "Text")
	self._txtfinishTimes = self:getTxt("finishTimes/Text")
end

function LightKingChallengeView:onEnter()
	LightKingChallengeView.super.onEnter(self)

	self._challengeType = LightKingModel.instance:getCurChallengeType()
	self._cfg = LightKingConfig.instance:getBaseDefineCfg(self._challengeType)
	self._txtTitle.text = self._cfg.name

	if string.nilorempty(self._cfg.bubble) then
		self._bubble:SetActive(false)
	else
		self._bubble:SetActive(true)

		self._txtBubble.text = self._cfg.bubble
	end

	ViewMgr.instance:openAt(self._container, self._cfg.viewName, self._viewPresentor, self._challengeType)

	local challengeId = LightKingModel.instance:getChallengeId()
	local challengeCfg = TimeLimitedConfig.instance:getCfgById(challengeId)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, challengeCfg.raceId, self._roleCon)

	self._dailyUsedTimes:SetActive(self._cfg.hasDailyTimesLimit)

	local stageCfgs = LightKingConfig.instance:getStageCfgsByType(self._challengeType)
	local curStage = LightKingModel.instance:getCurStage(self._challengeType)

	self._txtfinishTimes.text = string.format("已通关：%d/%d", curStage, #stageCfgs)

	self:_updateLeftTimes()
	GlobalDispatcher:addListener(GlobalNotify.LightKingBuyTimes, self._onBuyTimesRes, self)
end

function LightKingChallengeView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, self._cfg.ruleKey or "")
end

function LightKingChallengeView:_onClickAddTimes()
	LightKingController.instance:addTimes(self._challengeType)
end

function LightKingChallengeView:_onBuyTimesRes()
	FloatWordMgr.instance:show("购买成功")
	self:_updateLeftTimes()
end

function LightKingChallengeView:_updateLeftTimes()
	local leftTimes = LightKingController.instance:getLeftTimes(self._challengeType)
	local total = self._cfg.freeDailyTimes

	self._txtDailyUsedTimes.text = string.format("今日剩余次数：<color=#FEE04AFF>%d</color>/%d", leftTimes, total)

	self._btnAddTimes.gameObject:SetActive(leftTimes <= 0)
end

return LightKingChallengeView
