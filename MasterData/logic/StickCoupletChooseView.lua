-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stickcouplet/view/StickCoupletChooseView.lua

module("logic.extensions.stickcouplet.view.StickCoupletChooseView", package.seeall)

local StickCoupletChooseView = class("StickCoupletChooseView", ViewComponent)

function StickCoupletChooseView:ctor()
	StickCoupletChooseView.super.ctor(self)
end

function StickCoupletChooseView:buildUI()
	StickCoupletChooseView.super.buildUI(self)

	self._txtGameTimes = self:getTxt("txtGameTimes")
	self._btnEasy = self:getGo("btnEasy")
	self._btnHard = self:getGo("btnHard")
	self._btnClose = self:getGo("btnClose")
end

function StickCoupletChooseView:bindEvents()
	StickCoupletChooseView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnEasy, self._onClickBtnEasy, self)
	GameUtil.addClickHandler(self._btnHard, self._onClickBtnHard, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function StickCoupletChooseView:unbindEvents()
	StickCoupletChooseView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnEasy)
	GameUtil.rmClickHandler(self._btnHard)
	GameUtil.rmClickHandler(self._btnClose)
end

function StickCoupletChooseView:onEnter()
	StickCoupletChooseView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = StickCoupletController.instance:getActivityId()
	end

	self._actcfg = StickCoupletConfig.instance:getSCActData(self._activityId)
	self._model = StickCoupletModel.instance:getModel(self._activityId)

	self:_onSetUI()
end

function StickCoupletChooseView:onExit()
	StickCoupletChooseView.super.onExit(self)
end

function StickCoupletChooseView:_onSetUI()
	local dailyGameTimes = self._actcfg.dailyGameTimes
	local todayHasGameTimes = dailyGameTimes - self._model.todayGameTimes

	self._txtGameTimes.text = "剩余游戏次数：<color=#FF0000FF>" .. todayHasGameTimes .. "/" .. dailyGameTimes .. "</color>"
end

function StickCoupletChooseView:_onClickBtnEasy()
	StickCoupletController:sendPM_StickCoupletStartGameReq(self._activityId)
	UIStateManager.instance:push(ViewName.StickCoupletNormalGameView, self._activityId)
	self:close()
end

function StickCoupletChooseView:_onClickBtnHard()
	StickCoupletController:sendPM_StickCoupletStartGameReq(self._activityId)
	UIStateManager.instance:push(ViewName.StickCoupletHardGameView, self._activityId)
	self:close()
end

return StickCoupletChooseView
