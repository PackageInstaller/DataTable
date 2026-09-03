-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityTaskAchievementMediator.lua

ActivityTaskAchievementMediator = class("ActivityTaskAchievementMediator", DmAreaViewMediator, _M)

ActivityTaskAchievementMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityTaskAchievementMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function ActivityTaskAchievementMediator:initialize()
	super.initialize(self)
end

function ActivityTaskAchievementMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._bagSystem = self._developSystem:getBagSystem()
	self._main = self:getView():getChildByName("main")
	self._numNode = self._main:getChildByFullName("numNode")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		-- block empty
	end

	self._cloneNode = self._main:getChildByFullName("cloneNode")
	self._scrollPanel = self._main:getChildByName("scroll")
	self._cellPanel = self._main:getChildByName("cell")

	self._cellPanel:setVisible(false)
	self._cloneNode:getChildByFullName("btn_get"):setSwallowTouches(false)
	self._cloneNode:getChildByFullName("btn_go"):setSwallowTouches(false)
	self._cellPanel:getChildByFullName("cell.process.loadingBar"):setScale9Enabled(true)
	self._cellPanel:getChildByFullName("cell.process.loadingBar"):setCapInsets(cc.rect(1, 1, 1, 1))
	self:adjustView()
end

function ActivityTaskAchievementMediator:adjustView()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._scrollPanel:setContentSize(cc.size(912, winSize.height - 215))
end

function ActivityTaskAchievementMediator:dispose()
	self._closeView = true

	self:getView():stopAllActions()
	super.dispose(self)
end

function ActivityTaskAchievementMediator:removeTableView()
	self:getView():stopAllActions()

	if self._tableView then
		self._tableView:removeFromParent()

		self._tableView = nil
	end
end

function ActivityTaskAchievementMediator:setupView(parentMedi, data)
	self._parentMedi = parentMedi
	self._activityId = data.activityId
	self._mainActivityId = data.mainActivityId

	self:refreshData()
end

function ActivityTaskAchievementMediator:refreshData()
	self._activityModel = self._activitySystem:getActivityById(self._mainActivityId)
	self._activity = self._activityModel:getSubActivityById(self._activityId)
	self._taskList = self._activity:getSortActivityList()
end

function ActivityTaskAchievementMediator:refreshView(hasAnim)
	self:refreshData()
	self:refreshInfo()
	self:removeTableView()
	self:createTableView()

	if hasAnim then
		self:runStartAction()
	else
		self._tableView:stopScroll()
		self._tableView:reloadData()
	end
end

function ActivityTaskAchievementMediator:refreshInfo()
	local text = self._numNode:getChildByName("text")

	self._itemId = self._activity:getActivityConfig().progressItem

	if not self._itemId then
		self._numNode:setVisible(false)

		return
	end

	local numStr = self._numNode:getChildByName("num")
	local num = self._bagSystem:getItemCount(self._itemId)

	numStr:setString(num)

	if not self._numNode:getChildByName("ItemNode") then
		text:setString(Strings:get(self._activity:getActivityConfig().progressDesc))

		local icon = IconFactory:createItemPic({
			id = self._itemId
		})

		icon:addTo(self._numNode):posite(text:getPositionX() + text:getContentSize().width + 20, text:getPositionY())
		icon:setName("ItemNode")
		icon:setScale(0.38)
		numStr:setPositionX(icon:getPositionX() + 20)
	end
end

function ActivityTaskAchievementMediator:createTableView()
	self._width = self._scrollPanel:getContentSize().width

	local height = self._cellPanel:getContentSize().height

	local function cellSizeForTable(table, idx)
		return self._width, height
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local panel = self._cellPanel:clone()

			panel:setPosition(0, 0)
			cell:addChild(panel)
			panel:setTag(123)
			panel:setVisible(false)
		end

		self:createCell(cell, idx + 1)
		cell:setTag(idx)

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._taskList
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

