-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderMoveEventView.lua

module("logic.extensions.exploreunder.view.ExploreUnderMoveEventView", package.seeall)

local ExploreUnderMoveEventView = class("ExploreUnderMoveEventView", ViewComponent)

function ExploreUnderMoveEventView:buildUI()
	ExploreUnderMoveEventView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnMove = self:getGo("btnMove")
	self._txtDescEvent = self:getTxt("descEvent")
end

function ExploreUnderMoveEventView:bindEvents()
	ExploreUnderMoveEventView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnMove, self._onClickMove, self)
end

function ExploreUnderMoveEventView:unbindEvents()
	ExploreUnderMoveEventView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnMove)
end

function ExploreUnderMoveEventView:onEnter()
	ExploreUnderMoveEventView.super.onEnter(self)

	local curActId = ExploreUnderModel.instance:getActId()
	local curActCfg = ExploreUnderConfig.instance:getActfg(curActId)
	local curLevel = ExploreUnderModel.instance:getCurLevel()
	local curLevelCfg = ExploreUnderConfig.instance:getLevelCfg(curActCfg.levelPlanId, curLevel)
	local params = self:getOpenParam() or {}

	self._eventParma = checkint(params[1])
	self._isOnlyShow = checkbool(params[2])

	goutil.setActive(self._btnMove, not self._isOnlyShow)

	self._moveCfg = ExploreUnderConfig.instance:getMoveEventCfg(curLevelCfg.event_plan_2, self._eventParma)
	self._txtDescEvent.text = self._moveCfg.eventDesc

	if not self._isOnlyShow then
		self._curEventInfo = ExploreUnderModel.instance:getCurGridInfo()

		local curEventState = ExploreUnderModel.instance:getCurEventState()

		if self._curEventInfo.eventType ~= 2 or curEventState ~= ExploreUnderEnum.EventState_Orgin then
			self:close()

			return
		end
	end

	GlobalDispatcher:addListener(GlobalNotify.ExploreUnderEventInfoChange, self.close, self)
end

function ExploreUnderMoveEventView:onExit()
	ExploreUnderMoveEventView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ExploreUnderEventInfoChange, self.close, self)
end

function ExploreUnderMoveEventView:_onClickMove()
	self._curEventInfo = ExploreUnderModel.instance:getCurGridInfo()

	local curEventState = ExploreUnderModel.instance:getCurEventState()

	if self._curEventInfo.eventType ~= 2 or curEventState ~= ExploreUnderEnum.EventState_Orgin then
		self:close()

		return
	end

	ExploreUnderController.instance:dealEvent(ExploreUnderModel.EventAction.doMove)
end

return ExploreUnderMoveEventView
