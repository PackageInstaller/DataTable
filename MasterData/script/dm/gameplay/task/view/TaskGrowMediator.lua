-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/task/view/TaskGrowMediator.lua

TaskGrowMediator = class("TaskGrowMediator", DmAreaViewMediator, _M)

TaskGrowMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kBtnHandlers = {
	["main.btn_left"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickLeft"
	},
	["main.btn_right"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRight"
	}
}
local kMaxCellCount = 6
local kMoveCellCount = 4
local addCount = ConfigReader:getDataByNameIdAndKey("ConfigValue", "LevelTask_ShowUnlockLevel", "content")

function TaskGrowMediator:initialize()
	super.initialize(self)
end

function TaskGrowMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	self._main = self:getView():getChildByName("main")
	self._leftBtn = self._main:getChildByName("btn_left")
	self._rightBtn = self._main:getChildByName("btn_right")
	self._titleImage = self._main:getChildByName("Image_title")
	self._taskPanel = self._main:getChildByName("Panel_task")
	self._scrollView = self._main:getChildByName("ScrollView")
	self._cellPanel = self._main:getChildByName("Panel_cell")
	self._unlockPanel = self._main:getChildByName("Panel_unlock")
	self._cangetPanel = self._main:getChildByName("canget")
	self._conditionClone = self._taskPanel:getChildByName("condition")
	self._taskRewardPanel = self._taskPanel:getChildByName("Panel_reward")
	self._systemImg = self._main:getChildByFullName("leftPanel")
	self._sysDesc = self._main:getChildByFullName("leftPanel.desc")
	self._rolePanel = self._main:getChildByName("Panel_roletips")
	self._roleQipaoImg = self._rolePanel:getChildByName("Image_qipao")
	self._conditionPanel = self._taskPanel:getChildByName("conditionPanel")

	self:setAllPanelInvisible()
	self._scrollView:addEventListener(function(sender, eventType)
		self:refreshArrow()
	end)
end

function TaskGrowMediator:setAllPanelInvisible()
	self._leftBtn:setVisible(false)
	self._rightBtn:setVisible(false)
	self._rolePanel:setVisible(false)
	self._scrollView:setVisible(false)
	self._cellPanel:setVisible(false)
	self._roleQipaoImg:setVisible(false)
	self._conditionClone:setVisible(false)
	self._taskRewardPanel:setVisible(false)
end

function TaskGrowMediator:dispose()
	self._closeView = true

	self:removeTimeScheduler()
	super.dispose(self)
end

function TaskGrowMediator:setupView(parentMedi, data)
	self._parentMediator = parentMedi
	self._taskListModel = parentMedi:getTaskListModel()
	self._taskSystem = parentMedi:getTaskSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_TASK_REFRESHVIEW, self, self.updateView)

	if data then
		self._selectTag = data.growSelectTag or self._taskSystem:getStartIndexForGrow()
	end

	self._systemlist, self._unlockCount = self._taskSystem:getUnlockSystemListForGrow()

	self:createAnimView()
	self:showUnlockPanel(self._selectTag)
	self:setLabelStyle()
end

function TaskGrowMediator:refreshView()
	self:setAllPanelInvisible()
	self:createAnimView()
end

function TaskGrowMediator:setLabelStyle()
	local goText = self._taskRewardPanel:getChildByFullName("btn_go.Text_1")

	GameStyle:setGreenCommonEffect(goText, {
		fontSize = 26
	})
end

function TaskGrowMediator:refreshDescPanel()
	local systemData = self._systemlist[self._selectTag]

	if self._systemImg then
		self._systemImg:loadTexture("asset/ui/task/grow/" .. systemData.GrowTaskImage)
	end

	self._sysDesc:setString(Strings:get(systemData.LongDesc))
end

function TaskGrowMediator:createAnimView()
	self:refreshDescPanel()
	self:refreshRightPanel(self._selectTag, true)
	self:createScrollViewAnim()
end

local unlockBubbleDelayTime = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Task_BubbleChange_Time", "content")

function TaskGrowMediator:createTimeScheduler()
	self:removeTimeScheduler()

	local function update()
		local time = self._gameServerAgent:remoteTimestamp() - self._clickTime

		if time > unlockBubbleDelayTime then
			self._clickTime = self._gameServerAgent:remoteTimestamp()

			self:runQiPaoAction(self._selectTag)
		end
	end

	self._timeScheduler = LuaScheduler:getInstance():schedule(update, 1, true)
