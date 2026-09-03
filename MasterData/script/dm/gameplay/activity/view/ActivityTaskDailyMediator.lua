-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityTaskDailyMediator.lua

ActivityTaskDailyMediator = class("ActivityTaskDailyMediator", DmAreaViewMediator, _M)

ActivityTaskDailyMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {}

function ActivityTaskDailyMediator:initialize()
	super.initialize(self)
end

function ActivityTaskDailyMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._cloneNode = self._main:getChildByFullName("cloneNode")
	self._scrollPanel = self._main:getChildByName("scroll")
	self._doneMark = self._main:getChildByName("doneMark")

	self._doneMark:setVisible(false)

	self._cellPanel = self._main:getChildByName("cell")

	self._cellPanel:setVisible(false)
	self._cloneNode:getChildByFullName("btn_get"):setSwallowTouches(false)
	self._cloneNode:getChildByFullName("btn_go"):setSwallowTouches(false)
	self._cellPanel:getChildByFullName("cell.loadingBar"):setScale9Enabled(true)
	self._cellPanel:getChildByFullName("cell.loadingBar"):setCapInsets(cc.rect(1, 1, 1, 1))
	self._doneMark:getChildByFullName("text"):enableOutline(cc.c4b(244, 39, 39, 114.75), 1)
	self:adjustView()
end

function ActivityTaskDailyMediator:adjustView()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._scrollPanel:setContentSize(cc.size(912, winSize.height - 215))
end

function ActivityTaskDailyMediator:dispose()
	self._closeView = true

	self:getView():stopAllActions()
	super.dispose(self)
end

function ActivityTaskDailyMediator:removeTableView()
	self:getView():stopAllActions()

	if self._tableView then
		self._tableView:removeFromParent()

		self._tableView = nil
	end
end

function ActivityTaskDailyMediator:setupView(parentMedi, data)
	self._parentMedi = parentMedi
	self._activityId = data.activityId
	self._mainActivityId = data.mainActivityId

	self:refreshData()
end

function ActivityTaskDailyMediator:refreshData()
	self._activityModel = self._activitySystem:getActivityById(self._mainActivityId)
	self._activity = self._activityModel:getSubActivityById(self._activityId)
	self._taskList = self._activity:getSortActivityList()
end

function ActivityTaskDailyMediator:refreshView(hasAnim)
	self:refreshData()
	self:removeTableView()
	self:createTableView()

	if hasAnim then
		self:runStartAction()
	else
		self._tableView:stopScroll()
		self._tableView:reloadData()
	end
end

function ActivityTaskDailyMediator:createTableView()
	self._width = self._scrollPanel:getContentSize().width

	local height = self._cellPanel:getContentSize().height

	local function cellSizeForTable(table, idx)
		return self._width, height
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local layout = ccui.Layout:create()

			layout:addTo(cell):posite(0, 0)
			layout:setAnchorPoint(cc.p(0, 0))
			layout:setTag(123)

			for i = 1, 2 do
				local panel = self._cellPanel:clone()

				panel:setPosition((self._width / 2 - 3) * (i - 1), 0)
				layout:addChild(panel)
				panel:setTag(i)
				panel:setVisible(false)
			end
		end

		local cell_Old = cell:getChildByTag(123)

		self:createCell(cell_Old, idx + 1)
		cell:setTag(idx)

		return cell
	end

	local function numberOfCellsInTableView(table)
		return math.ceil(#self._taskList / 2)
	end

	local tableView = cc.TableView:create(self._scrollPanel:getContentSize())

	self._tableView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setPosition(0, 0)
	tableView:setAnchorPoint(0, 0)
	tableView:setMaxBounceOffset(36)
	self._scrollPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
end

function ActivityTaskDailyMediator:createCell(cell, index)
	for i = 1, 2 do
		local panel = cell:getChildByTag(i)
		local itemIndex = 2 * (index - 1) + i
		local taskData = self._taskList[itemIndex]

		if taskData then
			panel:setVisible(true)

			panel = panel:getChildByFullName("cell")

			local taskStatus = taskData:getStatus()
			local subActivityId = taskData:getActivityId()
			local name = taskData:getName()
			local config = taskData:getConfig()
			local taskId = config.Id
			local titleText1 = panel:getChildByFullName("Panel_1.title_1")

			titleText1:setString(Strings:get(name))

			if getCurrentLanguage() ~= GameLanguageType.CN then
				titleText1:setString("")
			end

			local Image4 = panel:getChildByName("Image_4")

			Image4:setContentSize(cc.size(titleText1:getContentSize().width + 40, 50))

			local taskValueList = taskData:getTaskValueList()
			local descText = panel:getChildByName("desc")

			descText:setString(Strings:get(taskData:getDesc()))

			local progText = panel:getChildByName("progress")
			local loadingBar = panel:getChildByName("loadingBar")
			local laodingBg = panel:getChildByName("laodingBg")
			local show = taskData:isProgressTask() and taskStatus == TaskStatus.kUnfinish

			progText:setVisible(show)
			laodingBg:setVisible(show)
			loadingBar:setVisible(show)

			if progText:isVisible() then
				progText:setString(taskValueList[1].currentValue .. "/" .. taskValueList[1].targetValue)

				local percent = taskValueList[1].currentValue / taskValueList[1].targetValue * 100

				loadingBar:setPercent(percent)
			end

			panel:removeChildByName("TodoMark")

			if taskStatus == TaskStatus.kGet then
				local mark = self._cloneNode:getChildByFullName("doneanim"):clone()

				mark:addTo(panel):posite(378, 53)
				mark:setName("TodoMark")
				mark:setVisible(true)
			elseif taskStatus == TaskStatus.kFinishNotGet then
				local btnGet = self._cloneNode:getChildByFullName("btn_get"):clone()

				btnGet:addTo(panel):posite(362, 48)
				btnGet:setName("TodoMark")
				btnGet:setVisible(true)

				local function callFunc()
					self:onClickGetReward(subActivityId, taskId)
				end

				mapButtonHandlerClick(nil, btnGet, {
					ignoreClickAudio = true,
					func = callFunc
				})
			elseif taskStatus == TaskStatus.kUnfinish then
				local btnGo = self._cloneNode:getChildByFullName("btn_go"):clone()

				btnGo:addTo(panel):posite(362, 48)
				btnGo:setName("TodoMark")
				btnGo:setVisible(true)

				local function callFunc()
					self:onClickGo(taskData)
				end

				mapButtonHandlerClick(nil, btnGo, {
					ignoreClickAudio = true,
					func = callFunc
				})

				local url = taskData:getDestUrl()

				btnGo:setTouchEnabled(url ~= nil and url ~= "")

				if url ~= nil and url ~= "" then
					btnGo:getChildByName("done"):setString(Strings:get("Task_UI7"))
				else
					btnGo:getChildByName("done"):setString(Strings:get("ActivityBlock_UI_18"))
				end
			end

			local rewards = taskData:getReward().Content
			local rewardBg = panel:getChildByName("rewardicon")

			rewardBg:removeAllChildren()

			if rewards then
				for i = 1, #rewards do
					local reward = rewards[i]
					local rewardIcon = IconFactory:createRewardIcon(reward, {
						isWidget = true
					})

					rewardBg:addChild(rewardIcon)
					rewardIcon:setAnchorPoint(cc.p(0, 0.5))
					rewardIcon:setPosition(cc.p((i - 1) * 68, 35))
					rewardIcon:setScaleNotCascade(0.55)
					IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self._parentMedi), reward, {
						needDelay = true
					})
				end
			end
		else
			panel:setVisible(false)
		end
	end
