-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/common/MiniGameRewardListMediator.lua

MiniGameRewardListMediator = class("MiniGameRewardListMediator", DmPopupViewMediator)

MiniGameRewardListMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
MiniGameRewardListMediator:has("_miniGameSystem", {
	is = "r"
}):injectWith("MiniGameSystem")
MiniGameRewardListMediator:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")
MiniGameRewardListMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local boxRewardImg = {
	"renwu_icon_bx_1.png",
	"renwu_icon_bx_2.png",
	"renwu_icon_bx_3.png",
	"renwu_icon_bx_4.png",
	"renwu_icon_bx_5.png"
}

function MiniGameRewardListMediator:initialize()
	super.initialize(self)
end

function MiniGameRewardListMediator:dispose()
	super.dispose(self)
end

function MiniGameRewardListMediator:userInject()
	return
end

function MiniGameRewardListMediator:onRegister()
	super.onRegister(self)
end

function MiniGameRewardListMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self:getActivitySystem():getActivityById(self._activityId)
	self._taskListOj = self._activity:getTaskList()
	self._dailyTaskListOj = self._activity:getDailyTaskList()

	local mainPanel = self:getView():getChildByFullName("main")
	local bgNode = mainPanel:getChildByFullName("bg_node")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		bgSize = {
			width = 820,
			height = 570
		},
		title = Strings:get("MiniGame_Reward_UI1"),
		title1 = Strings:get("MiniGame_Reward_UI2")
	})

	self._mainPanel = self:getView():getChildByFullName("main")
	self._cellPanel = self._mainPanel:getChildByFullName("cellpanel")

	self._cellPanel:setVisible(false)

	self._rewardCell = self._mainPanel:getChildByName("rewardcell")

	self._rewardCell:setVisible(false)
	self:initLoadingBar()
	self:refreshScoreView()
	self:sortDailyTaskList()
	self:createTableView()
	self:refreshRewardView()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doRset)
end

function MiniGameRewardListMediator:doRset(event)
	self:sortDailyTaskList()
	self._tableView:reloadData()
	self:refreshScoreView()
	self:refreshRewardView()
end

local sortTask = {
	[ActivityTaskStatus.kFinishNotGet] = 3,
	[ActivityTaskStatus.kUnfinish] = 2,
	[ActivityTaskStatus.kGet] = 1
}

function MiniGameRewardListMediator:sortDailyTaskList()
	local list = self._dailyTaskListOj

	self._showList = {}

	for i = 1, #list do
		self._showList[#self._showList + 1] = list[i]
	end

	table.sort(self._showList, function(a, b)
		local status_A = a:getStatus()
		local status_B = b:getStatus()

		if sortTask[status_A] ~= sortTask[status_B] then
			return sortTask[status_A] > sortTask[status_B]
		else
			return a:getOrderNum() < b:getOrderNum()
		end

		return false
	end)
end

function MiniGameRewardListMediator:createTableView()
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

	local tableView = cc.TableView:create(cc.size(cellSize.width, 320))

	tableView:setTag(1234)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(cc.p(208, 60))
	tableView:setDelegate()
	self._mainPanel:addChild(tableView, 999)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)

	self._tableView = tableView

	tableView:reloadData()
end

function MiniGameRewardListMediator:refreshCell(cell, idx)
	local taskData = self._showList[idx]
	local descText = cell:getChildByName("desclabel")
	local conditionkeeper = self:getInjector():getInstance(Conditionkeeper)
	local str = conditionkeeper:getConditionDesc(taskData:getCondition()[1], taskData:getDesc())

	descText:setString(str)

	local rewardPanel = cell:getChildByName("reward")

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

	local taskValue = taskData:getTaskValueList()[1]
	local titleLabel = cell:getChildByFullName("proglabel")

	titleLabel:setString(Strings:get("MiniGame_Reward_UI4", {
		num1 = taskValue.currentValue,
		num2 = taskValue.targetValue
	}))

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

function MiniGameRewardListMediator:refreshScoreView()
	local combatLabel = self._mainPanel:getChildByFullName("scorelabel")

	combatLabel:setString(self._activity:getTotalScore())
end

