-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingwujinlong/view/KingwujinlonglockView.lua

module("logic.extensions.kingwujinlong.view.KingwujinlonglockView", package.seeall)

local KingwujinlonglockView = class("KingwujinlonglockView", ViewComponent)

function KingwujinlonglockView:ctor()
	KingwujinlonglockView.super.ctor(self)
end

function KingwujinlonglockView:unbindEvents()
	KingwujinlonglockView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function KingwujinlonglockView:bindEvents()
	KingwujinlonglockView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function KingwujinlonglockView:buildUI()
	KingwujinlonglockView.super.buildUI(self)

	self._tableView = self:getGo("tableView")
	self._tableCell = self:getGo("tableCell")
	self._btnSure = self:getGo("btnSure")
	self._empty = self:getGo("empty")
	self._scrollList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function KingwujinlonglockView:onExit()
	KingwujinlonglockView.super.onExit(self)
	self._scrollList:dispose()
end

function KingwujinlonglockView:onEnter()
	KingwujinlonglockView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._info = KingWujinlongModel.instance:getInfo(self._activityId) or {}
	self._clgInfo = self._info.clgInfo or {}

	if not self._clgInfo.banRace then
		local banRace = {}

		self._scrollList:reloadData(banRace)
		GameUtil.SetActive(self._empty, #banRace == 0)
	end
end

function KingwujinlonglockView:_updateCell(view, cell, data, tag)
	MaterialMgr.setCell(MatType.Pet, data, cell)
end

function KingwujinlonglockView:_clearCell(cell)
	MaterialMgr.resetAll(cell)
end

return KingwujinlonglockView
