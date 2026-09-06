-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/view/DivineZhongFeiClgBlockView.lua

module("logic.extensions.divinezhongfeiclg.view.DivineZhongFeiClgBlockView", package.seeall)

local DivineZhongFeiClgBlockView = class("DivineZhongFeiClgBlockView", ViewComponent)

function DivineZhongFeiClgBlockView:ctor()
	DivineZhongFeiClgBlockView.super.ctor(self)
end

function DivineZhongFeiClgBlockView:unbindEvents()
	DivineZhongFeiClgBlockView.super.unbindEvents(self)
end

function DivineZhongFeiClgBlockView:bindEvents()
	DivineZhongFeiClgBlockView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function DivineZhongFeiClgBlockView:buildUI()
	DivineZhongFeiClgBlockView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyGo = self:getGo("empty")
end

function DivineZhongFeiClgBlockView:onExit()
	DivineZhongFeiClgBlockView.super.onExit(self)
end

function DivineZhongFeiClgBlockView:onEnter()
	DivineZhongFeiClgBlockView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	local list = DivineZhongFeiClgModel.instance:getLockRaceIds(self._activityId)

	self._tableList:reloadData(list)
	GameUtil.SetActive(self._emptyGo, #list <= 0)
end

function DivineZhongFeiClgBlockView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCell(MatType.Pet, data, go)
end

function DivineZhongFeiClgBlockView:_clearCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

return DivineZhongFeiClgBlockView
