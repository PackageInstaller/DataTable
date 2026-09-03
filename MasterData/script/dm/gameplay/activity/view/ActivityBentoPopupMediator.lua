-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityBentoPopupMediator.lua

ActivityBentoPopupMediator = class("ActivityBentoPopupMediator", DmPopupViewMediator)

ActivityBentoPopupMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityBentoPopupMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.bg.btn_close"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickClose"
	}
}

function ActivityBentoPopupMediator:initialize()
	super.initialize(self)
end

function ActivityBentoPopupMediator:dispose()
	super.dispose(self)
end

function ActivityBentoPopupMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._cellClone = self._main:getChildByName("cell")

	self._cellClone:setVisible(false)

	self._emptyPanel = self._main:getChildByName("Panel_empty")

	self._emptyPanel:setVisible(false)
end

function ActivityBentoPopupMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)
	self._tabType = data.tabType or 1
	self._bagSystem = self._developSystem:getBagSystem()

	self:updateData()
	self:createTableView()
	self:initTabController()
	self._main:getChildByFullName("bg.Text_title"):setString(Strings:get(self._activity:getTitle()))
end

function ActivityBentoPopupMediator:updateData()
	if self._tabType == 1 then
		self._list = self._activity:getSortActivityList()
	else
		self._list = {}

		local itemList = self._bagSystem:getEntryBySubType(ItemTypes.k_MINIGAME_ITEM)

		for i, v in pairs(itemList) do
			local count = self._bagSystem:getItemCount(v)

			if count > 0 then
				self._list[#self._list + 1] = {
					id = v,
					count = count
				}
			end
		end
	end
end

function ActivityBentoPopupMediator:initTabController()
	local tabBtns = {}

	for i = 1, 2 do
		local _btn = self:getView():getChildByFullName("main.btn_" .. i)

		tabBtns[#tabBtns + 1] = _btn

		_btn:setTag(i)

		local lightText = _btn:getChildByFullName("light_1.text")
		local darkText = _btn:getChildByFullName("dark_1.text")

		lightText:enableOutline(cc.c4b(3, 1, 4, 51), 1)
		lightText:setColor(cc.c4b(177, 235, 16, 255))
		lightText:enableShadow(cc.c4b(3, 1, 4, 25.5), cc.size(1, 0), 1)
		darkText:enableOutline(cc.c4b(3, 1, 4, 51), 1)
		darkText:setColor(cc.c4b(255, 255, 255, 255))
		darkText:enableShadow(cc.c4b(3, 1, 4, 25.5), cc.size(1, 0), 1)
	end

	self._tabController = TabController:new(tabBtns, function(name, tag)
		self:onClickTabBtn(name, tag)
	end)

	self._tabController:selectTabByTag(self._tabType)
end

function ActivityBentoPopupMediator:createTableView()
	local size = self._cellClone:getContentSize()

	local function scrollViewDidScroll(table)
		return
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return size.width, size.height
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if not cell then
			cell = cc.TableViewCell:new()

			local cloneCell = self._cellClone:clone()

			cloneCell:setVisible(true)
			cloneCell:addTo(cell):setTag(999)
			cloneCell:setPosition(cc.p(0, 4))
		end

		self:refreshCell(cell:getChildByTag(999), idx + 1)

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._list
	end

	local tableView = cc.TableView:create(cc.size(size.width, 346))

	tableView:setTag(1234)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(cc.p(325, 103))
	tableView:setDelegate()
	tableView:addTo(self._main)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)

	self._tableView = tableView

	tableView:reloadData()
end

