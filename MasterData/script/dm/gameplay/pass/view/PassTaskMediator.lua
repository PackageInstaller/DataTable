-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/pass/view/PassTaskMediator.lua

PassTaskMediator = class("PassTaskMediator", DmPopupViewMediator, _M)

PassTaskMediator:has("_passSystem", {
	is = "r"
}):injectWith("PassSystem")
PassTaskMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kTabBtnData = {
	Strings:get("Pass_UI29"),
	Strings:get("Pass_UI30"),
	Strings:get("Pass_UI46")
}
local kBtnHandlers = {}

function PassTaskMediator:initialize()
	super.initialize(self)
end

function PassTaskMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function PassTaskMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PASSPORT_REFRESH, self, self.doPassPortRefresh)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PASSPORT_TASK_REFRESH, self, self.doPassPortRefresh)
end

function PassTaskMediator:removeTableView()
	self:getView():stopAllActions()

	if self._tableView then
		self._tableView:removeFromParent()

		self._tableView = nil
	end
end

function PassTaskMediator:setTabIndex(index)
	self._tabIndex = index
end

function PassTaskMediator:stopEffect()
	return
end

function PassTaskMediator:setupView(parent)
	self._parent = parent

	self:initData()
	self:initWidget()
	self:initTableView()
	self:createTabController()
	self:refreshExpNode()
end

function PassTaskMediator:doPassPortRefresh()
	self:refreshData()
	self:refreshView()
end

function PassTaskMediator:initData()
	self._tabType = 1
	self._taskList = {}
	self._taskList = self._passSystem:getPassListModel():getPassTaskList()[self._tabType]

	if #self._passSystem:getPassListModel():getPassTaskList() < 3 then
		kTabBtnData = {
			Strings:get("Pass_UI29"),
			Strings:get("Pass_UI30")
		}
	end
end

function PassTaskMediator:initWidget()
	self._cloneNodes = self:getView():getChildByFullName("cloneNode")

	self._cloneNodes:setVisible(false)

	self._mainPanel = self:getView():getChildByFullName("main")
	self._expLabel = self._mainPanel:getChildByName("exp")
	self._viewPanel = self._mainPanel:getChildByName("panel")
	self._btnPanel = self._mainPanel:getChildByName("btnPanel")
	self._levelNode = self._mainPanel:getChildByName("levelNode")
	self._tabClone = self._btnPanel:getChildByFullName("tabClone")

	self._tabClone:setVisible(false)

	self._cloneCell = self._mainPanel:getChildByName("cloneCell")

	self._cloneCell:setVisible(false)
end

function PassTaskMediator:refreshExpNode()
	local expStr = string.format("%d/%d", self._passSystem:getExpWeek(), self._passSystem:getExpWeekLimit())

	self._expLabel:setString(expStr)
end

function PassTaskMediator:createTabController()
	self._ignoreRefresh = true
	self._tabBtns = self._tabBtns or {}
	self._ignoreSound = true

	for i = 1, #kTabBtnData do
		local name = kTabBtnData[i]
		local btn = self._tabClone:clone()

		btn:setVisible(true)
		btn:addTo(self._btnPanel:getChildByFullName("btnNodes"))

		local posX = -72 - (i - 1) * 140

		btn:setPosition(cc.p(posX, 0))
		btn:getChildByFullName("dark_1.time"):setString("")
		btn:getChildByFullName("dark_1.text"):setString(name)
		btn:getChildByFullName("light_1.text"):setString(name)
		btn:setVisible(true)
		btn:setTag(i)

		btn.index = i
		btn.redPoint = RedPoint:createDefaultNode()

		btn.redPoint:setScale(0.8)
		btn.redPoint:addTo(btn:getChildByFullName("dark_1")):posite(120, 27)
		btn.redPoint:setLocalZOrder(99900)

		self._tabBtns[i] = btn
	end

	self._tabController = TabController:new(self._tabBtns, function(name, tag)
		self:onClickTab(name, tag)
	end)

	self._tabController:selectTabByTag(self._tabType)
end

function PassTaskMediator:initTableView()
	local viewSize = self._viewPanel:getContentSize()
	local width, height = viewSize.width, self._cloneCell:getContentSize().height

	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function numberOfCells(view)
		return #self._taskList
	end

	local function cellSize(table, idx)
		return width, height
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

	self._tableView = tableView
end