end

function TaskGrowMediator:removeTimeScheduler()
	if self._timeScheduler then
		self._timeScheduler:stop()

		self._timeScheduler = nil
	end
end

function TaskGrowMediator:runQiPaoAction(index)
	if self._qipaoImgClone then
		local systemData = self._systemlist[index]
		local tipsList = systemData.UnlockBubble
		local tipsText = self._qipaoImgClone:getChildByName("Text")

		if tipsList and #tipsList > 0 then
			local i = math.random(1, #tipsList)
			local tips = tipsList[i]

			tipsText:setString(Strings:get(tips))
		end

		self._qipaoImgClone:setVisible(true)
		self._qipaoImgClone:setOpacity(0)
		self._qipaoImgClone:setCascadeOpacityEnabled(true)

		local ani = cc.Sequence:create(cc.DelayTime:create(0.3), cc.FadeIn:create(0.3))

		self._qipaoImgClone:runAction(ani)
	end
end

function TaskGrowMediator:refreshRoleTipsPanel(index, hasAnim)
	if hasAnim then
		self._qipaoImgClone = self._roleQipaoImg

		self._qipaoImgClone:setVisible(true)

		local systemData = self._systemlist[index]
		local tipsList = systemData.UnlockBubble
		local tipsText = self._qipaoImgClone:getChildByName("Text")

		if tipsList and #tipsList > 0 then
			local i = math.random(1, #tipsList)
			local tips = tipsList[i]

			tipsText:setString(Strings:get(tips))
		end

		self._clickTime = self._gameServerAgent:remoteTimestamp()

		self:createTimeScheduler()
	else
		self._clickTime = self._gameServerAgent:remoteTimestamp()

		self:createTimeScheduler()
		self:runQiPaoAction(index)
	end
end

function TaskGrowMediator:createTaskListAnim()
	self._taskPanel:setVisible(true)
	self._rolePanel:setVisible(false)
	self._taskRewardPanel:setVisible(false)

	local clippingLayout = self._taskPanel:getChildByTag(354)

	if clippingLayout then
		clippingLayout:removeFromParent(true)
	end

	clippingLayout = ccui.Layout:create()

	clippingLayout:setAnchorPoint(0, 1)
	clippingLayout:addTo(self._taskPanel):setPosition(3, 400)
	clippingLayout:setClippingEnabled(true)
	clippingLayout:setContentSize(cc.size(430, 400))
	clippingLayout:setLocalZOrder(300)

	clippingLayout.cellAnim = cc.MovieClip:create("chengzhangrenwudh_chengzhangtupo")

	clippingLayout.cellAnim:setPlaySpeed(1.4)
	clippingLayout.cellAnim:addTo(clippingLayout):center(clippingLayout:getContentSize()):offset(20, 15)
	clippingLayout.cellAnim:setLocalZOrder(100)
	clippingLayout:setTag(354)

	local systemData = self._systemlist[self._selectTag]
	local rewardNode = clippingLayout.cellAnim:getChildByName("reward")

	if rewardNode then
		local taskRewardClone = self._taskRewardPanel:clone()

		self:decorateRewardPanel(taskRewardClone, systemData, true)
		taskRewardClone:addTo(rewardNode):center(rewardNode:getContentSize()):offset(-10, -19)
	end

	clippingLayout.cellAnim:gotoAndPlay(1)
	clippingLayout.cellAnim:addCallbackAtFrame(21, function(fid, mc, frameIndex)
		clippingLayout.cellAnim:stop()
		clippingLayout.cellAnim:removeFromParent(true)
		self:createTaskListView()
	end)
end

function TaskGrowMediator:decorateConditionCell(conditionCell, taskData, index)
	local taskValueList = taskData:getTaskValueList()
	local taskValue = taskValueList[index]
	local value = taskData:getCondition()[index]
	local descText = conditionCell:getChildByName("Text_desc")
	local conditionkeeper = self:getInjector():getInstance(Conditionkeeper)
	local str = conditionkeeper:getConditionDesc(value)

	descText:setString(str)

	local progText = conditionCell:getChildByName("Text_progress")

	progText:enableOutline(cc.c4b(35, 15, 5, 127), 2)
	progText:setString(taskValue.currentValue .. "/" .. taskValue.targetValue)

	if taskValue.currentValue > taskValue.targetValue then
		progText:setString(taskValue.targetValue .. "/" .. taskValue.targetValue)
	end
end

function TaskGrowMediator:decorateRewardPanel(taskRewardPanel, systemData, hideDoneAnim)
	taskRewardPanel:setVisible(true)

	local taskData = self._taskListModel:getTaskById(systemData.Task)
	local rewards = taskData:getReward()
	local rewardPanel = taskRewardPanel:getChildByName("reward")

	rewardPanel:removeAllChildren(true)

	for i = 1, #rewards do
		local reward = rewards[i]
		local icon = IconFactory:createRewardIcon(reward, {
			isWidget = true
		})

		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
			needDelay = true
		})
		icon:setScaleNotCascade(0.8)
		rewardPanel:addChild(icon)
		icon:setAnchorPoint(cc.p(0, 0.5))
		icon:posite((i - 1) * 73, 35)
	end

	local getBtn = taskRewardPanel:getChildByName("Button_get")

	getBtn:addClickEventListener(function()
		self:onClickGetReward(taskData)
	end)
	getBtn:setSaturation(taskData:getStatus() == TaskStatus.kUnfinish and -100 or 0)
	getBtn:setVisible(taskData:getStatus() ~= TaskStatus.kGet)

	local donePanel = taskRewardPanel:getChildByName("doneanim")

	donePanel:setVisible(false)

	if taskData:getStatus() == TaskStatus.kGet and not hideDoneAnim then
		donePanel:setVisible(true)
	end

	local goBtn = taskRewardPanel:getChildByName("btn_go")

	goBtn:addClickEventListener(function()
		self:onClickGoBtn(systemData)
	end)

	if systemData.Link ~= nil and systemData.Link ~= "" then
		goBtn:setVisible(taskData:getStatus() == TaskStatus.kUnfinish)
	else
		goBtn:setVisible(false)
	end