function ActivityBentoPopupMediator:refreshCell(cell, index)
	local ownText = cell:getChildByName("Text_own")
	local statusPanel = cell:getChildByName("status")
	local nameText = cell:getChildByName("Text_name")
	local descText = cell:getChildByName("Text_desc")
	local iconDi = cell:getChildByName("Image_icondi")

	iconDi:removeAllChildren()

	local data = self._list[index]

	if self._tabType == 1 then
		ownText:setVisible(false)
		statusPanel:setVisible(true)
		nameText:setString(Strings:get(data:getName()))

		local conditionkeeper = self:getInjector():getInstance(Conditionkeeper)
		local str = conditionkeeper:getConditionDesc(data:getCondition()[1], data:getDesc())

		descText:setString(str)

		local iconPath = data:getTaskIcon()
		local taskIcon = ccui.ImageView:create("asset/items/" .. iconPath .. ".png")

		taskIcon:addTo(iconDi):center(iconDi:getContentSize()):setScale(0.7)

		local status = data:getStatus()
		local doneImg = statusPanel:getChildByName("Image_done")
		local getBtn = statusPanel:getChildByName("btn_get")
		local unfinishText = statusPanel:getChildByName("Text_unfinish")
		local redPoint = statusPanel:getChildByName("redPoint")

		getBtn:getChildByName("Text_str"):setString(Strings:get("Task_UI11"))
		doneImg:setVisible(status == TaskStatus.kGet)
		getBtn:setVisible(status == TaskStatus.kFinishNotGet)
		redPoint:setVisible(status == TaskStatus.kFinishNotGet)
		unfinishText:setVisible(false)

		local taskValue = data:getTaskValueList()[1]

		if not statusPanel.unfinishRt then
			statusPanel.unfinishRt = ccui.RichText:createWithXML("", {})

			statusPanel.unfinishRt:addTo(statusPanel):posite(unfinishText:getPosition()):offset(-20, 0)
		end

		statusPanel.unfinishRt:setVisible(status == TaskStatus.kUnfinish)
		statusPanel.unfinishRt:setString(Strings:get("Bento_Main_UI4", {
			Num1 = taskValue.currentValue,
			Num2 = taskValue.targetValue
		}))

		local function callFunc(sender, eventType)
			self:onGetTaskRewardClicked(data)
		end

		mapButtonHandlerClick(nil, getBtn, {
			func = callFunc
		})

		local rewardList = data:getReward().Content
		local iconNode = statusPanel:getChildByName("icon")

		iconNode:removeAllChildren()

		for i, reward in pairs(rewardList) do
			local rewardIcon = IconFactory:createRewardIcon(reward, {
				isWidget = true
			})

			rewardIcon:addTo(iconNode):center(iconNode:getContentSize()):offset(0 - (i - 1) * 80, 0)
			rewardIcon:setScaleNotCascade(0.58)
			IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), reward, {
				needDelay = true
			})
		end

		if status == TaskStatus.kGet then
			iconNode:setColor(cc.c4b(80, 80, 80, 255))
			iconNode:setPositionY(17)
		else
			iconNode:setColor(cc.c4b(255, 255, 255, 255))
			iconNode:setPositionY(38)
		end
	else
		ownText:setVisible(true)
		statusPanel:setVisible(false)

		local config = ConfigReader:getRecordById("ItemConfig", data.id)

		nameText:setString(Strings:get(config.Name))

		local icon = IconFactory:createItemPic({
			id = data.id
		})

		icon:addTo(iconDi):center(iconDi:getContentSize()):setName("iconImg")
		icon:setScale(0.9)

		local desc = RewardSystem:getDesc({
			id = data.id
		})

		descText:setString(desc)
		ownText:setString(Strings:get("Bento_Main_UI3") .. data.count)
	end
end

function ActivityBentoPopupMediator:onClickTabBtn(name, selectTag)
	self._tabType = selectTag

	self:updateData()
	self._tableView:reloadData()
	self._emptyPanel:setVisible(#self._list == 0)
end

function ActivityBentoPopupMediator:onGetTaskRewardClicked(data)
	local params = {
		doActivityType = 101,
		taskId = data:getId()
	}

	self._activitySystem:requestDoActivity(self._activityId, params, function(response)
		if not checkDependInstance(self) then
			return
		end

		self:updateData()
		self._tableView:reloadData()

		local view = self:getInjector():getInstance("getRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
			rewards = response.data.reward
		}))
	end)
end

function ActivityBentoPopupMediator:onClickClose()
	self:close()
end