function MiniGameRewardListMediator:initLoadingBar()
	self._rewardList = {}

	local loading = self._mainPanel:getChildByFullName("loading")
	local list = self._taskListOj

	table.sort(list, function(a, b)
		local aTaskValue = a:getTaskValueList()[1].targetValue
		local bTaskValue = b:getTaskValueList()[1].targetValue

		return aTaskValue < bTaskValue
	end)

	local loadingWidth = loading:getContentSize().width * loading:getScaleX()

	for i = 1, #list do
		local data = list[i]
		local cell = self._rewardCell:clone()

		cell:setVisible(true)
		cell:addTo(self._mainPanel):posite(285 + loadingWidth / #list * i, 387)

		local taskValue = data:getTaskValueList()[1]
		local scoreText = cell:getChildByName("Text_score")

		scoreText:setString(taskValue.targetValue)

		data.score = taskValue.targetValue

		local boxImg = ccui.ImageView:create(boxRewardImg[5 - #list + i], 1)

		boxImg:addTo(cell):posite(44, 73)
		boxImg:setScale(0.5)

		local redPoint = ccui.ImageView:create(IconFactory.redPointPath, 1)

		redPoint:addTo(cell):setName("redPoint")
		redPoint:setPosition(cc.p(75, 100))
		redPoint:setScale(0.65)

		local touchPanel = cell:getChildByName("touch")

		touchPanel:setTouchEnabled(true)

		local function callFunc(sender, eventType)
			self:onGetRewardClicked(data)
		end

		mapButtonHandlerClick(nil, touchPanel, {
			func = callFunc
		})

		self._rewardList[#self._rewardList + 1] = cell
	end
end

function MiniGameRewardListMediator:getRealPercent()
	local precent = 0
	local curdiffpercent = 0
	local onePercent = 100 / #self._taskListOj
	local score = self._activity:getTotalScore()

	for i = 1, #self._taskListOj do
		local scoreData = self._taskListOj[i]

		if score > scoreData.score then
			precent = onePercent * i
		else
			if score <= self._taskListOj[1].score then
				curdiffpercent = score / self._taskListOj[1].score * onePercent
			else
				local curdiffcount = score - self._taskListOj[i - 1].score
				local diffpercent = onePercent
				local diffcount = self._taskListOj[i].score - self._taskListOj[i - 1].score

				curdiffpercent = curdiffcount / diffcount * diffpercent
			end

			precent = precent + curdiffpercent

			break
		end
	end

	return precent
end

function MiniGameRewardListMediator:refreshRewardView()
	local list = self._taskListOj

	for i = 1, #list do
		local cell = self._rewardList[i]
		local status = list[i]:getStatus()
		local normalImg = cell:getChildByName("Image_normal")
		local canGetImg = cell:getChildByName("Image_canget")

		normalImg:setVisible(status ~= TaskStatus.kFinishNotGet)
		canGetImg:setVisible(status == TaskStatus.kFinishNotGet)

		local redPoint = cell:getChildByName("redPoint")

		redPoint:setVisible(status == TaskStatus.kFinishNotGet)

		local hasGetImg = cell:getChildByName("doneMark")

		hasGetImg:setLocalZOrder(10)
		hasGetImg:setVisible(status == TaskStatus.kGet)
	end

	local loading = self._mainPanel:getChildByFullName("loading")
	local percent = self:getRealPercent()

	loading:setPercent(percent)
end

function MiniGameRewardListMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end

function MiniGameRewardListMediator:onGetRewardClicked(data)
	local status = data:getStatus()
	local taskValue = data:getTaskValueList()[1]

	if status == TaskStatus.kFinishNotGet then
		self._miniGameSystem:requestActivityGameGetCumulativeReward(self._activityId, data:getId(), function(response)
			if response.resCode == GS_SUCCESS then
				self:refreshRewardView()

				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = response.data.reward
				}))
			end
		end)
	else
		local info = {
			descId = "Activity_Darts_UI_28",
			liveness = taskValue.targetValue,
			rewardId = data:getConfig().Reward,
			hasGet = status == TaskStatus.kGet
		}
		local view = self:getInjector():getInstance("TaskBoxView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, info))
	end
end

function MiniGameRewardListMediator:onGetTaskRewardClicked(data)
	local miniGameSystem = self:getInjector():getInstance(MiniGameSystem)

	miniGameSystem:requestActivityGameGetReward(self._activityId, data:getId(), function(response)
		self:sortDailyTaskList()
		self._tableView:reloadData()

		local view = self:getInjector():getInstance("getRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
			rewards = response.data.reward
		}))
	end)
end
