-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpowersclg/view/OriginPowersClgNormalBuffView.lua

module("logic.extensions.originpowersclg.view.OriginPowersClgNormalBuffView", package.seeall)

local OriginPowersClgNormalBuffView = class("OriginPowersClgNormalBuffView", ViewComponent)

function OriginPowersClgNormalBuffView:ctor()
	OriginPowersClgNormalBuffView.super.ctor(self)
end

function OriginPowersClgNormalBuffView:unbindEvents()
	OriginPowersClgNormalBuffView.super.unbindEvents(self)
end

function OriginPowersClgNormalBuffView:bindEvents()
	OriginPowersClgNormalBuffView.super.bindEvents(self)
end

function OriginPowersClgNormalBuffView:buildUI()
	OriginPowersClgNormalBuffView.super.buildUI(self)

	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnSure = self:getGo("btnSure")
end

function OriginPowersClgNormalBuffView:onExit()
	OriginPowersClgNormalBuffView.super.onExit(self)
end

function OriginPowersClgNormalBuffView:onEnter()
	OriginPowersClgNormalBuffView.super.onEnter(self)
end

function OriginPowersClgNormalBuffView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
end

function OriginPowersClgNormalBuffView:_clearCell(cell)
	return
end

return OriginPowersClgNormalBuffView
