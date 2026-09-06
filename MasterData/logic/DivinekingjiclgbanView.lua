-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingjiclg/view/DivinekingjiclgbanView.lua

module("logic.extensions.divinekingjiclg.view.DivinekingjiclgbanView", package.seeall)

local DivinekingjiclgbanView = class("DivinekingjiclgbanView", ViewComponent)

function DivinekingjiclgbanView:ctor()
	DivinekingjiclgbanView.super.ctor(self)
end

function DivinekingjiclgbanView:unbindEvents()
	DivinekingjiclgbanView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function DivinekingjiclgbanView:bindEvents()
	DivinekingjiclgbanView.super.bindEvents(self)
	self._btnSure:AddClickListener(self.close, self)
end

function DivinekingjiclgbanView:buildUI()
	DivinekingjiclgbanView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyGo = self:getGo("empty")
end

function DivinekingjiclgbanView:onExit()
	DivinekingjiclgbanView.super.onExit(self)
	self._scrollerList:dispose()
end

function DivinekingjiclgbanView:onEnter()
	DivinekingjiclgbanView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self:_updateUI()
end

function DivinekingjiclgbanView:_updateCell(view, cell, raceId, tag)
	MaterialMgr.setCell(MatType.Pet, raceId, cell.gameObject)
end

function DivinekingjiclgbanView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function DivinekingjiclgbanView:_updateUI()
	local lockRaceIds = DivinekingjiclgModel.instance:getLockRaceIds(self._activityId)

	self._scrollerList:reloadData(lockRaceIds)
	goutil.setActive(self._emptyGo, not lockRaceIds or #lockRaceIds <= 0)
end

return DivinekingjiclgbanView
