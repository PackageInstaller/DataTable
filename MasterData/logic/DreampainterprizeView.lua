-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreampainter/view/DreampainterprizeView.lua

module("logic.extensions.dreampainter.view.DreampainterprizeView", package.seeall)

local DreampainterprizeView = class("DreampainterprizeView", ViewComponent)

function DreampainterprizeView:ctor()
	DreampainterprizeView.super.ctor(self)
end

function DreampainterprizeView:unbindEvents()
	DreampainterprizeView.super.unbindEvents(self)
end

function DreampainterprizeView:bindEvents()
	DreampainterprizeView.super.bindEvents(self)
end

function DreampainterprizeView:buildUI()
	DreampainterprizeView.super.buildUI(self)

	self._item = self:getGo("item")
	self._cell = self:getGo("cell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function DreampainterprizeView:onExit()
	DreampainterprizeView.super.onExit(self)
	self._scrollList:dispose()
end

function DreampainterprizeView:onEnter()
	DreampainterprizeView.super.onEnter(self)

	self._scrollMap = {}
	self._activityId = checknumber(self:getFirstParam())

	self:_refreshUI()
end

function DreampainterprizeView:_refreshUI()
	local list = DreamPainterConfig.instance:getDreamPainterPrize(self._activityId) or {}

	self._scrollList:reloadData(list)
end

function DreampainterprizeView:_updateCell(view, cell, data, tag)
	local txt = goutil.findChildTextComponent(cell, "txt")
	local tableview = goutil.findChild(cell, "tableview")
	local scrollList = self._scrollMap[tableview]

	if scrollList == nil then
		scrollList = ScrollerList.create(tableview, self._item, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self.clearItemCell, self))

		scrollList:dragNotifyParent()

		self._scrollMap[tableview] = scrollList
	end

	txt.text = data.desc or ""

	local list = string.split(data.prize, "#")

	scrollList:reloadData(list)
end

function DreampainterprizeView:clearCell(cell)
	local tableview = goutil.findChild(cell, "tableview")
	local scrollList = self._scrollMap[tableview]

	if scrollList then
		scrollList:dispose()
	end
end

function DreampainterprizeView:_updateItemCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell)
end

function DreampainterprizeView:clearItemCell(cell)
	MaterialMgr.resetAll(cell)
end

return DreampainterprizeView