end

function TaskGrowMediator:createTaskListView()
	local systemData = self._systemlist[self._selectTag]

	self._taskPanel:setVisible(true)
	self._rolePanel:setVisible(false)

	local taskData = self._taskListModel:getTaskById(systemData.Task)

	self._conditionPanel:removeAllChildren(true)

	for i, value in pairs(taskData:getCondition()) do
		local conditionCell = self._conditionClone:clone()

		conditionCell:setVisible(true)
		self:decorateConditionCell(conditionCell, taskData, i)
		self._conditionPanel:addChild(conditionCell)
		conditionCell:setPosition(cc.p(0, 70 - (i - 1) * conditionCell:getContentSize().height))
	end

	self:decorateRewardPanel(self._taskRewardPanel, systemData)
end

function TaskGrowMediator:refreshRightPanel(index, hasAnim)
	local tag = index or self._selectTag
	local systemData = self._systemlist[tag]
	local unlock = self._systemKeeper:isUnlock(systemData.Id)

	if unlock then
		self:createTaskListAnim()
	else
		self._taskPanel:setVisible(false)
		self._rolePanel:setVisible(true)
		self._rolePanel:setTouchEnabled(true)
		self._rolePanel:addClickEventListener(function()
			self:onClickRole(tag)
		end)
		self:refreshRoleTipsPanel(tag, hasAnim)
	end
end

local huizhangOffset = {
	{
		x = 2,
		y = -3.3
	},
	{
		x = -1,
		y = -3.3
	},
	{
		x = -4,
		y = -3.3
	},
	{
		x = -7,
		y = -2.5
	},
	{
		x = -10,
		y = -3.3
	},
	{
		x = 0,
		y = -3
	}
}

