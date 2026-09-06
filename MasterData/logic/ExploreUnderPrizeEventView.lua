-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderPrizeEventView.lua

module("logic.extensions.exploreunder.view.ExploreUnderPrizeEventView", package.seeall)

local ExploreUnderPrizeEventView = class("ExploreUnderPrizeEventView", ViewComponent)

function ExploreUnderPrizeEventView:buildUI()
	ExploreUnderPrizeEventView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnGet = self:getGo("btnGet")
	self._goItems = self:getGo("items")
end

function ExploreUnderPrizeEventView:bindEvents()
	ExploreUnderPrizeEventView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGet, self._onClickGet, self)
end

function ExploreUnderPrizeEventView:unbindEvents()
	ExploreUnderPrizeEventView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGet)
end

function ExploreUnderPrizeEventView:onEnter()
	ExploreUnderPrizeEventView.super.onEnter(self)

	local curActId = ExploreUnderModel.instance:getActId()
	local curActCfg = ExploreUnderConfig.instance:getActfg(curActId)
	local curLevel = ExploreUnderModel.instance:getCurLevel()
	local curLevelCfg = ExploreUnderConfig.instance:getLevelCfg(curActCfg.levelPlanId, curLevel)
	local params = self:getOpenParam() or {}

	self._eventParma = checkint(params[1])
	self._isOnlyShow = checkbool(params[2])
	self._prizeCfg = ExploreUnderConfig.instance:getPrizeEventCfg(curLevelCfg.event_plan_1, self._eventParma)

	goutil.setActive(self._btnGet, not self._isOnlyShow)

	if self._prizeCfg then
		MaterialMgr.setCellListByCfg(self._prizeCfg.rewards, self._goItems)
	end

	if not self._isOnlyShow then
		self._curEventInfo = ExploreUnderModel.instance:getCurGridInfo()

		local curEventState = ExploreUnderModel.instance:getCurEventState()

		if self._curEventInfo.eventType ~= 1 or curEventState ~= ExploreUnderEnum.EventState_Orgin then
			self:close()

			return
		end
	end

	GlobalDispatcher:addListener(GlobalNotify.ExploreUnderEventInfoChange, self.close, self)
end

function ExploreUnderPrizeEventView:onExit()
	ExploreUnderPrizeEventView.super.onExit(self)
	MaterialMgr.resetAll(self._goItems)
	GlobalDispatcher:removeListener(GlobalNotify.ExploreUnderEventInfoChange, self.close, self)
	ExploreUnderModel.instance:ShowCI()
end

function ExploreUnderPrizeEventView:_onClickGet()
	self._curEventInfo = ExploreUnderModel.instance:getCurGridInfo()

	local curEventState = ExploreUnderModel.instance:getCurEventState()

	if self._curEventInfo.eventType ~= 1 or curEventState ~= ExploreUnderEnum.EventState_Orgin then
		self:close()

		return
	end

	ExploreUnderController.instance:dealEvent(ExploreUnderModel.EventAction.gainPrize)
end

return ExploreUnderPrizeEventView
