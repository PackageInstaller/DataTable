-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/plane/PlaneWarClubGameRewardsTipMediator.lua

PlaneWarClubGameRewardsTipMediator = class("PlaneWarClubGameRewardsTipMediator", DmPopupViewMediator, _M)

PlaneWarClubGameRewardsTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PlaneWarClubGameRewardsTipMediator:has("_miniGameSystem", {
	is = "r"
}):injectWith("MiniGameSystem")
PlaneWarClubGameRewardsTipMediator:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")

local kBtnHandlers = {}

function PlaneWarClubGameRewardsTipMediator:initialize()
	super.initialize(self)
end

function PlaneWarClubGameRewardsTipMediator:dispose()
	super.dispose(self)
end

function PlaneWarClubGameRewardsTipMediator:userInject()
	return
end

function PlaneWarClubGameRewardsTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlers(kBtnHandlers)
end

function PlaneWarClubGameRewardsTipMediator:enterWithData(data)
	self._planeWarSystem = self._miniGameSystem:getPlaneWarSystem()
	self._planeWarData = self._planeWarSystem:getClubGamePlaneData()
	self._taskListOj = self._planeWarSystem:getPlaneClubGameTaskListOj()
	self._scoreListOj = self._planeWarSystem:getPlaneClubGameScoreListOj()

	local mainPanel = self:getView():getChildByFullName("main")
	local bgNode = mainPanel:getChildByFullName("bg_node")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = bind1(self.onClickClose, self),
		title = Strings:get("43ef8a2e_e279_11e8_8383_7c04d0d9796c")
	})

	self._mainPanel = self:getView():getChildByFullName("main")
	self._cellPanel = self._mainPanel:getChildByFullName("cellpanel")

	local combatLabel = self._mainPanel:getChildByFullName("combatlabel")

	combatLabel:offset(3, 0)
	self._cellPanel:setVisible(false)
	self:initLoadingBar()
	self:refreshScoreView()
	self:sortTaskList()
	self:createTableView()
	self:refreshRewardView()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doRset)
end

function PlaneWarClubGameRewardsTipMediator:doRset(event)
	self._planeWarSystem:requestPlaneClubGameTaskList(function()
		self:sortTaskList()
		self._tableView:reloadData()
		self:refreshScoreView()
		self:refreshRewardView()
	end)
end

local sortTask = {
	[ActivityTaskStatus.kFinishNotGet] = 3,
	[ActivityTaskStatus.kUnfinish] = 2,
	[ActivityTaskStatus.kGet] = 1
}

