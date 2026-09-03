-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tests/view/TestViewMediator.lua

TestViewMediator = class("TestViewMediator", DmPopupViewMediator)

TestViewMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
TestViewMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local cfgData = {
	{
		title = "设置单元调试模式,登录直接进入此界面届时可获取所有用户数据",
		func = function()
			_G.UNIT_TESTING = true
		end
	},
	{
		view = "TestMultiCellView",
		title = "多重cell复用事例",
		mode = EVT_SHOW_POPUP
	},
	{
		view = "TestEasyTabView",
		title = "简单的tabBar使用"
	},
	{
		view = "TestClippingNodeView",
		title = "遮罩效果"
	},
	{
		view = "TestLuaProfilerView",
		title = "代码性能分析luaProfiler事例"
	},
	{
		view = "TestPageView",
		title = "循环PageView事例"
	},
	{
		view = "TestCollectionView",
		title = "CollectionView事例(多行多列)"
	},
	{
		view = "TestTempView",
		title = "临时测试用的view,不上传"
	}
}
local kBtnHandlers = {}

function TestViewMediator:initialize()
	super.initialize(self)
end

function TestViewMediator:userInject()
	return
end

function TestViewMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function TestViewMediator:enterWithData(data)
	self:setupView()
end

function TestViewMediator:mapEventListeners()
	return
end

function TestViewMediator:setupView()
	self._tempCell = self:getChildView("Panel_cell")
	self._cellSize = self._tempCell:getContentSize()

	self:createTestTableView()
end

function TestViewMediator:dispose()
	super.dispose(self)
end

function TestViewMediator:createTestTableView()
	local listLocator = self:getChildView("Panel_listLocator")

	if not listLocator then
		return
	end

	local viewSize = listLocator:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	local function numberOfCells(view)
		return #cfgData
	end

	local function cellTouched(table, cell)
		local index = cell:getIdx()

		index = index + 1

		if cfgData[index].view then
			local view = self:getInjector():getInstance(cfgData[index].view)
			local event = ViewEvent:new(cfgData[index].mode or EVT_SHOW_POPUP, view)

			self:dispatch(event)
		end

		if cfgData[index].func then
			cfgData[index].func()
			self:dispatch(ShowTipEvent({
				tip = "执行操作成功",
				duration = 0.5
			}))
		end
	end

	local function cellSize(table, index)
		index = index + 1

		return self._cellSize.width, self._cellSize.height + 5
	end

	local function cellAtIndex(tableView, index)
		index = index + 1

		local cell = tableView:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local realCell = self._tempCell:clone()

			realCell:setPosition(0, 0)
			realCell:setVisible(true)

			cell.m_cellMediator = self:getInjector():instantiate(TestCell, {
				view = realCell
			})

			cell:addChild(realCell)
		end

		local data = cfgData[index]

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
