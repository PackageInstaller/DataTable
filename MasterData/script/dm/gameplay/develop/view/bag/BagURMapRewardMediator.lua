-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/bag/BagURMapRewardMediator.lua

BagURMapRewardMediator = class("BagURMapRewardMediator", PopupViewMediator, _M)

BagURMapRewardMediator:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")
BagURMapRewardMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.drawBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickReward"
	},
	["main.back"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickBack"
	}
}

function BagURMapRewardMediator:initialize()
	super.initialize(self)
end

function BagURMapRewardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TASK_REWARD_SUCC, self, self.onGetRewardCallback)

	self._bagSystem = self._developSystem:getBagSystem()

	self:initUI()
end

function BagURMapRewardMediator:enterWithData(data)
	self._callback = data.call

	self._bagSystem:setURMapCountKeyValue()

	self._taskList = self._taskSystem:getTaskListByType(TaskType.kURMap)

	self:refreshView()

	local space = self._itemCell:getContentSize().height
	local curIndex = self:getSelectIndex()

	if curIndex == -1 then
		curIndex = self:getCurIndex()
	end

	if curIndex > 3 then
		local maxOffset = self._tableView:minContainerOffset().y

		self._tableView:setContentOffset(cc.p(0, maxOffset + space * (curIndex - 3)))
	end
end

function BagURMapRewardMediator:initUI()
	self._main = self:getView():getChildByName("main")
	self._listView = self._main:getChildByName("panel")
	self._itemCell = self._main:getChildByName("Panel_clone")

	self._itemCell:setVisible(false)
end

function BagURMapRewardMediator:getCurIndex()
	local curNum = #self._taskList

	for i, data in ipairs(self._taskList) do
		local TaskValue = data:getTaskValueList()
		local tar = TaskValue[1].targetValue

		if tar > self._bagSystem:getURCount() then
			curNum = i - 1

			break
		end
	end

	return curNum
end

function BagURMapRewardMediator:getSelectIndex()
	local curNum = -1

	for i, data in ipairs(self._taskList) do
		local state = data:getStatus()

		if state == TaskStatus.kFinishNotGet then
			return i
		end
	end

	return curNum
end

function BagURMapRewardMediator:refreshView()
	self:createTableView()
	self:setOneKeyVisible()

	local title = self._main:getChildByName("desc")

	title:setString(Strings:get("URMap_UI6", {
		num = self._bagSystem:getURCount()
	}))
end

function BagURMapRewardMediator:createTableView()
	local size = self._itemCell:getContentSize()
	local tableView = cc.TableView:create(self._listView:getContentSize())

	local function numberOfCells(view)
		return #self._taskList
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		return size.width, size.height
	end

	local function cellAtIndex(table, idx)
		local index = idx + 1
		local cell = table:dequeueCell()

		if not cell then
			cell = cc.TableViewCell:new()

			cell:setLocalZOrder(#self._taskList - idx)

			local cloneCell = self._itemCell:clone()

			cloneCell:setVisible(true)
			cloneCell:addTo(cell):setName("main")
			cloneCell:setPosition(cc.p(0, 4))
		end

		self:updataCell(cell, index)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:setAnchorPoint(cc.p(0.5, 0.5))
	tableView:setPosition(cc.p(8, 0))
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:addTo(self._listView)
	tableView:reloadData()
	tableView:setBounceable(false)

	self._tableView = tableView
end

function BagURMapRewardMediator:updataCell(cell, index)
	local clonePanel = cell:getChildByName("main")
	local data = self._taskList[index]
	local TaskValue = data:getTaskValueList()
	local state = data:getStatus()
	local lightBar = clonePanel:getChildByName("lightBar")
	local darkBar = clonePanel:getChildByName("darkBar")
	local darkMark = clonePanel:getChildByName("darkMark")
	local frontLight = clonePanel:getChildByName("frontLight")
	local currentLight = clonePanel:getChildByName("currentLight")
	local curIndex = self:getCurIndex()

	if index == 1 then
		lightBar:setVisible(false)
		darkBar:setVisible(false)
		darkMark:setVisible(true)
		frontLight:setVisible(false)
		currentLight:setVisible(false)

		if index < curIndex then
			frontLight:setVisible(true)
		elseif curIndex == index then
			currentLight:setVisible(true)
		end
	else
		lightBar:setVisible(false)
		darkBar:setVisible(false)
		darkMark:setVisible(false)
		frontLight:setVisible(false)
		currentLight:setVisible(false)

		if index < curIndex then
			frontLight:setVisible(true)
			lightBar:setVisible(true)
		elseif curIndex == index then
			currentLight:setVisible(true)
			lightBar:setVisible(true)
		else
			darkMark:setVisible(true)
			darkBar:setVisible(true)
		end
	end

	local name = clonePanel:getChildByName("name")

	name:setString(Strings:get("URMap_UI9", {
		num = TaskValue[1].targetValue
	}))

	local onescore = clonePanel:getChildByName("oneScore")

	onescore:setString(TaskValue[1].targetValue)

	local list = clonePanel:getChildByName("ListView_1")

	list:removeAllChildren()
	list:setScrollBarEnabled(false)
	list:setSwallowTouches(false)

	local rewards = data:getReward()

	if rewards then
		for i = 1, #rewards do
			local reward = rewards[i]

			if reward then
				local layout = ccui.Layout:create()

				layout:setContentSize(cc.size(78, 88))

				local rewardIcon = IconFactory:createRewardIcon(reward, {
					showAmount = true,
					isWidget = true
				})

				rewardIcon:setScale(0.5)
				rewardIcon:addTo(layout):center(layout:getContentSize()):offset(0, 8)
				list:pushBackCustomItem(layout)
				IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), rewards[i], {
					needDelay = true
				})
			end
		end
	end

	local btnGet = clonePanel:getChildByName("getBtn")

	btnGet:setSwallowTouches(false)
	btnGet:setVisible(false)

	local btngo = clonePanel:getChildByName("gotoBtn")

	btngo:setVisible(false)

	local getDone = clonePanel:getChildByName("doneanim")

	getDone:setVisible(false)

	if state == TaskStatus.kFinishNotGet then
		btnGet:setVisible(true)
	elseif state == TaskStatus.kGet then
		getDone:setVisible(true)
	elseif state == TaskStatus.kUnfinish then
		btngo:setVisible(true)
	end

	btnGet:addClickEventListener(function(sender, eventType)
		AudioEngine:getInstance():playEffect("Se_Click_Get", false)
		self._taskSystem:requestTaskReward({
			taskId = data:getId()
		})
	end)
end

function BagURMapRewardMediator:setOneKeyVisible()
	return
end

function BagURMapRewardMediator:onClickReward()
	local hasRedPoint = self._taskSystem:hasUnreceivedTask(TaskType.kURMap)

	if hasRedPoint then
		self._taskSystem:oneKeyURTaskReward()
	else
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Task_Receive_All_Tips")
		}))
	end
end

function BagURMapRewardMediator:refreshReward()
	local offY = self._tableView:getContentOffset().y

	self._tableView:reloadData()
	self._tableView:setContentOffset(cc.p(0, offY))
	self:setOneKeyVisible()
end

function BagURMapRewardMediator:onGetRewardCallback(event)
	local response = event:getData().response
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = response
	}))
	self:refreshReward()
end

function BagURMapRewardMediator:onClickBack()
	if self._callback then
		self._callback()
	end

	self:close()
end