function PassTaskMediator:createCell(cell, index)
	cell:removeAllChildren()

	local oneTask = self._taskList[index]
	local panel = self._cloneCell:clone()

	panel:setTag(123)
	panel:setVisible(true)
	panel:addTo(cell):posite(0, 0)

	local title = panel:getChildByName("title")

	title:setString(Strings:get(oneTask:getName()))

	local progress = panel:getChildByName("progress")
	local taskValueStr = string.format("%d/%d", oneTask:getTaskValueList()[1].currentValue, oneTask:getTaskValueList()[1].targetValue)

	progress:setString(taskValueStr)

	local desc = panel:getChildByName("desc")

	desc:setString(Strings:get(oneTask:getDesc()))

	local rewardPanel = panel:getChildByName("reward")

	rewardPanel:removeAllChildren()

	local testReward = oneTask:getReward()

	if testReward ~= nil then
		local taskRewards = oneTask:getReward().Content

		for i = 1, #taskRewards do
			local reward = taskRewards[i]

			reward = self._passSystem:chengRewardAmount(reward)

			local rewardIcon = IconFactory:createIcon({
				id = reward.code,
				amount = reward.amount
			}, {
				isWidget = true
			})

			IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self._parent), reward, {
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
			local btn = self._cloneNodes:getChildByFullName("gotoBtn"):clone()

			btn:addTo(panel):setName("StatusBtn")
			btn:addTouchEventListener(function(sender, eventType)
				self:onClickGoTo(sender, eventType, oneTask)
			end)
			btn:setSwallowTouches(false)
		end
	elseif state == TaskStatus.kFinishNotGet then
		local btn = self._cloneNodes:getChildByFullName("getBtn"):clone()

		btn:addTo(panel):setName("StatusBtn")
		btn:addTouchEventListener(function(sender, eventType)
			self:onClickGetReward(sender, eventType, oneTask)
		end)
		btn:setSwallowTouches(false)
	else
		local btn = self._cloneNodes:getChildByFullName("doneanim"):clone()

		btn:addTo(panel):setName("StatusBtn")
	end
end

function PassTaskMediator:refreshData(fromParent)
	self._taskList = {}

	if fromParent then
		self._tabType = 1

		self._tabController:selectTabByTag(self._tabType)
	end

	self._taskList = self._passSystem:getPassListModel():getPassTaskList()[self._tabType]
	self._showPassEnter, self._showPass, self._showPassShop = self._passSystem:checkShowPassAndPassShop()
end

function PassTaskMediator:refreshView(hasAnim, changeTab)
	if not self._tableView then
		self:initTableView()
	end

	if changeTab == nil or changeTab == false then
		self:refreshTime()
		self:refreshExpNode()
		self:refreshRedPoint()
	end

	if hasAnim then
		self:runStartAction()

		return
	end

	self._tableView:reloadData()
	self._tableView:setTouchEnabled(true)
end

function PassTaskMediator:refreshTime()
	if not self._timer then
		local function checkTimeFunc()
			local remoteTimestamp = self._passSystem:getCurrentTime()
			local refreshTiem = self._passSystem:getCurrentActivity():getEndTime() / 1000
			local remainTime = refreshTiem - remoteTimestamp

			if remainTime <= 0 then
				self._timer:stop()

				self._timer = nil

				return
			end

			for i = 1, #self._tabBtns do
				local btn = self._tabBtns[i]
				local oneTime = remainTime

				if i == 1 then
					oneTime = self._passSystem:getDailyResetTime() - remoteTimestamp
				end

				self:refreshRemainTime((i == 2 or nil) and self._passSystem:getWeekResetTime() - remoteTimestamp, btn)
			end
		end

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
	end
end

function PassTaskMediator:refreshRemainTime(remainTime, btn)
	if remainTime < 0 then
		remainTime = 0
	end

	local fmtStr = "${d}:${H}:${M}:${S}"
	local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
	local parts = string.split(timeStr, ":", nil, true)
	local timeTab = {}

	timeTab.day = tonumber(parts[1])
	timeTab.hour = tonumber(parts[2])
	timeTab.min = tonumber(parts[3])
	timeTab.sec = tonumber(parts[4])

	btn:getChildByFullName("dark_1.time"):setString(timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec"))
end

function PassTaskMediator:onClickTab(name, tag)
	self._tabType = tag

	if not self._ignoreSound then
		AudioEngine:getInstance():playEffect("Se_Click_Tab_5", false)
	else
		self._ignoreSound = false
	end

	if not self._ignoreRefresh then
		self:refreshData()
		self:refreshView(false, true)
	else
		self._ignoreRefresh = false
	end
end

function PassTaskMediator:onClickGetReward(sender, eventType, data)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Get", false)

		if self._isReturn and data:getStatus() == TaskStatus.kFinishNotGet then
			self._passSystem:requestGetTaskReward(self._tabType - 1, data:getId(), nil)
		end
	end
end

function PassTaskMediator:onClickGoTo(sender, eventType, data)
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

function PassTaskMediator:runStartAction()
	performWithDelay(self:getView(), function()
		self._tableView:stopScroll()
		self._tableView:reloadData()
		self:runListAnim()
	end, 0.16666666666666666)
end

function PassTaskMediator:runListAnim()
	local showNum = 4

	self._tableView:setTouchEnabled(false)

	local allCells = self._tableView:getContainer():getChildren()

	for i = 1, showNum do
		local child = allCells[i]

		if child and child:getChildByTag(123) then
			local child = child:getChildByTag(123)

			child:stopAllActions()
			child:setOpacity(0)
		end
	end

	local length = math.min(showNum, #allCells)
	local delayTime = 0.06666666666666667

	for i = 1, showNum do
		local child = allCells[i]

		if child and child:getChildByTag(123) then
			local child = child:getChildByTag(123)

			child:stopAllActions()

			local time = (i - 1) * delayTime
			local delayAction = cc.DelayTime:create(time)
			local callfunc = cc.CallFunc:create(function()
				CommonUtils.runActionEffect(child, "Node_1.myPetClone", "TaskDailyEffect", "anim1", false)
			end)
			local callfunc1 = cc.CallFunc:create(function()
				child:setOpacity(255)

				if length == i then
					self._tableView:setTouchEnabled(true)
				end
			end)
			local seq = cc.Sequence:create(delayAction, callfunc, callfunc1)

			child:runAction(seq)
		end
	end
end

function PassTaskMediator:refreshRedPoint()
	for i = 1, #self._tabBtns do
		local showRedPoint = false

		if i == 1 then
			showRedPoint = self._passSystem:checkIsHaveTaskRewardCanGet(PassTaskType.kDailyTask) and self._showPass
		end

		if i == 2 then
			showRedPoint = self._passSystem:checkIsHaveTaskRewardCanGet(PassTaskType.kWeekTask) and self._showPass
		end

		self._tabBtns[i].redPoint:setVisible((i == 3 or nil) and self._passSystem:checkIsHaveTaskRewardCanGet(PassTaskType.kMonthTask) and self._showPass)
	end
end
