-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityPuzzleGameTaskMediator.lua

ActivityPuzzleGameTaskMediator = class("ActivityPuzzleGameTaskMediator", DmPopupViewMediator)

ActivityPuzzleGameTaskMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityPuzzleGameTaskMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kTabBtnData = {
	Strings:get("Pass_UI29"),
	Strings:get("Pass_UI30"),
	Strings:get("Pass_UI46")
}
local kBtnHandlers = {
	["main.btn_close"] = {
		ignoreClickAudio = true,
		func = "onCloseClicked"
	}
}

function ActivityPuzzleGameTaskMediator:initialize()
	super.initialize(self)
end

function ActivityPuzzleGameTaskMediator:dispose()
	super.dispose(self)
end

function ActivityPuzzleGameTaskMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PUZZLEGAME_TASK_REFRESH, self, self.doViewRefresh)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_REFRESH, self, self.doViewRefresh)
end

function ActivityPuzzleGameTaskMediator:removeTableView()
	self:getView():stopAllActions()

	if self._tableView then
		self._tableView:removeFromParent()

		self._tableView = nil
	end
end

function ActivityPuzzleGameTaskMediator:enterWithData()
	self:initData()
	self:initWidget()
	self:initTableView()
end

function ActivityPuzzleGameTaskMediator:doViewRefresh()
	self:refreshData()
	self:refreshView()
end

function ActivityPuzzleGameTaskMediator:initData()
	self._activity = self._activitySystem:getActivityByType(ActivityType.KPuzzleGame)
	self._taskList = {}
	self._taskList = self._activity:getAllTaskList()
end

function ActivityPuzzleGameTaskMediator:refreshData()
	self._taskList = {}
	self._activity = self._activitySystem:getActivityByType(ActivityType.KPuzzleGame)
	self._taskList = self._activity:getAllTaskList()
end

function ActivityPuzzleGameTaskMediator:refreshView()
	if not self._tableView then
		self:initTableView()
	end

	self._tableView:reloadData()
	self._tableView:setTouchEnabled(true)
end

function ActivityPuzzleGameTaskMediator:initWidget()
	self._main = self:getView():getChildByName("main")
	self._viewPanel = self._main:getChildByFullName("viewPanel")
	self._cloneCell = self:getView():getChildByFullName("clonePanel")

	self._cloneCell:setVisible(false)

	self._cloneNodes = self:getView():getChildByFullName("cloneNode")

	self._cloneNodes:setVisible(false)

	self._titleNode = self._main:getChildByFullName("title_node")

	local config = {
		title = Strings:get("Puzzle_Source_title"),
		title1 = Strings:get("Puzzle_Source_title_EN")
	}

	self._titleNode:setVisible(true)
	self._titleNode:setLocalZOrder(3)

	local injector = self:getInjector()
	local titleWidget = injector:injectInto(TitleWidget:new(self._titleNode))

	titleWidget:updateView(config)
end

function ActivityPuzzleGameTaskMediator:initTableView()
	local viewSize = self._viewPanel:getContentSize()
	local width, height = viewSize.width, self._cloneCell:getContentSize().height

	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function numberOfCells(view)
		return #self._taskList
	end

	local function cellSize(table, idx)
		return width, 130
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		local index = idx + 1

		self:createCell(cell, index)

		return cell
	end

	local tableView = cc.TableView:create(viewSize)

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:addTo(self._viewPanel)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:setMaxBounceOffset(20)
	tableView:reloadData()

	self._tableView = tableView
end

function ActivityPuzzleGameTaskMediator:createCell(cell, index)
	cell:removeAllChildren()

	local oneTask = self._taskList[index]
	local panel = self._cloneCell:clone()

	panel:setTag(123)
	panel:setVisible(true)
	panel:addTo(cell):posite(0, 0)

	local progress = panel:getChildByName("progress")
	local taskValueStr = string.format("(%d/%d)", oneTask:getTaskValueList()[1].currentValue, oneTask:getTaskValueList()[1].targetValue)

	progress:setString(taskValueStr)

	local desc = panel:getChildByName("desc")

	desc:setString(Strings:get(oneTask:getDesc()))
	progress:setPositionX(desc:getPositionX() + desc:getContentSize().width + 5)

	local rewardPanel = panel:getChildByName("reward")

	rewardPanel:removeAllChildren()

	local testReward = oneTask:getReward()

	if testReward ~= nil then
		local taskRewards = oneTask:getReward().Content

		for i = 1, #taskRewards do
			local reward = taskRewards[i]
			local rewardIcon = IconFactory:createIcon({
				id = reward.code,
				amount = reward.amount
			}, {
				isWidget = true
			})

			IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), reward, {
				showAmount = false,
				needDelay = true
			})
			rewardPanel:addChild(rewardIcon)
			rewardIcon:setAnchorPoint(cc.p(0.5, 0.5))

			local posX = 100 * (i - 1) + 30

			rewardIcon:setPosition(cc.p(posX, 35))
			rewardIcon:setScale(0.5)
		end
	end

	local state = oneTask:getStatus()

	panel:removeChildByName("StatusBtn")

	if state == TaskStatus.kUnfinish then
		if oneTask:getDestUrl() ~= nil and oneTask:getDestUrl() ~= "" then
			local btnPanel = self._cloneNodes:getChildByFullName("gotoBtn"):clone()

			btnPanel:addTo(panel):setName("StatusBtn")

			local btn = btnPanel:getChildByName("button")

			btn:addTouchEventListener(function(sender, eventType)
				self:onClickGoTo(sender, eventType, oneTask)
			end)
			btn:setSwallowTouches(false)
		end
	elseif state == TaskStatus.kFinishNotGet then
		local btnPanel = self._cloneNodes:getChildByFullName("getBtn"):clone()

		btnPanel:addTo(panel):setName("StatusBtn")

		local btn = btnPanel:getChildByName("button")

		btn:addTouchEventListener(function(sender, eventType)
			self:onClickGetReward(sender, eventType, oneTask)
		end)
		btn:setSwallowTouches(false)
	else
		local btn = self._cloneNodes:getChildByFullName("doneanim"):clone()

		btn:addTo(panel):setName("StatusBtn")
	end
end

function ActivityPuzzleGameTaskMediator:onClickGetReward(sender, eventType, data)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Get", false)

		if self._isReturn and data:getStatus() == TaskStatus.kFinishNotGet then
			self._activitySystem:requestGetPuzzleTaskReward(self._activity:getId(), data:getId(), nil)
		end
	end
end

function ActivityPuzzleGameTaskMediator:onClickGoTo(sender, eventType, data)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Story_Common", false)

		if self._isReturn then
			local url = data:getDestUrl()

			if url then
				local context = self:getInjector():instantiate(URLContext)
				local entry, params = UrlEntryManage.resolveUrlWithUserData(url)

				if not entry then
					self:dispatch(ShowTipEvent({
						tip = Strings:get("Function_Not_Open")
					}))
				else
					entry:response(context, params)
				end
			end
		end
	end
end

function ActivityPuzzleGameTaskMediator:onCloseClicked(sender, eventType)
	AudioEngine:getInstance():playEffect("Se_Click_Close_2", false)
	self:close()
end