function TaskGrowMediator:createScrollViewAnim()
	local clippingLayout = self._main:getChildByTag(333)

	if clippingLayout then
		clippingLayout:removeFromParent(true)
	end

	clippingLayout = ccui.Layout:create()

	clippingLayout:setAnchorPoint(0, 1)
	clippingLayout:addTo(self._main):setPosition(154, 170)
	clippingLayout:setClippingEnabled(true)
	clippingLayout:setContentSize(cc.size(930, 180))
	clippingLayout:setLocalZOrder(300)

	clippingLayout.cellAnim = cc.MovieClip:create("xintubdh_chengzhangtupo")

	clippingLayout.cellAnim:setPlaySpeed(1.4)
	clippingLayout.cellAnim:addTo(clippingLayout):center(clippingLayout:getContentSize()):offset(-16, -10)
	clippingLayout.cellAnim:setLocalZOrder(100)
	clippingLayout:setTag(333)

	local startIndex = self:getStartAnimCellIndex()
	local cellsNum = math.min(self._unlockCount + addCount, #self._systemlist)
	local animCellNum = math.min(cellsNum - startIndex, kMaxCellCount)
	local leftNode = clippingLayout.cellAnim:getChildByName("left")

	if leftNode then
		local leftClone = self._leftBtn:clone()

		leftClone:setScale(-1, 0.8)
		leftClone:addTo(leftNode):center(leftNode:getContentSize()):offset(12, -12)
		leftClone:setVisible(startIndex ~= 1)
	end

	local rightNode = clippingLayout.cellAnim:getChildByName("right")

	if rightNode then
		local rightClone = self._rightBtn:clone()

		rightClone:addTo(rightNode):center(rightNode:getContentSize()):offset(20, 2)
		rightClone:setVisible(cellsNum > startIndex + kMaxCellCount)
	end

	for i = 1, animCellNum do
		local animNode = clippingLayout.cellAnim:getChildByName("cell" .. i)

		if animNode then
			animNode:removeChildByTag(123, true)

			local cell = self._cellPanel:clone()

			cell:setVisible(true)
			self:refreshCell(cell, startIndex)

			if self:hasRedPoint(startIndex) then
				local redNode = cc.Sprite:createWithSpriteFrameName(IconFactory.redPointPath)

				redNode:setScale(0.8)
				redNode:setPosition(100, 95)
				redNode:addTo(cell, 999)
			end

			cell:addTo(animNode):center(animNode:getContentSize()):offset(huizhangOffset[i].x, huizhangOffset[i].y)
			cell:setTag(123)

			startIndex = startIndex + 1
		end
	end

	clippingLayout.cellAnim:gotoAndPlay(1)
	clippingLayout.cellAnim:addCallbackAtFrame(22, function(fid, mc, frameIndex)
		clippingLayout.cellAnim:stop()
		clippingLayout.cellAnim:removeFromParent(true)
		self:initScrollView()
		self:relocationScrollView()
		self:refreshArrow()
	end)
end

local kCellWidth, kCellHeight = 131, 163
local basePosX, basePosY = 80.5, 68

function TaskGrowMediator:initScrollView()
	if not self._systemCells then
		local scrollSize = self._scrollView:getContentSize()

		self._systemCells = {}

		local cellsNum = math.min(self._unlockCount + addCount, #self._systemlist)

		self._showCount = cellsNum

		for i = 1, cellsNum do
			self:addItemToScrollView(i)
		end

		self._scrollView:setInnerContainerSize(cc.size(kCellWidth * cellsNum + basePosX, scrollSize.height))
		self._scrollView:setScrollBarEnabled(false)
	end

	self._scrollView:setVisible(true)
end

function TaskGrowMediator:hasRedPoint(index)
	local systemData = self._systemlist[index]

	if systemData and systemData.Task then
		local taskData = self._taskListModel:getTaskById(systemData.Task)

		if taskData:getStatus() == TaskStatus.kFinishNotGet then
			return true
		else
			return false
		end
	else
		return false
	end
end

function TaskGrowMediator:addItemToScrollView(index)
	local cell = self._cellPanel:clone()

	cell:setVisible(true)

	self._systemCells[#self._systemCells + 1] = cell

	self._scrollView:addChild(cell, 1, index)
	cell:setPosition(basePosX + (index - 1) * kCellWidth, basePosY)
	self:refreshCell(cell, index)
	cell:setSwallowTouches(false)
	cell:addClickEventListener(function()
		self:onClickLevelCell(index)
	end)

	local node = RedPoint:createDefaultNode(IconFactory.redPointPath)
	local redPoint = RedPoint:new(node, cell, function()
		return self:hasRedPoint(index)
	end)

	redPoint:setScale(0.8)
	redPoint:posite(100, 95)
end

function TaskGrowMediator:refreshCell(cell, index)
	local systemData = self._systemlist[index]

	if systemData then
		local unlock = self._systemKeeper:isUnlock(systemData.Id)
		local taskData = self._taskListModel:getTaskById(systemData.Task)
		local conditionLabel = cell:getChildByName("condition")

		conditionLabel:setVisible(not unlock)

		local condition = systemData.Condition

		if condition.LEVEL then
			conditionLabel:setString("Lv." .. condition.LEVEL)
		end

		if condition.STAGE then
			local stageSystem = self:getInjector():getInstance("StageSystem")
			local point = stageSystem:getPointById(condition.STAGE)
			local var_32_0 = {}

			var_32_0.index = point:getOwner():getIndex() .. "-" .. point:getIndex()

			conditionLabel:setString(Strings:get("Task_Text2", var_32_0))
		end

		local sysName = cell:getChildByName("sysname")

		sysName:setString(Strings:get(systemData.Desc))

		local unlockImg = cell:getChildByName("Image_lock")

		unlockImg:setVisible(not unlock)

		local doneImg = cell:getChildByName("Image_done")

		doneImg:setVisible(taskData and taskData:getStatus() == TaskStatus.kGet)

		local iconBgDark = cell:getChildByName("huizhang_dark")
		local iconBgLight = cell:getChildByName("huizhang_light")

		iconBgDark:setVisible(self._selectTag ~= index)
		iconBgLight:setVisible(self._selectTag == index)

		local iconImg = cell:getChildByName("Image_icon")
		local icon = cc.Sprite:create("asset/ui/task/grow/" .. systemData.Icon)

		if icon and unlock then
			icon:addTo(iconImg):center(iconImg:getContentSize())
		end
	end
end

function TaskGrowMediator:refreshSelect()
	for i = 1, self._showCount do
		local cell = self._systemCells[i]
		local iconBgDark = cell:getChildByName("huizhang_dark")
		local iconBgLight = cell:getChildByName("huizhang_light")

		iconBgDark:setVisible(self._selectTag ~= i)
		iconBgLight:setVisible(self._selectTag == i)

		local selectImg = cell:getChildByName("xuanzhong")

		selectImg:setVisible(self._selectTag == i)
	end
end

function TaskGrowMediator:showUnlockPanel(index)
	local systemData = self._systemlist[index]
	local nameText = self._unlockPanel:getChildByName("systemname")

	nameText:setString(Strings:get(systemData.Desc))

	local unlockTips = self._unlockPanel:getChildByName("unlocktips")

	if systemData.Condition then
		if systemData.Condition.LEVEL then
			unlockTips:setString(Strings:get("Task_UI20", {
				level = systemData.Condition.LEVEL
			}))
		elseif systemData.Condition.STAGE then
			local stageSystem = self:getInjector():getInstance("StageSystem")
			local point = stageSystem:getPointById(systemData.Condition.STAGE)
			local var_34_0 = "Task_Text2"
			local var_34_1 = {}

			var_34_1.index = point:getOwner():getIndex() .. "-" .. point:getIndex()

			local str = Strings:get(var_34_0, var_34_1)

			unlockTips:setString(Strings:get("Task_UI22", {
				factor = str
			}))
		end
	end

	unlockTips:setPositionX(nameText:getPositionX() + nameText:getContentSize().width + 10)
	self:showCangetPanel(index)
end

function TaskGrowMediator:showCangetPanel(index)
	local systemData = self._systemlist[index]
	local rewardId = systemData.RewardShow

	self._cangetPanel:setVisible(rewardId ~= nil and rewardId ~= "")
	self._sysDesc:setVisible(not self._cangetPanel:isVisible())

	local rewards = RewardSystem:getRewardsById(rewardId)

	self._cangetPanel:setVisible(false)

	if reward then
		self._cangetPanel:setVisible(true)

		for i = 1, 3 do
			local iconBg = self._cangetPanel:getChildByName("icon" .. i)

			iconBg:removeAllChildren()

			local rewardData = rewards[i]

			if rewardData then
				local icon = IconFactory:createRewardIcon(rewardData, {
					showAmount = true,
					isWidget = true
				})

				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self._parentMediator), rewardData, {
					needDelay = true
				})
				icon:setScale(0.45)
				icon:addTo(iconBg):center(iconBg:getContentSize()):offset(0, -2)
			end
		end
	end
end

function TaskGrowMediator:updateView()
	if self._systemCells then
		self:refreshRightPanel(self._selectTag)

		local cell = self._systemCells[self._selectTag]

		if cell then
			self:refreshCell(cell, self._selectTag)
		end
	end
end

function TaskGrowMediator:refreshArrow()
	local leftBtn = self._main:getChildByName("btn_left")
	local rightBtn = self._main:getChildByName("btn_right")

	leftBtn:setVisible(true)
	rightBtn:setVisible(true)

	local offsetX = self._scrollView:getInnerContainer():getPositionX()
	local containerSize = self._scrollView:getInnerContainerSize()
	local viewSize = self._scrollView:getContentSize()

	if offsetX <= viewSize.width - containerSize.width then
		rightBtn:setVisible(false)
	end

	if offsetX >= 0 then
		leftBtn:setVisible(false)
	end

	if self._showCount < kMaxCellCount then
		leftBtn:setVisible(false)
		rightBtn:setVisible(false)
	end
end

function TaskGrowMediator:onClickGoBtn(data)
	local unlock, tips = self._systemKeeper:isUnlock(data.Id)

	if not unlock then
		if tips then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = tips
			}))
		end
	elseif data.Link then
		AudioEngine:getInstance():playEffect("Se_Click_Story_Common", false)

		local context = self:getInjector():instantiate(URLContext)
		local entry, params = UrlEntryManage.resolveUrlWithUserData(data.Link)

		if entry then
			entry:response(context, params)
		end
	end
