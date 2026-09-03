-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/task/view/TaskAchieveMediator.lua

TaskAchieveMediator = class("TaskAchieveMediator", DmAreaViewMediator, _M)

local kRightTabPos = {
	{
		cc.p(20, 297)
	},
	{
		cc.p(20, 342),
		cc.p(-13, 251)
	},
	{
		cc.p(20, 389),
		cc.p(-13, 298),
		cc.p(20, 207)
	},
	{
		cc.p(20, 432),
		cc.p(-13, 341),
		cc.p(20, 250),
		cc.p(-13, 159)
	},
	{
		cc.p(20, 480),
		cc.p(-13, 389),
		cc.p(20, 298),
		cc.p(-13, 207),
		cc.p(20, 116)
	}
}

function TaskAchieveMediator:initialize()
	super.initialize(self)
end

function TaskAchieveMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TASK_ACHI_REWARD_SUCC, self, self.updateViewByEvent)

	self._viewPanel = self:getView():getChildByName("viewPanel")
	self._tipImage = self:getView():getChildByName("tipImage")
	self._heroPanel = self:getView():getChildByName("heroPanel")
	self._heroLeft = self._heroPanel:getChildByName("hero_1")
	self._heroRight = self._heroPanel:getChildByName("hero_2")
	self._tabPanel = self:getView():getChildByName("tabPanel")
	self._totalProgress = self:getView():getChildByName("totalProgress")
	self._totalLabel = self._totalProgress:getChildByName("num")
	self._totalLabel1 = self._totalProgress:getChildByName("num_0")
	self._totalLoadingBar = self._totalProgress:getChildByName("loadingBar")
	self._clonePanel = self:getView():getChildByName("clonePanel")

	self._clonePanel:setVisible(false)

	self._tabClone = self:getView():getChildByName("tabClone")

	self._tabClone:setVisible(false)
	self._tabClone:getChildByFullName("dark_1.progress.loadingBar"):setScale9Enabled(true)
	self._tabClone:getChildByFullName("dark_1.progress.loadingBar"):setCapInsets(cc.rect(60, 3, 1, 1))
	self._clonePanel:getChildByFullName("unComplete.loadingBar"):setScale9Enabled(true)
	self._clonePanel:getChildByFullName("unComplete.loadingBar"):setCapInsets(cc.rect(60, 3, 1, 1))
	self._totalLoadingBar:setScale9Enabled(true)
	self._totalLoadingBar:setCapInsets(cc.rect(60, 3, 1, 1))
end

function TaskAchieveMediator:dispose()
	if self._tabController then
		self._tabController:dispose()

		self._tabController = nil
	end

	self:getView():stopAllActions()
	super.dispose(self)
end

function TaskAchieveMediator:removeTableView()
	self:getView():stopAllActions()

	if self._tableView then
		self._tableView:removeFromParent()

		self._tableView = nil
	end
end

function TaskAchieveMediator:setupView(parentMedi)
	local width = self._tipImage:getPositionX() - self._viewPanel:getPositionX() + 42

	self._viewPanel:setContentSize(cc.size(width, 340))

	self._parentMedi = parentMedi
	self._tabType = 1
	self._taskListModel = parentMedi:getTaskListModel()
	self._taskSystem = parentMedi:getTaskSystem()

	self:refreshData()
	self:initTabController()
end

