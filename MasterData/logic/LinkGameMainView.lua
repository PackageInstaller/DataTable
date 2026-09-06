-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkgame/view/LinkGameMainView.lua

module("logic.extensions.linkgame.view.LinkGameMainView", package.seeall)

local LinkGameMainView = class("LinkGameMainView", ViewComponent)

function LinkGameMainView:ctor()
	LinkGameMainView.super.ctor(self)
end

function LinkGameMainView:bindEvents()
	LinkGameMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnExchange, self._onClickExchange, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
end

function LinkGameMainView:unbindEvents()
	LinkGameMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnExchange)
	GameUtil.rmClickHandler(self._btnRank)
end

function LinkGameMainView:buildUI()
	LinkGameMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("leftTop/btnTip")
	self._btnStart = self:getGo("btnStart")
	self._redPoint = self:getGo("btnStart/redpoint")
	self._btnExchange = self:getGo("btnExchange")
	self._btnRank = self:getGo("btnRank")
	self._txtTime = self:getTxt("time/txt")
end

function LinkGameMainView:onEnter()
	self._actId = LinkGameModel.instance:getCurActId()
	self._actCfg = LinkGameConfig.instance:getActivityCfg(self._actId)

	local startTimeStemp, endTimeStemp = ActivityDefineController:getStartTimeAndEndTime(GameEnum.ActivityType.LinkGame, self._actId)
	local startTime = GameUtil.time2date(startTimeStemp)
	local endTime = GameUtil.time2date(endTimeStemp)

	self._txtTime.text = langPara("活动时间：%d.%d %d:%02d -%d.%d %d:%02d", startTime.month, startTime.day, startTime.hour, startTime.min, endTime.month, endTime.day, endTime.hour, endTime.min)

	LinkGameAgent.instance:sendPM_LinkGameInfoReq(self._actId)
	RedPointController.instance:regRedPoint(self._redPoint, RedPointModel.ID_LINK_GAME_NEW_LEVEL)
end

function LinkGameMainView:onExit()
	LinkGameMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPoint)
end

function LinkGameMainView:_onClickRule()
	local ruleCfg = LinkGameConfig.instance:getRuleCfgs(self._actCfg.ruleId)
	local ruleList = {}

	for i, v in ipairs(ruleCfg) do
		local obj = {}

		obj.url = v.resPath
		obj.desc = v.desc

		table.insert(ruleList, obj)
	end

	TipsFacade:openImageRuleView(ruleList, "游戏规则")
end

function LinkGameMainView:_onClickStart()
	UIStateManager.instance:push(ViewName.LinkGameLevelView, self._actId)
end

function LinkGameMainView:_onClickExchange()
	GotoMgr.gotoByString(self._actCfg.jumpTo)
end

function LinkGameMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.LinkGameRankView, self._actId)
end

return LinkGameMainView
