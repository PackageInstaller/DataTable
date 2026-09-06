-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stronger/view/StrongerScrollView.lua

module("logic.extensions.stronger.view.StrongerScrollView", package.seeall)

local StrongerScrollView = class("StrongerScrollView")

function StrongerScrollView:ctor()
	self._curViewDatas = {}
	self._updateCellHandler = {}
	self._updateCellHandlerObj = {}
end

function StrongerScrollView:buildUI(tableview, tableCell, tableCell2)
	self._tableview = tableview
	self._tableCell = tableCell
	self._tableCell2 = tableCell2

	goutil.setActive(self._tableCell)
	goutil.setActive(self._tableCell2)
end

function StrongerScrollView:onEnter(curViewDatas, updateCellHandler, handlerObj)
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	self._updateCellHandler = updateCellHandler
	self._updateCellHandlerObj = handlerObj

	self:refreshData(curViewDatas)
end

function StrongerScrollView:refreshData(curViewDatas)
	self._curViewDatas = curViewDatas

	self._tableview:ReloadData()
end

function StrongerScrollView:reloadData()
	self._tableview:ReloadData()
end

function StrongerScrollView:onExit()
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = {}
	self._updateCellHandler = nil
	self._updateCellHandlerObj = nil
end

function StrongerScrollView:destroyUI()
	self._tableview = nil
	self._tableCell = nil
	self._curViewDatas = nil
end

function StrongerScrollView:_numInView()
	return #self._curViewDatas
end

function StrongerScrollView:_cellSize(view, index)
	return 947, 120
end

function StrongerScrollView:_cellAtIndex(view, index)
	local data = self._curViewDatas[index + 1]
	local isShowCell2 = data.cfg.id == 1
	local cell

	if isShowCell2 then
		cell = view:DequeueCellByTag(101)

		if not cell then
			cell = view:AddChild(self._tableCell2)
			cell.tag = 101
		end

		cell.data = index + 1
		page = 2
	else
		cell = view:DequeueCellByTag(100)

		if not cell then
			cell = view:AddChild(self._tableCell)
			cell.tag = 100
		end

		cell.data = index + 1
		page = 1
	end

	self:_updateCell(view, cell, data)

	return cell
end

function StrongerScrollView:_updateCell(view, cell, data)
	if self._updateCellHandler then
		self._updateCellHandler(self._updateCellHandlerObj, view, cell, data)
	end
end

function StrongerScrollView:_clearTableview(cell)
	Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGo"):RemoveClickListener()

	local icon = goutil.findChild(cell, "bg/icon")

	uGuiUtil.clearImage(icon)
end

return StrongerScrollView