function TaskAchieveMediator:initTabController()
	self._tabBtns = {}
	self._tabProgress = {}
	self._invalidTabBtns = {}
	self._cacheViewsName = {}
	self._ignoreSound = true

	for i = 1, #self._taskArr do
		local btn = self._tabClone:clone()

		if btn then
			btn:setVisible(true)
			btn:setTag(i)
			btn:getChildByFullName("light_1.text"):setString(self._taskArr[i].name)
			btn:getChildByFullName("light_1.text1"):setString(self._taskArr[i].name1)
			btn:getChildByFullName("dark_1.text"):setString(self._taskArr[i].name)
			btn:getChildByFullName("dark_1.text1"):setString(self._taskArr[i].name1)

			self._tabBtns[#self._tabBtns + 1] = btn
			self._tabProgress[#self._tabProgress + 1] = btn:getChildByFullName("dark_1.progress")
			btn.redPoint = RedPoint:createDefaultNode()

			btn.redPoint:setScale(0.8)
			btn.redPoint:addTo(btn:getChildByFullName("dark_1")):posite(150, 30)
			btn.redPoint:setLocalZOrder(99900)
			btn:addTo(self._tabPanel)
			btn:setPosition(cc.p(159 * i - 30, -3))
		end
	end

	self._tabController = TabController:new(self._tabBtns, function(name, tag)
		self:onClickTab(name, tag)
	end)

	self._tabController:setInvalidButtons(self._invalidTabBtns)
	self._tabController:selectTabByTag(self._tabType)
end

function TaskAchieveMediator:createTableView()
	local cellWidth = self._clonePanel:getContentSize().width
	local cellHeight = self._clonePanel:getContentSize().height

	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		if idx + 1 == #self._taskList and #self._taskList ~= 1 then
			return cellWidth + 30, cellHeight
		end

		return cellWidth, cellHeight
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local sprite = self._clonePanel:clone()

			sprite:setPosition(0, 0)
			cell:addChild(sprite)
			sprite:setVisible(true)
			sprite:setTag(12138)
		end

		local cell_Old = cell:getChildByTag(12138)

		self:createCell(cell_Old, idx + 1)
		cell:setTag(idx)

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._taskList
	end

	local tableView = cc.TableView:create(self._viewPanel:getContentSize())

	self._tableView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setPosition(0, 0)
	tableView:setAnchorPoint(0, 0)
	tableView:setMaxBounceOffset(36)
	tableView:setDelegate()
	self._viewPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
end

function TaskAchieveMediator:createCell(cell, idx)
	local taskData = self._taskList[idx]

	if taskData == nil then
		cell:setVisible(false)

		return
	end

	local taskStatus = taskData:getStatus()
	local complete = cell:getChildByName("complete")

	complete:setVisible(taskStatus == TaskStatus.kGet)

	local unComplete = cell:getChildByName("unComplete")

	unComplete:setVisible(taskStatus ~= TaskStatus.kGet)

	if unComplete:isVisible() then
		local taskValueList = taskData:getTaskValueList()
		local currentValue = taskValueList[1].currentValue
		local targetValue = taskValueList[1].targetValue

		unComplete:getChildByName("loadingBar"):setPercent(currentValue / targetValue * 100)

		local text, huge = CurrencySystem:formatCurrency(currentValue)
		local text1, huge1 = CurrencySystem:formatCurrency(targetValue)

		if huge then
			currentValue = text .. Strings:get("Common_Time_01")
		end

		if huge1 then
			targetValue = text1 .. Strings:get("Common_Time_01")
		end

		local progress1 = unComplete:getChildByName("progress_1")
		local progress2 = unComplete:getChildByName("progress_2")

		if getCurrentLanguage() ~= GameLanguageType.CN then
			progress1:setFontSize(23)
			progress2:setFontSize(14)
		end

		progress1:setString(currentValue)
		progress2:setString("/" .. targetValue)
		progress2:setPositionX(progress1:getPositionX() + progress1:getContentSize().width)
	end

	local completeImage = cell:getChildByName("completeImage")

	completeImage:setVisible(taskStatus == TaskStatus.kFinishNotGet)

	local amountBg = cell:getChildByName("amountBg")
	local amount = cell:getChildByName("amount")
	local iconPanel = cell:getChildByName("iconPanel")

	iconPanel:removeAllChildren()

	local rewards = taskData:getReward()[1]

	if rewards then
		local info = RewardSystem:parseInfo(rewards)
		local rewardIcon = IconFactory:createPic(info, {
			ignoreScaleSize = true,
			largeIcon = true
		})

		rewardIcon:setAnchorPoint(cc.p(0.5, 0.5))
		rewardIcon:addTo(iconPanel):center(iconPanel:getContentSize())
		rewardIcon:setScale(0.8)
		amount:setString(info.amount)

		local width = amountBg:getContentSize().width
		local scaleX = (amount:getContentSize().width + 16) / width

		amountBg:setScaleX(scaleX)
	end

	local desc = cell:getChildByName("desc")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		desc:setContentSize(cc.size(210, 50))
	end

	desc:setString("")

	local conditionKeeper = self:getInjector():getInstance(Conditionkeeper)
	local str = conditionKeeper:getConditionDesc(taskData:getCondition()[1])

	desc:setString(str)

	local achievementNum = cell:getChildByName("achievementNum")

	achievementNum:setString(taskData:getAchievePoint())

	local titleText = cell:getChildByName("name")

	titleText:setString(taskData:getName())
	cell:setSwallowTouches(false)
	cell:addTouchEventListener(function(sender, eventType)
		self:onClickCell(sender, eventType, taskData, idx)
	end)
end

function TaskAchieveMediator:refreshData()
	self._taskArr = self._taskListModel:getShowAchieveTask()

	if self._taskArr[self._tabType] then
		self._taskList = self._taskArr[self._tabType].taskList or {}
	end
end

function TaskAchieveMediator:refreshView(hasAnim)
	self:refreshData()
	self:removeTableView()
	self:createTableView()
	self:refreshProgress()
	self:refreshNum()
	self._totalProgress:stopAllActions()

	if hasAnim then
		self:runStartAction()
	else
		self._totalProgress:setOpacity(255)
		self._tableView:stopScroll()
		self._tableView:reloadData()
	end
end

function TaskAchieveMediator:refreshProgress()
	for i = 1, #self._tabProgress do
		local panel = self._tabProgress[i]
		local taskList = self._taskArr[i].taskList
		local achievePoint = self._taskArr[i].achievePoint
		local curAchievePoint = self._taskArr[i].curAchievePoint

		panel:getChildByName("loadingBar"):setPercent(curAchievePoint / achievePoint * 100)

		local progress = panel:getChildByName("progress")
		local text, huge = CurrencySystem:formatCurrency(curAchievePoint)
		local text1, huge1 = CurrencySystem:formatCurrency(achievePoint)

		if huge then
			curAchievePoint = text .. Strings:get("Common_Time_01")
		end

		if huge1 then
			achievePoint = text1 .. Strings:get("Common_Time_01")
		end

		local str = curAchievePoint .. "/" .. achievePoint

		progress:setString(str)
		self._tabBtns[i].redPoint:setVisible(self._taskSystem:hasRedPoint(taskList))
	end
end

function TaskAchieveMediator:updateView()
	self:refreshData()

	if self._tableView then
		self._tableView:stopScroll()
		self._tableView:reloadData()
	end

	self:refreshProgress()
	self:refreshNum()
end

function TaskAchieveMediator:refreshNum()
	local achievePoint = self._taskArr[self._tabType].achievePoint
	local curAchievePoint = self._taskArr[self._tabType].curAchievePoint
	local text, huge = CurrencySystem:formatCurrency(curAchievePoint)
	local text1, huge1 = CurrencySystem:formatCurrency(achievePoint)

	if huge then
		curAchievePoint = text .. Strings:get("Common_Time_01")
	end

	if huge1 then
		achievePoint = text1 .. Strings:get("Common_Time_01")
	end

	self._totalLabel:setString("/" .. achievePoint)
	self._totalLabel1:setString(curAchievePoint)
	self._totalLoadingBar:setPercent(curAchievePoint / achievePoint * 100)

	local posX = self._totalLabel:getPositionX() - self._totalLabel:getContentSize().width

	self._totalLabel1:setPositionX(posX)

	local posX = self._totalLabel1:getPositionX() - self._totalLabel1:getContentSize().width

	self._totalProgress:getChildByFullName("icon"):setPositionX(posX)
	self._totalProgress:getChildByFullName("text"):setString(self._taskArr[self._tabType].name)

	local posX = self._totalLabel:getPositionX() - self._totalLabel:getContentSize().width
end

function TaskAchieveMediator:showTalkAnim(index)
	if self._animIndex == index then
		return
	end

	self._animIndex = index

	if self._taskList[index] then
		self._heroPanel:stopAllActions()

		local action = cc.CSLoader:createTimeline("asset/ui/task_achievement.csb")

		self._heroPanel:runAction(action)
		action:gotoFrameAndPlay(0, 35, false)

		local taskData = self._taskList[index]
		local leftPic = taskData:getLeftPicture()
		local leftWord = taskData:getLeftWord()
		local rightPic = taskData:getRightPicture()
		local rightWord = taskData:getRightWord()
		local label = self._heroLeft:getChildByName("label")

		label:setString(leftWord)

		local heroPanel = self._heroLeft:getChildByName("heroIcon")

		heroPanel:removeAllChildren()

		local image = ccui.ImageView:create(leftPic)

		image:setScale(0.5)

		image = IconFactory:addStencilForIcon(image, 2, cc.size(97, 97))

		image:setAnchorPoint(cc.p(0.5, 0.5))
		image:addTo(heroPanel):center(heroPanel:getContentSize())

		label = self._heroRight:getChildByName("label")

		label:setString(rightWord)

		heroPanel = self._heroRight:getChildByName("heroIcon")

		heroPanel:removeAllChildren()

		image = ccui.ImageView:create(rightPic)

		image:setScale(0.5)

		image = IconFactory:addStencilForIcon(image, 2, cc.size(97, 97))

		image:setAnchorPoint(cc.p(0.5, 0.5))
		image:addTo(heroPanel):center(heroPanel:getContentSize())
	end
end

function TaskAchieveMediator:setBg(panel)
	panel:removeAllChildren()

	local bg = ccui.ImageView:create("asset/scene/renwu_bd_bj.jpg")

	bg:addTo(panel)
end

function TaskAchieveMediator:updateViewByEvent()
	self._animIndex = nil

	self:updateView()
end

function TaskAchieveMediator:onClickCell(sender, eventType, data, idx)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended and self._isReturn then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:showTalkAnim(idx)

		if data:getStatus() == TaskStatus.kFinishNotGet then
			local params = {
				taskId = data:getId()
			}

			self._taskSystem:requestAchievementReward(params, function()
				if DisposableObject:isDisposed(self) then
					return
				end

				self._parentMedi:setOneKeyGray()
			end)
		end

		self._isReturn = true
	end
end

function TaskAchieveMediator:onClickTab(name, tag)
	if not self._ignoreSound then
		self._animIndex = nil
		self._tabType = tag

		if self._taskArr[self._tabType] then
			self._taskList = self._taskArr[self._tabType].taskList or {}
		end

		AudioEngine:getInstance():playEffect("Se_Click_Tab_5", false)

		if self._tableView then
			local allCells = self._tableView:getContainer():getChildren()

			for i = 1, 5 do
				local child = allCells[i]

				if child and child:getChildByTag(12138) then
					child:getChildByTag(12138):stopAllActions()
					child:getChildByTag(12138):setOpacity(255)
					child:getChildByTag(12138):setPosition(cc.p(0, 0))
				end
			end

			self._tableView:stopScroll()
			self._tableView:reloadData()
		end

		self:refreshNum()
	else
		self._ignoreSound = false
	end
end

function TaskAchieveMediator:runStartAction()
	self._animIndex = 0

	self:showTalkAnim(1)
	self._totalProgress:setOpacity(0)
	performWithDelay(self:getView(), function()
		self._totalProgress:fadeIn({
			time = 0.2
		})
	end, 0.3333333333333333)
	performWithDelay(self:getView(), function()
		self._tableView:stopScroll()
		self._tableView:reloadData()
		self:runListAnim()
	end, 0.001)
end

function TaskAchieveMediator:runListAnim()
	self._tableView:setTouchEnabled(false)

	local allCells = self._tableView:getContainer():getChildren()

	for i = 1, 5 do
		local child = allCells[i]

		if child and child:getChildByTag(12138) then
			child:getChildByTag(12138):stopAllActions()
			child:getChildByTag(12138):setOpacity(0)
		end
	end

	local length = math.min(4, #allCells)
	local delayTime = 0.1

	for i = 1, 5 do
		local child = allCells[i]

		if child and child:getChildByTag(12138) then
			local node = child:getChildByTag(12138)

			node:stopAllActions()

			local delayAction = cc.DelayTime:create((i - 1) * delayTime)
			local callfunc = cc.CallFunc:create(function()
				CommonUtils.runActionEffect(node, "Node_1.myPetClone", "TaskDailyEffect", "anim1", false)
			end)
			local callfunc1 = cc.CallFunc:create(function()
				node:setOpacity(255)

				if length == i then
					self._tableView:setTouchEnabled(true)
					self:setupClickEnvs()
				end
			end)
			local seq = cc.Sequence:create(delayAction, callfunc, callfunc1)

			self:getView():runAction(seq)
		end
	end
end

function TaskAchieveMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local tapPanel = self._tabBtns[1]

		storyDirector:setClickEnv("TaskAchieveMediator.tapPanel", tapPanel, nil)

		local viewPanel = self._viewPanel

		storyDirector:setClickEnv("TaskAchieveMediator.viewPanel", viewPanel, nil)

		local allCells = self._tableView:getContainer():getChildren()

		if allCells[1] and allCells[1]:getChildByTag(12138) then
			local taskData = self._taskList[1]

			storyDirector:setClickEnv("TaskAchieveMediator.cell1", allCells[1]:getChildByTag(12138), function(sender, eventType)
				self:onClickCell(sender, ccui.TouchEventType.began, taskData, 1)
				self:onClickCell(sender, ccui.TouchEventType.ended, taskData, 1)
			end)
		end

		storyDirector:notifyWaiting("enter_TaskAchieveMediator")
	end))

	self:getView():runAction(sequence)
end
