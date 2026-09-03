-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tests/view/TestMultiCellMediator.lua

TestMultiCellMediator = class("TestMultiCellMediator", DmPopupViewMediator)

TestMultiCellMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
TestMultiCellMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local kBtnHandlers = {}

function TestMultiCellMediator:initialize()
	super.initialize(self)
end

function TestMultiCellMediator:dispose()
	super.dispose(self)
end

function TestMultiCellMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function TestMultiCellMediator:mapEventListeners()
	return
end

function TestMultiCellMediator:enterWithData(data)
	self:setupView()
end

function TestMultiCellMediator:setupView()
	self._cell_1 = self:getChildView("Panel_base.Panel_cell_1")
	self._cell_2 = self:getChildView("Panel_base.Panel_cell_2")
	self._cell_3 = self:getChildView("Panel_base.Panel_cell_3")
	self._cellSize1 = self._cell_1:getContentSize()
	self._cellSize2 = self._cell_2:getContentSize()
	self._cellSize3 = self._cell_3:getContentSize()
	self._cellArray = {
		self._cell_1,
		self._cell_2,
		self._cell_3
	}
	self._cellSizeArray = {
		self._cellSize1,
		self._cellSize2,
		self._cellSize3
	}
	self._cellClass = {
		TestMultiCell_1,
		TestMultiCell_2,
		TestMultiCell_3
	}
	self._testDataOfMultiTypeCell = {
		1,
		3,
		2,
		2,
		3,
		1,
		2,
		1,
		3,
		2,
		3,
		1,
		2,
		3,
		1,
		3,
		3,
		1,
		1,
		2,
		3,
		1
	}

	self:createTestTableView()
end

function TestMultiCellMediator:createTestTableView()
	local listLocator = self:getChildView("Panel_base.Panel_listLocator")

	if not listLocator then
		return
	end

	local viewSize = listLocator:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	local function numberOfCells(view)
		return #self._testDataOfMultiTypeCell
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, index)
		index = index + 1

		local size = self._cellSizeArray[self._testDataOfMultiTypeCell[index]]

		return size.width, size.height + 5
	end

	local function cellAtIndex(tableView, index)
		index = index + 1

		local targetTypeTag = self._testDataOfMultiTypeCell[index]
		local cell = tableView:dequeueCellByTag(targetTypeTag)

		if cell == nil then
			cell = cc.TableViewCell:new()

			cell:setTag(targetTypeTag)

			local realCell = self._cellArray[targetTypeTag]:clone()

			realCell:setPosition(0, 0)
			realCell:setVisible(true)

			cell.m_cellMediator = self:getInjector():instantiate(self._cellClass[targetTypeTag], {
				view = realCell
			})

			cell:addChild(realCell)
		end

		local data = self._testDataOfMultiTypeCell[index]

		cell.m_cellMediator:update(data, index)

		return cell
	end

	local function onScroll()
		return
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setPosition(listLocator:getPosition())
	tableView:setDelegate()
	listLocator:getParent():addChild(tableView)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:reloadData()

	return tableView
end
