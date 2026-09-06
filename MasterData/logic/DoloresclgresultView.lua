-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doloresclg/view/DoloresclgresultView.lua

module("logic.extensions.doloresclg.view.DoloresclgresultView", package.seeall)

local DoloresclgresultView = class("DoloresclgresultView", ViewComponent)

function DoloresclgresultView:ctor()
	DoloresclgresultView.super.ctor(self)
end

function DoloresclgresultView:unbindEvents()
	DoloresclgresultView.super.unbindEvents(self)
end

function DoloresclgresultView:bindEvents()
	DoloresclgresultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function DoloresclgresultView:buildUI()
	DoloresclgresultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._tableCell = self:getGo("tableCell")
	self._tableView = self:getGo("tableView")
	self._empty = self:getGo("empty")
	self._scrollList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setCenterMode(true)
end

function DoloresclgresultView:onExit()
	DoloresclgresultView.super.onExit(self)
	self._scrollList:dispose()
	BattleController.instance:endBattle()
end

function DoloresclgresultView:onEnter()
	DoloresclgresultView.super.onEnter(self)

	self._fightPb = self:getFirstParam() or {}

	if not self._fightPb.lockAttrTypes then
		local list = {}

		self._scrollList:reloadData(list)
		GameUtil.SetActive(self._empty, #list == 0)
	end
end

function DoloresclgresultView:_updateCell(view, cell, data, tag)
	local Img_attr = goutil.findChild(cell, "Img_attr")
	local race = GameEnum.Races[data]

	race = race % 10

	GameUtil.setUIImageSpriteIdx(Img_attr, race - 1)
end

function DoloresclgresultView:_clearCell(cell)
	return
end

return DoloresclgresultView
