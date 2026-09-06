-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partysummary/view/NewYearWordTabView.lua

module("logic.extensions.partysummary.view.NewYearWordTabView", package.seeall)

local NewYearWordTabView = class("NewYearWordTabView", ViewComponent)

function NewYearWordTabView:ctor()
	NewYearWordTabView.super.ctor(self)
end

function NewYearWordTabView:buildUI()
	NewYearWordTabView.super.buildUI(self)

	self._content = self:getGo("content")
	self._btnTab_1 = self:getGo("btnTab_1")
	self._btnTab_2 = self:getGo("btnTab_2")
	self._btnClose = self:getGo("closeBtn")
	self._changeGroup1 = self._btnTab_1:GetComponent(typeof(UIChangeGroup))
	self._changeGroup2 = self._btnTab_2:GetComponent(typeof(UIChangeGroup))
	self._lock = self:getGo("btnTab_2/lock")
end

function NewYearWordTabView:bindEvents()
	NewYearWordTabView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTab_1, GameUtil.handler(self._onClickBtnTab, self, 1))
	GameUtil.addClickHandler(self._btnTab_2, GameUtil.handler(self._onClickBtnTab, self, 2))
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function NewYearWordTabView:unbindEvents()
	NewYearWordTabView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTab_1)
	GameUtil.rmClickHandler(self._btnTab_2)
	GameUtil.rmClickHandler(self._btnClose)
end

function NewYearWordTabView:onEnter()
	NewYearWordTabView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local var_5_0 = self._tabIndex

	if not self._tabIndex then
		var_5_0 = checknumber(params[1])
		var_5_0 = var_5_0 or 1
	end

	self._tabIndex = var_5_0
	self._params2 = self._params2 or params[2]

	if self._tabIndex <= 0 then
		self._tabIndex = 1
	end

	self._activityId = PartySummaryConfig.instance:getPartyGiftActivityId()

	local actCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.PartyGift, 200018)

	self._isInTime = GameUtil.checkIsInTimePeriod(actCfg.startTime, actCfg.endTime)

	self:_onSetUI()
end

function NewYearWordTabView:onExit()
	NewYearWordTabView.super.onExit(self)

	self._tabIndex = nil
end

function NewYearWordTabView:_onSetUI()
	self:_onClickBtnTab(self._tabIndex)
	GameUtil.SetActive(self._lock, not self._isInTime)
end

function NewYearWordTabView:_onClickBtnTab(index)
	if index == 1 then
		local groupId = checknumber(self._params2)

		self:showTabAt(self._content, ViewName.NewYearWordView, self._activityId, groupId)
		self._changeGroup1:SetState(1)
		self._changeGroup2:SetState(0)
	else
		if not self._isInTime then
			FloatWordMgr.instance:show("未到活动开放时间")

			return
		end

		self:showTabAt(self._content, ViewName.PartyGift, self._activityId)
		self._changeGroup1:SetState(0)
		self._changeGroup2:SetState(1)
	end
end

return NewYearWordTabView
