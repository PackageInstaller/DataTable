-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderGameEventView.lua

module("logic.extensions.exploreunder.view.ExploreUnderGameEventView", package.seeall)

local ExploreUnderGameEventView = class("ExploreUnderGameEventView", ViewComponent)

function ExploreUnderGameEventView:buildUI()
	ExploreUnderGameEventView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnGoto = self:getGo("btnGoto")
	self._loseScrView = self:getGo("lose/scrView")
	self._loseScrCell = self:getGo("lose/scrCell")
	self._loseScrollerList = ScrollerList.create(self._loseScrView, self._loseScrCell, GameUtil.handler(self._updatePrizeItemCell, self), GameUtil.handler(self._clearPrizeItemCell, self))

	self._loseScrollerList:setCenterMode(true)

	self._winScrView = self:getGo("win/scrView")
	self._winScrCell = self:getGo("win/scrCell")
	self._winScrollerList = ScrollerList.create(self._winScrView, self._winScrCell, GameUtil.handler(self._updatePrizeItemCell, self), GameUtil.handler(self._clearPrizeItemCell, self))

	self._winScrollerList:setCenterMode(true)
end

function ExploreUnderGameEventView:bindEvents()
	ExploreUnderGameEventView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
end

function ExploreUnderGameEventView:unbindEvents()
	ExploreUnderGameEventView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGoto)
end

function ExploreUnderGameEventView:onEnter()
	ExploreUnderGameEventView.super.onEnter(self)

	local curActId = ExploreUnderModel.instance:getActId()
	local curActCfg = ExploreUnderConfig.instance:getActfg(curActId)
	local curLevel = ExploreUnderModel.instance:getCurLevel()
	local curLevelCfg = ExploreUnderConfig.instance:getLevelCfg(curActCfg.levelPlanId, curLevel)
	local params = self:getOpenParam() or {}

	self._eventParma = checkint(params[1])
	self._isOnlyShow = checkbool(params[2])
	self._gameCfg = ExploreUnderConfig.instance:getGameEventCfg(curLevelCfg.event_plan_3, self._eventParma)

	goutil.setActive(self._btnGoto, not self._isOnlyShow)

	local losePrizes = self._gameCfg and self._gameCfg.failPrize and string.split(self._gameCfg.failPrize, "#") or {}

	self._loseScrollerList:reloadData(losePrizes)

	local sucPrizes = self._gameCfg and self._gameCfg.sucPrize and string.split(self._gameCfg.sucPrize, "#") or {}

	self._winScrollerList:reloadData(sucPrizes)
end

function ExploreUnderGameEventView:onExit()
	ExploreUnderGameEventView.super.onExit(self)
	self._loseScrollerList:dispose()
	self._winScrollerList:dispose()
end

function ExploreUnderGameEventView:_updatePrizeItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function ExploreUnderGameEventView:_clearPrizeItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function ExploreUnderGameEventView:_onClickGoto()
	self:close()
	UIStateManager.instance:push(ViewName.ExploreUnderGameView)
end

return ExploreUnderGameEventView
