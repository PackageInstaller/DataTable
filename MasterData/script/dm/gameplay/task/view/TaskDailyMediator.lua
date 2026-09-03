-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/task/view/TaskDailyMediator.lua

TaskDailyMediator = class("TaskDailyMediator", DmAreaViewMediator, _M)

local boxRewardImg = {
	{
		"renwu_icon_bx_1.png",
		"renwu_icon_bx_1.png",
		"renwu_icon_bx_1.png"
	},
	{
		"renwu_icon_bx_2.png",
		"renwu_icon_bx_2.png",
		"renwu_icon_bx_2.png"
	},
	{
		"renwu_icon_bx_3.png",
		"renwu_icon_bx_3.png",
		"renwu_icon_bx_3.png"
	},
	{
		"renwu_icon_bx_4.png",
		"renwu_icon_bx_4.png",
		"renwu_icon_bx_4.png"
	},
	{
		"renwu_icon_bx_5.png",
		"renwu_icon_bx_5.png",
		"renwu_icon_bx_5.png"
	}
}
local kBtnHandlers = {
	["main.weekBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickWeek"
	}
}

function TaskDailyMediator:initialize()
	super.initialize(self)
end

function TaskDailyMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._cloneNode = self._main:getChildByFullName("cloneNode")
	self._dailyPanel = self._main:getChildByFullName("dailyPanel")
	self._livenessLabel = self._dailyPanel:getChildByFullName("liveness")
	self._scrollPanel = self._main:getChildByName("scroll")
	self._weekBtn = self._main:getChildByName("weekBtn")
	self._boxPanel = self._main:getChildByName("Panel_boxs")
	self._doneMark = self._main:getChildByName("doneMark")

	self._doneMark:setVisible(false)

	self._proPanel = self._boxPanel:getChildByFullName("progbackimg")
	self._cellPanel = self._main:getChildByName("cell")

	self._cellPanel:setVisible(false)
	self._cloneNode:getChildByFullName("btn_get"):setSwallowTouches(false)
	self._cloneNode:getChildByFullName("btn_go"):setSwallowTouches(false)

	self._progrLoading = self._proPanel:getChildByFullName("loadingbar")

	self._progrLoading:setScale9Enabled(true)
	self._progrLoading:setCapInsets(cc.rect(60, 3, 1, 1))
	self._cellPanel:getChildByFullName("cell.loadingBar"):setScale9Enabled(true)
	self._cellPanel:getChildByFullName("cell.loadingBar"):setCapInsets(cc.rect(1, 1, 1, 1))
	self._doneMark:getChildByFullName("text"):enableOutline(cc.c4b(244, 39, 39, 114.75), 1)
	self:adjustView()
end

function TaskDailyMediator:adjustView()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._scrollPanel:setContentSize(cc.size(912, winSize.height - 208))
end

function TaskDailyMediator:dispose()
	self._closeView = true

	self:getView():stopAllActions()
	super.dispose(self)
end

function TaskDailyMediator:removeTableView()
	self:getView():stopAllActions()

	if self._tableView then
		self._tableView:removeFromParent()

		self._tableView = nil
	end
end

function TaskDailyMediator:setupView(parentMedi)
	self._parentMedi = parentMedi
	self._taskListModel = parentMedi:getTaskListModel()
	self._taskSystem = parentMedi:getTaskSystem()

	self:refreshData()
end

function TaskDailyMediator:refreshData()
	self._daiyTaskList = self._taskSystem:getShowDailyTaskList()
end

function TaskDailyMediator:refreshView(hasAnim)
	self:refreshData()
	self:refreshLiveness(hasAnim)
	self:removeTableView()
	self:createTableView()
	self:refreshWeekRed()
	self._dailyPanel:stopAllActions()
	self._boxPanel:stopAllActions()
	self._weekBtn:stopAllActions()

	for i = 1, 5 do
		local box = self._boxPanel:getChildByFullName("box" .. i)

		box:stopAllActions()
		box:setScale(1)
		box:setOpacity(255)
	end

	if hasAnim then
		self:runStartAction()
	else
		self._dailyPanel:setOpacity(255)
		self._boxPanel:setOpacity(255)
		self._weekBtn:setOpacity(255)
		self._tableView:stopScroll()
		self._tableView:reloadData()
	end
end

