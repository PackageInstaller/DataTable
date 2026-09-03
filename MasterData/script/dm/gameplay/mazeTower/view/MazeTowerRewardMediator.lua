-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/mazeTower/view/MazeTowerRewardMediator.lua

MazeTowerRewardMediator = class("MazeTowerRewardMediator", DmPopupViewMediator, _M)

MazeTowerRewardMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
MazeTowerRewardMediator:has("_mazeTowerSystem", {
	is = "r"
}):injectWith("MazeTowerSystem")

local kCellWidth, kCellHeight = 704, 72

function MazeTowerRewardMediator:initialize()
	super.initialize(self)
end

function MazeTowerRewardMediator:dispose()
	super.dispose(self)
end

function MazeTowerRewardMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")
	self._cellPanel = self:getView():getChildByName("cellpanel")

	self._cellPanel:setVisible(false)
end

function MazeTowerRewardMediator:enterWithData(data)
	self._mazeTower = self._mazeTowerSystem:getMazeTower()
	self._taskList = self._mazeTower:getSortTaskList()

	self:setupView()
	self:createTableView()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_TOWER_GETREWARD, self, self.onGetRewardSucc)
end

function MazeTowerRewardMediator:setupView()
	local bgNode = self._main:getChildByName("bg_node")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		bgSize = {
			width = 820,
			height = 570
		},
		title = Strings:get("Maze_Reward"),
		title1 = Strings:get("MiniGame_Reward_UI2")
	})
end

function MazeTowerRewardMediator:createTableView()
	local cellSize = self._cellPanel:getContentSize()

	local function scrollViewDidScroll(table)
		return
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return cellSize.width, cellSize.height
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if not cell then
			cell = cc.TableViewCell:new()

			local panel = self._cellPanel:clone()

			panel:setVisible(true)
			panel:setPosition(cc.p(0, 0))
			panel:addTo(cell)
			panel:setTag(123)
			panel:setSwallowTouches(false)
		end

		self:refreshCell(cell:getChildByTag(123), idx + 1)

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._taskList
	end

	local tableView = cc.TableView:create(cc.size(cellSize.width, 380))

	tableView:setTag(1234)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(cc.p(221, 77))
	tableView:setDelegate()
	self._main:addChild(tableView, 999)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)

	self._tableView = tableView

	tableView:reloadData()
end

function MazeTowerRewardMediator:refreshCell(cell, index)
	local taskData = self._taskList[index]
	local bgImg = cell:getChildByName("bgImage")
	local bgImg2 = cell:getChildByName("bgImage2")

	bgImg:setVisible(index % 2 == 1)
	bgImg2:setVisible(index % 2 == 0)

	local descText = cell:getChildByName("desclabel")

	descText:setString(Strings:get("Maze_Reward_Desc", {
		Num = taskData:getCondition()[1].factor1[1]
	}))

	local rewardPanel = cell:getChildByName("reward")

	rewardPanel:removeAllChildren()

	if taskData:getReward() then
		local rewardList = taskData:getReward()

		for i, reward in pairs(rewardList) do
			local rewardIcon = IconFactory:createRewardIcon(reward, {
				isWidget = true
			})

			rewardPanel:addChild(rewardIcon)
			rewardIcon:setAnchorPoint(cc.p(0, 0.5))
			rewardIcon:setPosition(cc.p(0 + (i - 1) * 80, 35))
			rewardIcon:setScaleNotCascade(0.55)
			IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), reward, {
				needDelay = true
			})
		end
	end

	local getBtn = cell:getChildByName("btn_get")
	local getImg = cell:getChildByName("Image_received")
	local unFinishText = cell:getChildByName("unFinish")
	local status = taskData:getStatus()

	getBtn:setVisible(status == TaskStatus.kFinishNotGet)
	getImg:setVisible(status == TaskStatus.kGet)
	unFinishText:setVisible(status == TaskStatus.kUnfinish)

	local function callFunc(sender, eventType)
		self:onGetTaskRewardClicked(taskData)
	end

	mapButtonHandlerClick(nil, getBtn, {
		func = callFunc
	})
end

function MazeTowerRewardMediator:onClickClose()
	self:close()
end

function MazeTowerRewardMediator:onGetTaskRewardClicked(taskData)
	local params = {
		taskId = taskData:getId()
	}

	self._mazeTowerSystem:requestTaskReward(params)
end

function MazeTowerRewardMediator:onGetRewardSucc(event)
	local data = event:getData()
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		rewards = data.rewards
	}))

	self._taskList = self._mazeTower:getSortTaskList()

	self._tableView:reloadData()
end