function ActivityTaskAchievementMediator:createCell(cell, index)
	local panel = cell:getChildByTag(123)
	local taskData = self._taskList[index]

	if taskData then
		panel:setVisible(true)

		panel = panel:getChildByFullName("cell")

		local taskStatus = taskData:getStatus()
		local subActivityId = taskData:getActivityId()
		local taskId = taskData:getId()
		local iconNode = panel:getChildByName("icon")
		local descText = panel:getChildByName("desc")
		local processNode = panel:getChildByName("process")

		processNode:setVisible(false)
		descText:setPositionY(55)
		processNode:setPositionY(20)

		local getVirtualRenderer = descText:getVirtualRenderer()

		getVirtualRenderer:setAlignment(cc.TEXT_ALIGNMENT_LEFT, cc.TEXT_ALIGNMENT_CENTER)
		getVirtualRenderer:setOverflow(cc.LabelOverflow.SHRINK)

		if self._itemId then
			local icon = IconFactory:createItemPic({
				id = self._itemId
			})

			icon:addTo(iconNode):center(iconNode:getContentSize()):setScale(0.7)
		else
			iconNode:setVisible(false)
			descText:setPositionX(iconNode:getPositionX() - 20)
		end

		descText:setString(Strings:get(taskData:getDesc()))

		local taskValues = taskData._taskValueList[1]

		if self._activity:getActivityConfig().ShowProgress and taskValues and taskValues.targetValue ~= 0 then
			processNode:setVisible(true)
			processNode:setTouchEnabled(false)

			local bar = processNode:getChildByFullName("loadingBar")
			local process = processNode:getChildByFullName("progress")

			if taskValues then
				bar:setPercent(taskValues.currentValue / taskValues.targetValue * 100)
				process:setString(taskValues.currentValue .. "/" .. taskValues.targetValue)
				processNode:setPositionX(descText:getPositionX())
				descText:setPositionY(60)
			end
		end

		panel:removeChildByName("TodoMark")

		if taskStatus == TaskStatus.kGet then
			local mark = self._cloneNode:getChildByFullName("doneanim"):clone()

			mark:addTo(panel):posite(810, 45)
			mark:setName("TodoMark")
			mark:setVisible(true)
		elseif taskStatus == TaskStatus.kFinishNotGet then
			local btnGet = self._cloneNode:getChildByFullName("btn_get"):clone()

			btnGet:addTo(panel):posite(810, 45)
			btnGet:setName("TodoMark")
			btnGet:setVisible(true)

			local function callFunc()
				self:onClickGetReward(subActivityId, taskData)
			end

			mapButtonHandlerClick(nil, btnGet, {
				ignoreClickAudio = true,
				func = callFunc
			})
		elseif taskStatus == TaskStatus.kUnfinish then
			local btnGo = self._cloneNode:getChildByFullName("btn_go"):clone()

			btnGo:addTo(panel):posite(810, 45)
			btnGo:setName("TodoMark")
			btnGo:setVisible(true)

			local function callFunc()
				self:onClickGo(taskData)
			end

			mapButtonHandlerClick(nil, btnGo, {
				ignoreClickAudio = true,
				func = callFunc
			})

			if taskData.getDestUrl then
				local url = taskData:getDestUrl()

				btnGo:setTouchEnabled(url ~= nil and url ~= "")

				if url ~= nil and url ~= "" then
					btnGo:getChildByName("done"):setString(Strings:get("Task_UI7"))
				else
					btnGo:getChildByName("done"):setString(Strings:get("ActivityBlock_UI_18"))
				end
			end
		end

		local rewards = taskData:getReward().Content
		local rewardBg = panel:getChildByName("rewardicon")

		rewardBg:removeAllChildren()
		rewardBg:setPositionX(500)

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
	end
end

function ActivityTaskAchievementMediator:updateView()
	self:refreshData()

	if self._tableView then
		self._tableView:stopScroll()
		self._tableView:reloadData()
	end
end

function ActivityTaskAchievementMediator:setBg(panel, titleImage)
	panel:removeAllChildren()

	local path = string.format("asset/scene/%s.jpg", self._activity:getActivityConfig().Bmg)
	local bg = ccui.ImageView:create(path)

	bg:addTo(panel)
	print(self._activity:getActivityConfig().titleImg .. ".png" .. "self._activity:getActivityConfig().titleImg")
	titleImage:loadTexture(self._activity:getActivityConfig().titleImg .. ".png", 1)
end

function ActivityTaskAchievementMediator:refreshTime(timeStr)
	local time = self._activity:getTimeStr1()

	timeStr:setString(Strings:get("ActivityBlock_UI_17", {
		time = time
	}))
end

function ActivityTaskAchievementMediator:onClickGetReward(subActivityId, taskData)
	AudioEngine:getInstance():playEffect("Se_Click_Get", false)

	local param = {}

	if taskData:getType() == "ActivityNumTask" then
		param.doActivityType = "102"
		param.num = taskData:getId()
	else
		param.doActivityType = "101"
		param.taskId = taskData:getId()
	end

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

function ActivityTaskAchievementMediator:onClickGo(data)
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

function ActivityTaskAchievementMediator:runStartAction()
	performWithDelay(self:getView(), function()
		self._tableView:stopScroll()
		self._tableView:reloadData()
		self:runListAnim()
	end, 0.1)
end

function ActivityTaskAchievementMediator:runListAnim()
	self._tableView:setTouchEnabled(false)

	local allCells = self._tableView:getContainer():getChildren()

	for i = 1, 7 do
		local child = allCells[i]

		if child and child:getChildByTag(123) then
			local node = child:getChildByTag(123)

			if node then
				node = node:getChildByFullName("cell")

				node:stopAllActions()
				node:setOpacity(0)
			end
		end
	end

	local length = math.min(4, #allCells)
	local delayTime1 = 0.06666666666666667

	for i = 1, 7 do
		local child = allCells[i]

		if child and child:getChildByTag(123) then
			local node = child:getChildByTag(123)

			if node then
				node = node:getChildByFullName("cell")

				node:stopAllActions()

				local time = (i - 1) * delayTime1
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
