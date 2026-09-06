-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/view/DressoutView.lua

module("logic.extensions.dress.view.DressoutView", package.seeall)

local DressoutView = class("DressoutView", ViewComponent)

function DressoutView:ctor()
	DressoutView.super.ctor(self)
end

function DressoutView:buildUI()
	DressoutView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnEnsure = self:getBtn("btnEnsure")
	self._goTable = self:getGo("table")
	self._goCell = self:getGo("cell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DressoutView:bindEvents()
	DressoutView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnEnsure:AddClickListener(self.close, self)
end

function DressoutView:unbindEvents()
	DressoutView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnEnsure:RemoveClickListener()
end

function DressoutView:destroyUI()
	DressoutView.super.destroyUI(self)
end

function DressoutView:onEnter()
	DressoutView.super.onEnter(self)

	local dataList = self:getFirstParam()

	if dataList and #dataList > 0 then
		self._tableView:reloadData(dataList)
	else
		self:close()
	end
end

function DressoutView:onEnterFinished()
	DressoutView.super.onEnterFinished(self)
end

function DressoutView:onExit()
	DressoutView.super.onExit(self)
	self._tableView:dispose()
end

function DressoutView:onExitFinished()
	DressoutView.super.onExitFinished(self)
end

function DressoutView:_updateCell(view, cell, data)
	if data then
		self:_clearCell(cell)

		local item = goutil.findChild(cell, "item")

		MaterialMgr.setCellByCfg(data.matStr, item)

		local txtName = goutil.findChildTextComponent(cell, "txtName")

		txtName.text = data.dressCfg.name
	end
end

function DressoutView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

return DressoutView