function TaskDailyMediator:refreshLiveness(hasAnim)
	local livenessList = self._taskSystem:getLivenessList()
	local liveness = self._taskListModel:getDayLiveness()

	self._liveness = liveness

	self._livenessLabel:setString(tostring(liveness))

	local percent = liveness / livenessList[#livenessList] * 100
	local PercentMap = {
		[40] = 20,
		[160] = 80,
		[80] = 40,
		[200] = 100,
		[120] = 60
	}

	local function getPercent(recruitTimes)
		if PercentMap[recruitTimes] then
			return PercentMap[recruitTimes]
		end

		if recruitTimes < 40 then
			percent = PercentMap[40] * recruitTimes / 40
		elseif recruitTimes > 40 and recruitTimes < 80 then
			percent = (PercentMap[80] - PercentMap[40]) * (recruitTimes - 40) / 40 + PercentMap[40]
		elseif recruitTimes > 80 and recruitTimes < 120 then
			percent = (PercentMap[120] - PercentMap[80]) * (recruitTimes - 80) / 40 + PercentMap[80]
		elseif recruitTimes > 120 and recruitTimes < 160 then
			percent = (PercentMap[160] - PercentMap[120]) * (recruitTimes - 120) / 40 + PercentMap[120]
		elseif recruitTimes > 160 and recruitTimes < 200 then
			percent = (PercentMap[200] - PercentMap[160]) * (recruitTimes - 160) / 40 + PercentMap[160]
		elseif recruitTimes > 200 then
			percent = 100
		end

		return percent
	end

	percent = getPercent(liveness)

	self._progrLoading:setPercent(percent)

	if livenessList ~= {} then
		for i = 1, 5 do
			local boxLabel = self._proPanel:getChildByFullName("boxlabel" .. i)

			boxLabel:setString(tostring(livenessList[i]))

			local box = self._boxPanel:getChildByFullName("box" .. i)

			box:removeAllChildren()

			local animName = boxRewardImg[i]

			if liveness < livenessList[i] then
				local image = ccui.ImageView:create("rcrw_bx_di.png", 1)

				image:addTo(box):posite(26, 29)

				local child = ccui.ImageView:create(animName[1], 1)

				child:addTo(box):posite(26, 29)
				child:setScale(0.65)
			else
				local boxStatusMap = self._taskListModel:getBoxStatusMap() or {}
				local status = self._taskSystem:findValueByKey(boxStatusMap, tostring(livenessList[i]))

				if status then
					local image = ccui.ImageView:create("rcrw_bx_di.png", 1)

					image:addTo(box):posite(26, 29)

					local child = ccui.ImageView:create(animName[1], 1)

					child:addTo(box):posite(26, 29)
					child:setScale(0.65)

					local doneMark = self._doneMark:clone()

					doneMark:addTo(box):posite(30, 10)
					doneMark:setVisible(true)
				else
					local image = ccui.ImageView:create("rcrw_bx_di1.png", 1)

					image:addTo(box):posite(26, 29)

					local child = ccui.ImageView:create(animName[1], 1)

					child:addTo(box):posite(26, 29)
					child:setScale(0.65)

					local redPoint = ccui.ImageView:create(IconFactory.redPointPath, 1)

					redPoint:addTo(box)
					redPoint:setPosition(cc.p(55, 55))
					redPoint:setScale(0.65)
				end
			end

			box:setTouchEnabled(true)
			box:addClickEventListener(function(e)
				self:onClickGetBox(tostring(livenessList[i]))
			end)
		end
	end
end

function TaskDailyMediator:createTableView()
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
		return math.ceil(#self._daiyTaskList / 2)
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

function TaskDailyMediator:createCell(cell, index)
	for i = 1, 2 do
		local panel = cell:getChildByTag(i)
		local itemIndex = 2 * (index - 1) + i
		local taskData = self._daiyTaskList[itemIndex]

		if taskData then
			panel:setVisible(true)

			panel = panel:getChildByFullName("cell")

			local taskStatus = taskData:getStatus()
			local name = taskData:getName()
			local localLanguage = getCurrentLanguage()
			local titleText1 = panel:getChildByFullName("Panel_1.title_1")
			local titleText2 = panel:getChildByFullName("Panel_1.title_2")

			if localLanguage ~= GameLanguageType.CN then
				titleText1:setString(name)
				titleText1:setVisible(false)
				titleText2:setVisible(false)
			else
				local nameLabel1 = ""
				local nameLabel2 = ""
				local length = utf8.len(name)

				if length <= 4 then
					nameLabel1 = name
				else
					for j = 1, length do
						local num = utf8.sub(name, j, j)

						if j > length - 4 then
							nameLabel2 = nameLabel2 .. num
						else
							nameLabel1 = nameLabel1 .. num
						end
					end
				end

				titleText1:setString(nameLabel1)
				titleText2:setString(nameLabel2)
			end

			local taskValueList = taskData:getTaskValueList()
			local descText = panel:getChildByName("desc")
			local conditionkeeper = self:getInjector():getInstance(Conditionkeeper)
			local str = conditionkeeper:getConditionDesc(taskData:getCondition()[1])

			descText:setString(str)

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

				mark:addTo(panel):posite(350, 43)
				mark:setName("TodoMark")
			elseif taskStatus == TaskStatus.kFinishNotGet then
				local btnGet = self._cloneNode:getChildByFullName("btn_get"):clone()

				btnGet:addTo(panel):posite(348, 39)
				btnGet:addClickEventListener(function()
					self:onClickGetReward(taskData)
				end)
				btnGet:setName("TodoMark")
			elseif taskData:getDestUrl() ~= nil and taskData:getDestUrl() ~= "" and taskStatus == TaskStatus.kUnfinish then
				local btnGo = self._cloneNode:getChildByFullName("btn_go"):clone()

				btnGo:addTo(panel):posite(348, 39)
				btnGo:addClickEventListener(function()
					self:onClickGo(taskData)
				end)
				btnGo:setName("TodoMark")
			end

			local rewards = taskData:getReward()
			local rewardBg = panel:getChildByName("rewardicon")

			rewardBg:removeAllChildren()

			if rewards then
				for i = 1, #rewards do
					local reward = rewards[i]

					if reward then
						local rewardIcon = IconFactory:createRewardIcon(reward, {
							isWidget = true
						})

						rewardBg:addChild(rewardIcon)
						rewardIcon:setAnchorPoint(cc.p(0, 0.5))
						rewardIcon:setPosition(cc.p(0 + (i - 1) * 68, 35))
						rewardIcon:setScaleNotCascade(0.55)
						IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self._parentMedi), reward, {
							needDelay = true
						})
					end
				end
			end
		else
			panel:setVisible(false)
		end
	end
