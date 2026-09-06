-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/usualviews/TableViewComponent.lua

module("logiccommon.common.viewlib.usualviews.TableViewComponent", package.seeall)

local TableViewComponent = class("TableViewComponent", ViewComponent)

function TableViewComponent:_getPath()
	return {
		cellPath = "",
		viewPath = ""
	}
end

function TableViewComponent:ctor()
	TableViewComponent.super.ctor(self)
end

function TableViewComponent:destroyUI()
	TableViewComponent.super.destroyUI(self)
	self._tableview:UnRegisterAllCallbacks()
end

function TableViewComponent:buildUI()
	local path = self:_getPath()

	print("path.viewPath:" .. path.viewPath)

	self._tableview = self:getGo(path.viewPath):GetComponent(ComponentType.UITableview)
	self._tableCell = self:getGo(path.cellPath)

	self._tableCell:SetActive(false)
	self:registCallbacks()
end

function TableViewComponent:onEnter()
	self._curViewDatas = {}
end

function TableViewComponent:registCallbacks()
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableview:RegisterUpdateCellCallback(self._onCellUpdate)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish)
end

function TableViewComponent:onExit()
	self:travel()

	self._curViewDatas = {}
end

function TableViewComponent:_numInView()
	if not self._curViewDatas then
		return 0
	end

	return #self._curViewDatas
end

function TableViewComponent:_cellSize(view, index)
	return 100, 100
end

function TableViewComponent:_cellAtIndex(view, idx)
	local cell
	local cell = view:DequeueCell()

	if not cell then
		cell = view:AddChild(self._tableCell)

		self:initCell(cell)
	end

	local data = self._curViewDatas[idx + 1]

	cell.data = idx + 1
	cell.index = idx

	self:_updateCell(view, cell, data)

	return cell
end

function TableViewComponent:_onCellUpdate(view, cell)
	local idx = cell.index
	local data = self._curViewDatas[idx + 1]

	cell.data = idx + 1

	self:_updateCell(view, cell, data)
end

function TableViewComponent:initCell(cell)
	return
end

function TableViewComponent:_updateCell(view, cell, data)
	return
end

function TableViewComponent:_onReloadFinish()
	return
end

function TableViewComponent:updateListData(list)
	self._curViewDatas = list

	self._tableview:ReloadData()
end

function TableViewComponent:reloadData()
	self._tableview:ReloadData()
end

function TableViewComponent:travel()
	self._tableview:Travel(self._clearTableview, self)
end

function TableViewComponent:_clearTableview(cell)
	return
end

function TableViewComponent:moveCellToCenter(index, offset)
	offset = offset or 0

	self._tableview:MoveCellToCebter(index - 1, offset)
end

return TableViewComponent
