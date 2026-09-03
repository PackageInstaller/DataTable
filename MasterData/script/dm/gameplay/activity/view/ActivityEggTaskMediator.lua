-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityEggTaskMediator.lua

ActivityEggTaskMediator = class("ActivityEggTaskMediator", DmPopupViewMediator, _M)

ActivityEggTaskMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

function ActivityEggTaskMediator:initialize()
	super.initialize(self)
end

function ActivityEggTaskMediator:dispose()
	super.dispose(self)
end

function ActivityEggTaskMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByFullName("main")
	self._cell = self._main:getChildByFullName("cell")

	self._cell:setVisible(false)
end

function ActivityEggTaskMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)
	self._showList = self._activity:getSortActivityList()

	self:mapEventListeners()
	self:setupView()
	self:createTableView()
end

function ActivityEggTaskMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.updateView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.updateView)
end

function ActivityEggTaskMediator:setupView()
	local bgNode = self._main:getChildByFullName("bg_node")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		bgSize = {
			width = 830,
			height = 580
		},
		title = Strings:get("Puzzle_Source_title")
	})
end

function ActivityEggTaskMediator:updateView()
	self._showList = self._activity:getSortActivityList()

	self._tableView:reloadData()
end

function ActivityEggTaskMediator:createTableView()
	local cellSize = self._cell:getContentSize()

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

			local panel = self._cell:clone()

			panel:setVisible(true)
			panel:setPosition(cc.p(0, 4))
			panel:addTo(cell)
			panel:setTag(123)
			panel:setSwallowTouches(false)
		end

		self:refreshCell(cell:getChildByTag(123), idx + 1)

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._showList
	end

	local tableView = cc.TableView:create(cc.size(cellSize.width, 390))

	tableView:setTag(1234)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(cc.p(243, 83))
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

function ActivityEggTaskMediator:refreshCell(cell, idx)
	local taskData = self._showList[idx]
	local taskValue = taskData:getTaskValueList()[1]
	local descText = cell:getChildByName("Text_desc")
	local conditionkeeper = self:getInjector():getInstance(Conditionkeeper)
	local str = conditionkeeper:getConditionDesc(taskData:getCondition()[1], taskData:getDesc())

	descText:setString(str .. "    " .. taskValue.currentValue .. "/" .. taskValue.targetValue)

	local condition = taskData:getCondition()[1]

	if condition.conditionType == "Condi_SumCharge" then
		descText:setString(str .. "    " .. taskValue.currentValue * 0.01 .. "/" .. taskValue.targetValue * 0.01)
	end

	local rewardPanel = cell:getChildByName("icon")

	rewardPanel:removeAllChildren()

	if taskData:getReward() then
		local rewardList = taskData:getReward().Content

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
	local getImg = cell:getChildByName("Image_done")
	local goBtn = cell:getChildByName("btn_go")
	local status = taskData:getStatus()

	getBtn:setVisible(status == TaskStatus.kFinishNotGet)
	getImg:setVisible(status == TaskStatus.kGet)
	goBtn:setVisible(status == TaskStatus.kUnfinish)

	local function callFunc(sender, eventType)
		self:onGetTaskRewardClicked(taskData)
	end

	mapButtonHandlerClick(nil, getBtn, {
		func = callFunc
	})

	local function callFunc(sender, eventType)
		self:onGoClicked(taskData)
	end

	mapButtonHandlerClick(nil, goBtn, {
		func = callFunc
	})
end

function ActivityEggTaskMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end

function ActivityEggTaskMediator:onGoClicked(data)
	local url = data:getDestUrl()
	local param = {}

	self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
		url = url,
		extParams = param
	}))
end

function ActivityEggTaskMediator:onGetTaskRewardClicked(data)
	local status = data:getStatus()

	if status == ActivityTaskStatus.kUnfinish then
		self:getEventDispatcher():dispatchEvent(ShowTipEvent({
			tip = Strings:get("Task_Text1")
		}))

		return
	end

	local data = {
		doActivityType = 101,
		taskId = data:getId()
	}

	self._activitySystem:requestDoActivity(self._activityId, data, function(response)
		if DisposableObject:isDisposed(self) then
			return
		end

		self:updateView()

		local view = self:getInjector():getInstance("getRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
			rewards = response.data.reward
		}))
	end)
end
