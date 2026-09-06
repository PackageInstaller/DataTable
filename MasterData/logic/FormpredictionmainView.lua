-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formprediction/view/FormpredictionmainView.lua

module("logic.extensions.formprediction.view.FormpredictionmainView", package.seeall)

local FormpredictionmainView = class("FormpredictionmainView", ViewComponent)

function FormpredictionmainView:ctor()
	FormpredictionmainView.super.ctor(self)
end

function FormpredictionmainView:unbindEvents()
	FormpredictionmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnClose, self.close, self)
	GameUtil.rmClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.rmClickHandler(self._btnAnswer, self._onClickAnswer, self)
	GameUtil.rmClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.rmClickHandler(self._btnSelectRank, self._onClickSelectRank, self)
	GameUtil.rmClickHandler(self._btnRank, self._onClickRank, self)
end

function FormpredictionmainView:bindEvents()
	FormpredictionmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnAnswer, self._onClickAnswer, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnSelectRank, self._onClickSelectRank, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
end

function FormpredictionmainView:buildUI()
	FormpredictionmainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnSelectRank = self:getGo("btnSelectRank")
	self._btnAnswer = self:getGo("btnAnswer")
	self._btnStart = self:getGo("btnStart")
	self._btnRank = self:getGo("btnRank")
	self._txtTime = self:getTxt("txtTime/txt")
end

function FormpredictionmainView:onExit()
	FormpredictionmainView.super.onExit(self)
end

function FormpredictionmainView:onEnter()
	FormpredictionmainView.super.onEnter(self)

	self._activityId = 385001
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function FormpredictionmainView:_onClickStart()
	UIStateManager.instance:push(ViewName.FormpredictionselectView, self._activityId)
end

function FormpredictionmainView:_onClickSelectRank()
	UIStateManager.instance:push(ViewName.FormpredictionrateView, self._activityId)
end

function FormpredictionmainView:_onClickRank()
	local tabCfg = FormPredictionConfig.instance:getFormationCfgById(self._activityId, 1) or {}
	local publicationTime = tabCfg.publicationTime
	local lastTime = GameUtil.string2time(publicationTime)
	local now = ServerTime.now()

	if now < lastTime then
		TipsFacade.instance:openCommonTips("揭晓榜单后开启~")
	else
		UIStateManager.instance:push(ViewName.FormpredictionrankView, self._activityId)
	end
end

function FormpredictionmainView:_onClickAnswer()
	local cfg = FormPredictionConfig.instance:getInfoCfgById(self._activityId) or {}

	GotoMgr.gotoByString(cfg.jumpTo)
end

function FormpredictionmainView:_onClickTip()
	TipsFacade.instance:openRulesView("FormpredictionmainView_rule")
end

return FormpredictionmainView