end

function TaskGrowMediator:onClickLevelCell(data)
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	if self._selectTag == data then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	self._selectTag = data

	self:refreshRightPanel(self._selectTag, true)
	self:showUnlockPanel(self._selectTag)
	self:refreshSelect()
	self:refreshDescPanel()
	self:dispatch(Event:new(EVT_REDPOINT_REFRESH))
end

function TaskGrowMediator:onClickGetReward(data)
	AudioEngine:getInstance():playEffect("Se_Click_Get", false)

	if data:getStatus() == TaskStatus.kFinishNotGet then
		self._taskSystem:requestTaskReward({
			taskId = data:getId()
		})
	elseif data:getStatus() == TaskStatus.kUnfinish then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("Task_Text1")
		}))
	end
end

function TaskGrowMediator:showTips(tipsParam, data)
	if data.ResourceType == KSourceType.kMain or data.ResourceType == KSourceType.kElite then
		self:dispatch(Event:new(EVT_SHOW_TIP, {
			tipsCode = tipsParam
		}))
	else
		self:dispatch(Event:new(EVT_SHOW_TIP, {
			text = tipsParam
		}))
	end
end

function TaskGrowMediator:onClickLeft(sender, eventType)
	self:moveTableViewByDirection(true)
end

function TaskGrowMediator:onClickRight(sender, eventType)
	self:moveTableViewByDirection(false)
