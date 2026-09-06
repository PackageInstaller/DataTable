-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillmainView.lua

module("logic.extensions.scriptkill.view.ScriptkillmainView", package.seeall)

local ScriptkillmainView = class("ScriptkillmainView", ViewComponent)

function ScriptkillmainView:ctor()
	ScriptkillmainView.super.ctor(self)
end

function ScriptkillmainView:unbindEvents()
	ScriptkillmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnCollect)
	GameUtil.rmClickHandler(self._btnBook)
	GameUtil.rmClickHandler(self._btnRank)
end

function ScriptkillmainView:bindEvents()
	ScriptkillmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)
	GameUtil.addClickHandler(self._btnCollect, self._onClickCollect, self)
	GameUtil.addClickHandler(self._btnBook, self._onClickBook, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
end

function ScriptkillmainView:buildUI()
	ScriptkillmainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnEnter = self:getGo("btnEnter")
	self._btnCollect = self:getGo("btnCollect")
	self._btnBook = self:getGo("btnBook")
	self._btnRank = self:getGo("btnRank")
	self._txtTime = self:getTxt("txtTime/txt")
	self._recipeRed = self:getGo("btnBook/recipeRed")
end

function ScriptkillmainView:onExit()
	ScriptkillmainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._recipeRed)
end

function ScriptkillmainView:onEnter()
	ScriptkillmainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = ScriptKillController.instance:getActivityId()
	end

	self.addGEvent(self, GlobalNotify.ScriptKillInfoUpdate, self._refreshUI, self)
	ScriptKillController.instance:sendGetInfo(self._activityId)
	self:_refreshUI()

	local taskRedId = EventTaskSummaryController.instance:getCurRedIdByActivityId(self._activityId)

	if taskRedId > 0 then
		RedPointController.instance:regRedPoint(self._recipeRed, taskRedId)
	end
end

function ScriptkillmainView:_refreshUI()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function ScriptkillmainView:_onClickTip()
	TipsFacade.instance:openRulesView("scriptkillmainview_rule")
end

function ScriptkillmainView:_onClickEnter()
	UIStateManager.instance:push(ViewName.ScriptkilllistView, self._activityId)
end

function ScriptkillmainView:_onClickCollect()
	UIStateManager.instance:push(ViewName.ScriptkillguessView, self._activityId)
end

function ScriptkillmainView:_onClickBook()
	UIStateManager.instance:push(ViewName.ScriptkillbookView, self._activityId)
end

function ScriptkillmainView:_onClickRank()
	UIStateManager.instance:push(ViewName.ScriptkillrankView, self._activityId)
end

return ScriptkillmainView