end

function ActivityTaskDailyMediator:updateView()
	self:refreshData()

	if self._tableView then
		self._tableView:stopScroll()
		self._tableView:reloadData()
	end
end

function ActivityTaskDailyMediator:setBg(panel, titleImage)
	panel:removeAllChildren()

	local path = string.format("asset/scene/%s.jpg", self._activity:getActivityConfig().Bmg)
	local bg = ccui.ImageView:create(path)

	bg:addTo(panel)
	titleImage:loadTexture(self._activity:getActivityConfig().titleImg .. ".png", 1)
end

function ActivityTaskDailyMediator:refreshTime(timeStr)
	local time = self._activity:getTimeStr1()

	timeStr:setString(Strings:get("ActivityBlock_UI_17", {
		time = time
	}))
end

function ActivityTaskDailyMediator:onClickGetReward(subActivityId, taskId)
	AudioEngine:getInstance():playEffect("Se_Click_Get", false)

	local param = {}

	param.doActivityType = "101"
	param.taskId = taskId

	self._activitySystem:requestDoChildActivity(self._activityModel:getId(), subActivityId, param, function(response)
		if checkDependInstance(self) then
			self:updateView()

			if not response.data.reward then
				if #response.data.reward > 0 then
					self._parentMedi:onGetRewardCallback(response.data.reward)
				end
			end
		end
	end)
end

function ActivityTaskDailyMediator:onClickGo(data)
	AudioEngine:getInstance():playEffect("Se_Click_Story_Common", false)

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

function ActivityTaskDailyMediator:runStartAction()
	performWithDelay(self:getView(), function()
		self._tableView:stopScroll()
		self._tableView:reloadData()
		self:runListAnim()
	end, 0.1)
end

function ActivityTaskDailyMediator:runListAnim()
	local showNum = 4

	self._tableView:setTouchEnabled(false)

	local allCells = self._tableView:getContainer():getChildren()

	for i = 1, showNum do
		local child = allCells[i]

		if child and child:getChildByTag(123) then
			local child = child:getChildByTag(123)

			for j = 1, 2 do
				local node = child:getChildByTag(j)

				if node then
					node = node:getChildByFullName("cell")

					node:stopAllActions()
					node:setOpacity(0)
				end
			end
		end
	end

	local length = math.min(showNum, #allCells)
	local delayTime = 0.16666666666666666
	local delayTime1 = 0.06666666666666667

	for i = 1, showNum do
		local child = allCells[i]

		if child and child:getChildByTag(123) then
			local child = child:getChildByTag(123)

			for j = 1, 2 do
				local node = child:getChildByTag(j)

				if node then
					node = node:getChildByFullName("cell")

					node:stopAllActions()

					local time = (i - 1) * delayTime + (j - 1) * delayTime1
					local delayAction = cc.DelayTime:create(time)
					local callfunc = cc.CallFunc:create(function()
						CommonUtils.runActionEffect(node, "Node_1.myPetClone", "TaskDailyEffect", "anim1", false)
					end)
					local callfunc1 = cc.CallFunc:create(function()
						node:setOpacity(255)

						if length == i then
							self._tableView:setTouchEnabled(true)
						end
					end)
					local seq = cc.Sequence:create(delayAction, callfunc, callfunc1)

					self:getView():runAction(seq)
				end
			end
		end
	end
end