end

function TaskGrowMediator:onClickRole(index)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self:refreshRoleTipsPanel(index)
end

function TaskGrowMediator:getStartAnimCellIndex()
	local cellsNum = math.min(self._unlockCount + addCount, #self._systemlist)
	local startIndex = 1

	if cellsNum > kMaxCellCount then
		if self._selectTag > kMaxCellCount / 2 then
			startIndex = 1 + self._selectTag - kMaxCellCount / 2
		end

		if self._selectTag > cellsNum - kMaxCellCount / 2 then
			startIndex = cellsNum % kMaxCellCount + 1
		end
	end

	return startIndex
end

function TaskGrowMediator:relocationScrollView()
	local startIndex = self:getStartAnimCellIndex()
	local offsetX = (startIndex - 1) * kCellWidth
	local containerSize = self._scrollView:getInnerContainerSize()
	local viewSize = self._scrollView:getContentSize()
	local maxX = containerSize.width - viewSize.width

	if maxX < offsetX then
		offsetX = maxX
	end

	if offsetX < 0 then
		offsetX = 0
	end

	if maxX > 0 then
		local percent = math.abs(offsetX) / maxX

		self._scrollView:jumpToPercentHorizontal(percent * 100)
	end
end

function TaskGrowMediator:moveTableViewByDirection(isLeft, count, time)
	count = count or kMoveCellCount
	count = math.min(count, kMoveCellCount)
	time = time or 0.1

	if self._scrollView:getNumberOfRunningActions() > 0 then
		return
	end

	local offsetX = self._scrollView:getInnerContainer():getPositionX()
	local value = math.abs(offsetX) / kCellWidth

	value = math.floor(value)
	offsetX = isLeft and offsetX + count * kCellWidth or offsetX - count * kCellWidth

	local containerSize = self._scrollView:getInnerContainerSize()
	local viewSize = self._scrollView:getContentSize()

	offsetX = math.max(offsetX, viewSize.width - containerSize.width)
	offsetX = math.min(offsetX, 0)

	local percent = math.abs(offsetX) / (containerSize.width - viewSize.width)

	if time > 0 then
		self._scrollView:scrollToPercentHorizontal(percent * 100, time, false)
	else
		self._scrollView:jumpToPercentHorizontal(percent * 100)
	end

	self:refreshArrow()
end