function PlaneWarClubGameRewardsTipMediator:sortTaskList()
	local list = self._taskListOj:getTaskList()

	self._showList = {}

	for i = 1, #list do
		self._showList[#self._showList + 1] = list[i]
	end

	table.sort(self._showList, function(a, b)
		local status_A = a:getStatus()
		local status_B = b:getStatus()

		if sortTask[status_A] ~= sortTask[status_B] then
			return sortTask[status_A] > sortTask[status_B]
		end

		return a:getOrderNum() < b:getOrderNum()
	end)
end

function PlaneWarClubGameRewardsTipMediator:createTableView()
	local function scrollViewDidScroll(table)
		return
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return 645, 125
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		cell = cell or cc.TableViewCell:new()

		self:refreshCell(cell, idx + 1)

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._showList
	end

	local tableView = cc.TableView:create(cc.size(645, 326))

	tableView:setTag(1234)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(cc.p(250, 86))
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

function PlaneWarClubGameRewardsTipMediator:refreshCell(cell, idx)
	if not cell.panel then
		cell.panel = self._cellPanel:clone()

		cell.panel:setAnchorPoint(0.5, 0.5)
		cell.panel:setVisible(true)
		cell.panel:addTo(cell):center(cell:getContentSize()):offset(320, 60)
		cell.panel:setSwallowTouches(false)
	end

	local taskData = self._showList[idx]
	local status = taskData:getStatus()
	local parent = cell.panel
	local titleLabel = parent:getChildByFullName("titlelabel")

	titleLabel:setString(Strings:get(taskData:getName()))

	if not cell.descLabel then
		cell.descLabel = cc.Label:createWithTTF("", DEFAULT_TTF_FONT, 22)

		cell.descLabel:setAnchorPoint(0.5, 0.5)
		cell.descLabel:setColor(cc.c3b(102, 68, 45))
		cell.descLabel:addTo(parent):posite(120, 45)
	end

	local conditionList = taskData:getCondition()
	local conditionkeeper = self:getInjector():getInstance(Conditionkeeper)
	local desc = conditionkeeper:getConditionDesc(conditionList[1])

	cell.descLabel:setString(desc)

	if not cell.notGetLabel then
		cell.notGetLabel = cc.Label:createWithTTF(Strings:get("MythRank_UI_11"), DEFAULT_TTF_FONT, 22)

		cell.notGetLabel:setAnchorPoint(0, 0.5)
		cell.notGetLabel:setColor(cc.c3b(102, 68, 45))
		cell.notGetLabel:addTo(parent):posite(524, 45)
	end

	cell.notGetLabel:setVisible(status == ActivityTaskStatus.kUnfinish)

	if not cell.iconNode then
		cell.iconNode = cc.Node:create()

		cell.iconNode:addTo(parent):posite(60, 40)
	end

	local children = cell.iconNode:getChildren()

	for i = 1, #children do
		children[i]:setVisible(false)
	end

	local rewardList = taskData:getReward().Content

	for i = 1, #rewardList do
		local reward = rewardList[i]

		if not children[i] then
			children[i] = IconFactory:createRewardIcon(reward, {
				isWidget = true
			})

			children[i]:addTo(cell.iconNode)
		else
			children[i]:refreshReward(reward, {
				isWidget = true
			})
		end

		children[i]:setVisible(true)
		IconFactory:bindTouchHander(children[i], IconTouchHander:new(self), reward, {
			needDelay = true
		})
		children[i]:setScale(0.55)
		children[i]:setPosition(250 + (i - 1) * 68, 7)
	end

	if not cell.getBtnWidget then
		local btn = TwoLevelMainButton:createWidgetNode()

		btn:setScale(0.82)

		cell.getBtnWidget = TwoLevelMainButton:new(btn, {
			handler = bind1(self.onGetTaskRewardClicked, self)
		})

		cell.getBtnWidget:setContentWidth(154)
		btn:addTo(parent):posite(557, 43)
		cell.getBtnWidget:setButtonName(Strings:get("Club_Boss_UI26"))
	end

	cell.getBtnWidget:getButton().taskId = taskData:getId()

	cell.getBtnWidget:getView():setVisible(status == TaskStatus.kFinishNotGet)

	local hasReceivedImg = parent:getChildByFullName("has_received_img")

	hasReceivedImg:setVisible(status == TaskStatus.kGet)

	local taskValue = taskData:getTaskValueList()[1]
	local titleLabel = parent:getChildByFullName("jindulabel")

	titleLabel:setString(Strings:get("MiniPlaneText45", {
		num1 = taskValue.currentValue,
		num2 = taskValue.targetValue
	}))
end

function PlaneWarClubGameRewardsTipMediator:refreshScoreView()
	local combatLabel = self._mainPanel:getChildByFullName("combatlabel")

	combatLabel:setString(self._planeWarData:getWeeklyTotalScore())
end

function PlaneWarClubGameRewardsTipMediator:initLoadingBar()
	self._rewardList = {}

	local loading = self._mainPanel:getChildByFullName("loading")
	local config = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_PlaneWeekLyReward", "content")
	local list = self._scoreListOj:getList()
	local maxWidth = list[#list]:getAmount()
	local loadingWidth = loading:getContentSize().width * loading:getScaleX()

	for i = 1, #list do
		local data = list[i]
		local titleLabel = cc.Label:createWithTTF(data:getAmount(), DEFAULT_TTF_FONT, 18)

		titleLabel:setColor(cc.c3b(246, 163, 85))
		titleLabel:enableOutline(cc.c4b(90, 50, 23, 255), 2)

		local changeWidth = list[i]:getAmount()

		titleLabel:addTo(self._mainPanel, 999):posite(382 + loadingWidth * changeWidth / maxWidth, 427)

		local lineImg = cc.Sprite:createWithSpriteFrameName("lb_common_fenge01.png")

		lineImg:addTo(titleLabel):center(titleLabel:getContentSize()):offset(0, 26)

		local touImg = cc.Sprite:createWithSpriteFrameName("lb_task_richang_bt03.png")

		touImg:addTo(titleLabel):center(titleLabel:getContentSize()):offset(0, 14)

		local rewardId = list[i]:getRewardId()
		local rewardConfig = ConfigReader:getRecordById("Reward", rewardId)
		local reward = rewardConfig.Content[1]

		self._rewardList[i] = IconFactory:createRewardIcon(reward)

		IconFactory:bindTouchHander(self._rewardList[i], IconTouchHander:new(self), reward, {
			needDelay = true
		})
		self._rewardList[i]:setScale(0.55)
		self._rewardList[i]:addTo(titleLabel):center(titleLabel:getContentSize()):offset(0, 73)

		local redPoint = RedPoint:createDefaultNode()

		redPoint:setScale(1.2)
		redPoint:addTo(self._rewardList[i]):posite(92, 92)

		self._rewardList[i].redPoint = redPoint

		local touchPanel = ccui.Layout:create()

		touchPanel:setContentSize(cc.size(112, 112))
		touchPanel:addTo(self._rewardList[i]):posite(-2, -2)
		touchPanel:addTouchEventListener(function(sender, eventType)
			self:onGetRewardClicked(sender, eventType, data)
		end)
		touchPanel:setTouchEnabled(true)

		local hasGetImg = cc.Sprite:create("asset/ui/common/lang/img_common_get02.png")

		hasGetImg:addTo(self._rewardList[i], 999):center(self._rewardList[i]:getContentSize())
		hasGetImg:setScale(1.2)

		self._rewardList[i].hasGetImg = hasGetImg
		self._rewardList[i].touchPanel = touchPanel
	end
end

function PlaneWarClubGameRewardsTipMediator:refreshRewardView()
	local list = self._scoreListOj:getList()

	for i = 1, #list do
		local rewardIcon = self._rewardList[i]
		local status = self._planeWarSystem:getPlaneClubGameScoreStatusById(list[i]:getAmount())

		rewardIcon.redPoint:setVisible(status == TaskStatus.kFinishNotGet)
		rewardIcon.hasGetImg:setVisible(status == TaskStatus.kGet)
		self._rewardList[i].touchPanel:setVisible(status == TaskStatus.kFinishNotGet)
	end

	local loading = self._mainPanel:getChildByFullName("loading")
	local curScore = self._planeWarSystem:getClubGamePlaneData():getWeeklyTotalScore()
	local list = self._scoreListOj:getList()

	loading:setPercent(curScore / list[#list]:getAmount() * 100)
end

function PlaneWarClubGameRewardsTipMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end

function PlaneWarClubGameRewardsTipMediator:onGetRewardClicked(sender, eventType, data)
	if eventType == ccui.TouchEventType.ended then
		snkAudio.play("Se_Click_Common_1")
		self._miniGameSystem:requestClubGameCustom(self._planeWarData:getId(), {
			customType = 101,
			score = data:getAmount()
		}, function(response)
			if response.resCode == GS_SUCCESS then
				self:refreshRewardView()

				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
					rewards = response.data.rewards
				}))
			end
		end)
	end
end

function PlaneWarClubGameRewardsTipMediator:onGetTaskRewardClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		snkAudio.play("Se_Click_Common_1")

		local taskSystem = self:getInjector():getInstance(TaskSystem)

		taskSystem:requestTaskReward({
			taskId = sender.taskId
		}, function(response)
			self:sortTaskList()
			self._tableView:reloadData()

			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
				rewards = response.data.rewards
			}))
		end)
	end
end