end

function TaskDailyMediator:updateView()
	self:refreshData()

	if self._tableView then
		self._tableView:stopScroll()
		self._tableView:reloadData()
	end

	self:refreshLiveness()
	self:refreshWeekRed()
end

function TaskDailyMediator:refreshWeekRed()
	local red = self._main:getChildByFullName("weekBtn.red")

	red:setVisible(self._taskSystem:hasWeekRewardRed())
end

function TaskDailyMediator:setBg(panel)
	panel:removeAllChildren()

	local bg = ccui.ImageView:create("asset/scene/renwu_bd_bj.jpg")

	bg:addTo(panel)
end

function TaskDailyMediator:onClickGetReward(data)
	AudioEngine:getInstance():playEffect("Se_Click_Get", false)

	if data:getStatus() == TaskStatus.kFinishNotGet then
		self._taskSystem:requestTaskReward({
			taskId = data:getId()
		}, function()
			if DisposableObject:isDisposed(self) then
				return
			end

			self._parentMedi:setOneKeyGray()
		end)
	end
end

function TaskDailyMediator:onClickGetBox(data)
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local info = {
		descId = "RewardPreview_1",
		liveness = data,
		rewardId = self._taskSystem:getLivenessRewardByType(data)
	}
	local view = self:getInjector():getInstance("TaskBoxView")

	if self._liveness < tonumber(data) then
		info.hasGet = false

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, info))
	else
		local boxStatusMap = self._taskListModel:getBoxStatusMap() or {}

		if not self._taskSystem:findValueByKey(boxStatusMap, data) then
			self._taskSystem:requestBoxReward({
				type = data
			})
		else
			info.hasGet = true

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, info))
		end
	end
end

function TaskDailyMediator:onClickGo(data)
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

function TaskDailyMediator:onClickWeek()
	local view = self:getInjector():getInstance("TaskWeekView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, nil))
end

function TaskDailyMediator:runStartAction()
	self._dailyPanel:setOpacity(0)
	self._boxPanel:setOpacity(0)
	self._weekBtn:setOpacity(0)
	self._dailyPanel:fadeIn({
		time = 0.16666666666666666
	})

	local boxes = {}

	for i = 1, 5 do
		local box = self._boxPanel:getChildByFullName("box" .. i)

		box:stopAllActions()
		box:setScale(0)
		box:setOpacity(0)

		boxes[i] = box
	end

	performWithDelay(self:getView(), function()
		self._boxPanel:fadeIn({
			time = 0.16666666666666666
		})

		local delayTime = 0.1

		for i = 1, 5 do
			local box = boxes[i]
			local time = (i - 1) * delayTime
			local scaleTo1 = cc.ScaleTo:create(0.1, 1.2)
			local scaleTo2 = cc.ScaleTo:create(0.1, 1)
			local seq = cc.Sequence:create(scaleTo1, scaleTo2)
			local fadeIn = cc.FadeIn:create(0.2)
			local spawn = cc.Spawn:create(seq, fadeIn)
			local delay = cc.DelayTime:create(time)
			local seq1 = cc.Sequence:create(delay, spawn)

			box:runAction(seq1)
		end
	end, 0.03333333333333333)
	performWithDelay(self:getView(), function()
		self._weekBtn:fadeIn({
			time = 0.16666666666666666
		})
		self._tableView:stopScroll()
		self._tableView:reloadData()
		self:runListAnim()
	end, 0.3333333333333333)
end

function TaskDailyMediator:runListAnim()
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
							self:setupClickEnvs()
						end
					end)
					local seq = cc.Sequence:create(delayAction, callfunc, callfunc1)

					self:getView():runAction(seq)
				end
			end
		end
	end
end

function TaskDailyMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		storyDirector:notifyWaiting("enter_TaskDailyMediator")
	end))

	self:getView():runAction(sequence)
end
