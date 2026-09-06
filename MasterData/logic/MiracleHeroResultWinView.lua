-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroResultWinView.lua

module("logic.extensions.miraclehero.view.MiracleHeroResultWinView", package.seeall)

local MiracleHeroResultWinView = class("MiracleHeroResultWinView", ViewComponent)

function MiracleHeroResultWinView:ctor()
	MiracleHeroResultWinView.super.ctor(self)
end

function MiracleHeroResultWinView:unbindEvents()
	MiracleHeroResultWinView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function MiracleHeroResultWinView:bindEvents()
	MiracleHeroResultWinView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function MiracleHeroResultWinView:buildUI()
	MiracleHeroResultWinView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableList:setCenterMode(true)
end

function MiracleHeroResultWinView:onExit()
	MiracleHeroResultWinView.super.onExit(self)
	self._tableList:dispose()
end

function MiracleHeroResultWinView:onEnter()
	MiracleHeroResultWinView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._challengeId = params[2]
	self._stageId = params[3]

	local stageCfg = MiracleHeroConfig.instance:getStageCfg(self._activityId, self._challengeId, self._stageId)
	local prizeList = string.split(stageCfg.prize, "#")

	self._tableList:reloadData(prizeList)
end

function MiracleHeroResultWinView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function MiracleHeroResultWinView:_clearCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function MiracleHeroResultWinView:_onClickClose()
	GlobalDispatcher:dispatch(GlobalNotify.MiracleHeroBattleEnd)
	self:close()
end

return MiracleHeroResultWinView
