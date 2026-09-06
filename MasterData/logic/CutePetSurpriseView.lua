-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/travel/CutePetSurpriseView.lua

module("logic.extensions.cutepet.view.CutePetSurpriseView", package.seeall)

local CutePetSurpriseView = class("CutePetSurpriseView", ViewComponent)

function CutePetSurpriseView:ctor()
	CutePetSurpriseView.super.ctor(self)
end

function CutePetSurpriseView:unbindEvents()
	CutePetSurpriseView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CutePetSurpriseView:bindEvents()
	CutePetSurpriseView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function CutePetSurpriseView:buildUI()
	CutePetSurpriseView.super.buildUI(self)

	self._btnClose = self:getGo("bgMask")
	self._tableView = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._prizeTable = self:getGo("prizeInfo/itemcon")
	self._prizeCell = self:getGo("prizeInfo/itemcon/item")
	self._prizeList = ItemGroup.New(self._prizeTable, self._prizeCell)
end

function CutePetSurpriseView:onExit()
	CutePetSurpriseView.super.onExit(self)
	self._prizeList:dispose(self._clearCell, self)
	self._tableList:dispose()
end

function CutePetSurpriseView:onEnter()
	CutePetSurpriseView.super.onEnter(self)

	self._tableList = ScrollerList.create(self._tableView, self._tablecell, GameUtil.handler(self._updateListCell, self), GameUtil.handler(self._clearListCell, self))

	local prize = CutePetConfig.instance:getCommonValue("DoubleTravelSurprisePrize", false)

	prize = MaterialMgr.changeIfDrop(prize)

	local list = string.split(prize, "#")

	if #list < 6 then
		self._prizeList:updateWithMoArray(list, self._updateCell, self)
	else
		self._tableList:reloadData(list)
	end
end

function CutePetSurpriseView:_updateCell(cell, data, i)
	local go = cell.mainGO
	local proxy = MaterialMgr.setCellByCfg(data, go)
end

function CutePetSurpriseView:_clearCell(cell)
	local go = cell.mainGO

	MaterialMgr.resetAll(go)
end

function CutePetSurpriseView:_updateListCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function CutePetSurpriseView:_clearListCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

return CutePetSurpriseView
