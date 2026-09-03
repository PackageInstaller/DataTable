-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/task/view/TaskStageMediator.lua

TaskStageMediator = class("TaskStageMediator", DmAreaViewMediator, _M)

TaskStageMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
TaskStageMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")

local kBtnHandlers = {}
local BaseChapterPath = "asset/scene/"
local MainTaskList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Main_TaskList", "content")

function TaskStageMediator:initialize()
	super.initialize(self)
end

function TaskStageMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._mainTaskPanel = self._main:getChildByName("mainTask")
	self._taskCell = self._mainTaskPanel:getChildByName("taskcell")
	self._tablePanel = self._main:getChildByName("panel")
	self._cellClone = self._main:getChildByName("cell")

	self._cellClone:setVisible(false)
	self._taskCell:getChildByFullName("loadingBar"):setScale9Enabled(true)
	self._taskCell:getChildByFullName("loadingBar"):setCapInsets(cc.rect(60, 3, 1, 1))
	self._cellClone:getChildByFullName("cell.loadingBar"):setScale9Enabled(true)
	self._cellClone:getChildByFullName("cell.loadingBar"):setCapInsets(cc.rect(60, 3, 1, 1))

	self._noTipsPanel = self._main:getChildByName("noTipsPanel")
end

function TaskStageMediator:dispose()
	super.dispose(self)
end

function TaskStageMediator:setupView(parentMedi)
	self._parentMediator = parentMedi
	self._taskListModel = parentMedi:getTaskListModel()
	self._taskSystem = parentMedi:getTaskSystem()
	self._mainTaskList = {}

	for i, v in pairs(MainTaskList) do
		table.insert(self._mainTaskList, {
			index = tonumber(i),
			stage = v
		})
	end

	self:setupClickEnvs()
end

function TaskStageMediator:refreshData()
	self._mainTask = self._taskListModel:getStageMainTask()
	self._taskList = self._taskListModel:getStageBranchTask()

	if self._mainTask then
		self._stageIndex = ""

		local index = self._mainTask:getSortId()

		for i = 1, #self._mainTaskList do
			if index == self._mainTaskList[i].index or not self._mainTaskList[i + 1] then
				self._stageIndex = self._mainTaskList[i].stage

				break
			end

			if index > self._mainTaskList[i].index and index < self._mainTaskList[i + 1].index then
				self._stageIndex = self._mainTaskList[i].stage

				break
			end
		end
	end
end

function TaskStageMediator:refreshView(hasAnim)
	self:refreshData()
	self:removeTableView()
	self:createTableView()
	self:refreshMainTask()
	self._taskCell:stopAllActions()
	self._main:getChildByName("text"):stopAllActions()
	self._taskCell:getChildByName("btn_get"):stopAllActions()
	self._taskCell:getChildByName("btn_go"):stopAllActions()
	self._taskCell:getChildByName("descNode"):stopAllActions()

	if hasAnim then
		self:runStartAction()
	else
		self._taskCell:setOpacity(255)
		self._main:getChildByName("text"):setOpacity(255)
		self._taskCell:getChildByName("btn_get"):setScale(1)
		self._taskCell:getChildByName("btn_go"):setScale(1)
		self._taskCell:getChildByName("btn_get"):setOpacity(255)
		self._taskCell:getChildByName("btn_go"):setOpacity(255)
		self._taskCell:getChildByName("descNode"):setPosition(cc.p(-4.27, 29.9))
		self._tableView:stopScroll()
		self._tableView:reloadData()
	end

	self:changeNotips()
end

function TaskStageMediator:changeNotips(panel)
	self._noTipsPanel:setVisible(not self._mainTask and (not self._taskList or #self._taskList == 0))
end

function TaskStageMediator:removeTableView()
	self:getView():stopAllActions()

	if self._tableView then
		self._tableView:removeFromParent()

		self._tableView = nil
	end
end

function TaskStageMediator:createTableView()
	local width = self._tablePanel:getContentSize().width
	local height = self._cellClone:getContentSize().height

	local function cellSizeForTable(table, idx)
		return width, height
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local layout = ccui.Layout:create()

			layout:addTo(cell):posite(0, 0)
			layout:setAnchorPoint(cc.p(0, 0))
			layout:setTag(123)

			local sprite = self._cellClone:clone()

			sprite:setPosition(5, 0)
			layout:addChild(sprite)
			sprite:setTag(1)
		end

		local cell_Old = cell:getChildByTag(123)

		self:createCell(cell_Old, idx + 1)
		cell:setTag(idx)

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._taskList
	end

	local tableView = cc.TableView:create(self._tablePanel:getContentSize())

	self._tableView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setPosition(0, 0)
	tableView:setAnchorPoint(0, 0)
	tableView:setMaxBounceOffset(36)
	self._tablePanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
end

function TaskStageMediator:createCell(cell, index)
	local panel = cell:getChildByTag(1)
	local itemIndex = index
	local taskData = self._taskList[itemIndex]

	if taskData then
		panel:setVisible(true)

		panel = panel:getChildByFullName("cell")

		local name = panel:getChildByFullName("Panel_1.name")

		name:setString(taskData:getName())

		local localLanguage = getCurrentLanguage()

		if localLanguage ~= GameLanguageType.CN then
			name:setVisible(false)
		end

		local desc = panel:getChildByName("desc")
		local conditionkeeper = self:getInjector():getInstance(Conditionkeeper)
		local str = conditionkeeper:getConditionDesc(taskData:getCondition()[1])

		desc:setString(str)

		local taskStatus = taskData:getStatus()
		local btnGet = panel:getChildByName("btn_get")

		btnGet:setVisible(taskStatus == TaskStatus.kFinishNotGet)
		btnGet:addClickEventListener(function(sender, eventType)
			self:onClickGetReward(taskData)
		end)

		local btnGo = panel:getChildByName("btn_go")

		btnGo:addClickEventListener(function()
			self:onClickGo(taskData)
		end)

		local canGo = taskData:getDestUrl() ~= nil and taskData:getDestUrl() ~= "" and taskStatus == TaskStatus.kUnfinish

		btnGo:setVisible(canGo)

		local taskValueList = taskData:getTaskValueList()
		local progText = panel:getChildByName("count")
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

		local rewardBg = panel:getChildByName("icon")
		local rewards = taskData:getReward()

		rewardBg:removeAllChildren(true)

		local width = rewardBg:getContentSize().width

		if rewards then
			for i = 1, #rewards do
				local reward = rewards[i]

				if reward then
					local rewardIcon = IconFactory:createRewardIcon(reward, {
						isWidget = true
					})

					rewardBg:addChild(rewardIcon)
					rewardIcon:setAnchorPoint(cc.p(1, 0.5))
					rewardIcon:setPosition(cc.p(width - width * (i - 1), 32))
					rewardIcon:setScaleNotCascade(0.55)
					IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self._parentMediator), reward, {
						needDelay = true
					})
				end
			end
		end
	else
		panel:setVisible(false)
	end
end

function TaskStageMediator:refreshMainTask()
	self._taskCell:setVisible(true)

	if not self._mainTask then
		self._taskCell:setVisible(false)

		return
	end

	local name = self._taskCell:getChildByFullName("descNode.Panel_1.name")

	name:setString(self._mainTask:getName())

	local localLanguage = getCurrentLanguage()

	if localLanguage ~= GameLanguageType.CN then
		name:setVisible(false)
	end

	local desc = self._taskCell:getChildByFullName("descNode.desc")
	local conditionkeeper = self:getInjector():getInstance(Conditionkeeper)
	local str = conditionkeeper:getConditionDesc(self._mainTask:getCondition()[1])

	desc:setString(str)

	local taskStatus = self._mainTask:getStatus()
	local btnGet = self._taskCell:getChildByName("btn_get")

	btnGet:setVisible(taskStatus == TaskStatus.kFinishNotGet)
	btnGet:addClickEventListener(function(sender, eventType)
		self:onClickGetReward(self._mainTask)
	end)

	local btnGo = self._taskCell:getChildByName("btn_go")

	btnGo:addClickEventListener(function()
		self:onClickGo(self._mainTask)
	end)

	local canGo = self._mainTask:getDestUrl() ~= nil and self._mainTask:getDestUrl() ~= "" and taskStatus == TaskStatus.kUnfinish

	btnGo:setVisible(canGo)

	local taskValueList = self._mainTask:getTaskValueList()
	local progText = self._taskCell:getChildByName("count")
	local loadingBar = self._taskCell:getChildByName("loadingBar")
	local laodingBg = self._taskCell:getChildByName("laodingBg")
	local show = self._mainTask:isProgressTask() and taskStatus == TaskStatus.kUnfinish

	progText:setVisible(show)
	laodingBg:setVisible(show)
	loadingBar:setVisible(show)

	if progText:isVisible() then
		progText:setString(taskValueList[1].currentValue .. "/" .. taskValueList[1].targetValue)

		local percent = taskValueList[1].currentValue / taskValueList[1].targetValue * 100

		loadingBar:setPercent(percent)
	end

	local rewardBg = self._taskCell:getChildByName("icon")
	local rewards = self._mainTask:getReward()

	rewardBg:removeAllChildren(true)

	local width = rewardBg:getContentSize().width + 6

	if rewards then
		for i = 1, #rewards do
			local reward = rewards[i]

			if reward then
				local node = cc.Node:create()
				local rewardIcon = IconFactory:createRewardIcon(reward, {
					isWidget = true
				})

				rewardBg:addChild(node)
				node:setPosition(cc.p(width * (i - 1), 2))
				node:addChild(rewardIcon)
				rewardIcon:setTag(123)
				node:setScale(0.58)

				if rewardIcon.getAmountLabel then
					local label = rewardIcon:getAmountLabel()

					if label then
						label:setScale(1.4545454545454546)
						label:enableOutline(cc.c4b(0, 0, 0, 255), 1)
					end
				end

				rewardIcon:setAnchorPoint(cc.p(0, 0))
				rewardIcon:setPosition(cc.p(0, 0))
				IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self._parentMediator), reward, {
					needDelay = true
				})
			end
		end
	end
end

function TaskStageMediator:resetTask()
	local params = {
		taskType = {
			TaskType.kBranch,
			TaskType.kStage
		}
	}

	self._taskSystem:requestTaskList(params, function()
		if DisposableObject:isDisposed(self) then
			return
		end

		self:updateView()
		self:setBg()
	end, self)
end

function TaskStageMediator:updateView()
	self:refreshData()

	if self._tableView then
		self._tableView:stopScroll()
		self._tableView:reloadData()
	end

	self:refreshMainTask()
	self:changeNotips()
end

function TaskStageMediator:setBg(panel)
	self._bgPanel = self._bgPanel or panel

	self._bgPanel:removeAllChildren()

	local bgPanel = ccui.ImageView:create("asset/scene/renwu_bd_bj02.jpg")

	if self._stageIndex and self._stageIndex ~= "" then
		local chapterConfig = ConfigReader:getRecordById("BlockMap", self._stageIndex)

		bgPanel = cc.Node:create()

		bgPanel:removeAllChildren()

		local backgroundId = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", chapterConfig.Background, "Picture")

		if backgroundId and backgroundId ~= "" then
			local background = cc.Sprite:create(BaseChapterPath .. backgroundId .. ".jpg")

			background:setAnchorPoint(cc.p(0.5, 0.5))
			background:addTo(bgPanel)
		end

		local flashId = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", chapterConfig.Background, "Flash1")

		if flashId and flashId ~= "" then
			local mc = cc.MovieClip:create(flashId)

			mc:addTo(bgPanel)
		end

		local flashId2 = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", chapterConfig.Background, "Flash2")

		if flashId2 and flashId2 ~= "" then
			local mc = cc.MovieClip:create(flashId2)

			mc:addTo(bgPanel)
		end

		local winSize = cc.Director:getInstance():getWinSize()

		if winSize.height < 641 then
			bgPanel:setScale(winSize.width / 1386)
		end
	end

	bgPanel:addTo(self._bgPanel)

	local roleModelNode = self._main:getChildByName("roleModelNode")
	local role = roleModelNode:getChildByName("role")

	if not role then
		local img, jsonPath = IconFactory:createRoleIconSpriteNew({
			id = "Model_ZTXChang",
			useAnim = true,
			frameId = "bustframe9"
		})

		img:addTo(roleModelNode):posite(380, -80):setName("role")
	end
end

function TaskStageMediator:onClickGetReward(data)
	AudioEngine:getInstance():playEffect("Se_Click_Get", false)

	if data:getStatus() == TaskStatus.kFinishNotGet then
		self._taskSystem:requestTaskReward({
			taskId = data:getId()
		}, function()
			if DisposableObject:isDisposed(self) then
				return
			end

			self:resetTask()
			self._parentMediator:setOneKeyGray()
		end)
	end
end

function TaskStageMediator:onClickGo(data)
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

function TaskStageMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local btn_get = self._taskCell:getChildByFullName("btn_get")

		if btn_get then
			storyDirector:setClickEnv("TaskStageMediator.btn_get", btn_get, function(sender, eventType)
				self:onClickGetReward(self._mainTask)
			end)
		end

		storyDirector:notifyWaiting("enter_TaskStageMediator")
	end))

	self._main:runAction(sequence)
end

function TaskStageMediator:runStartAction()
	self._taskCell:setOpacity(0)
	self._main:getChildByName("text"):setOpacity(0)
	self._taskCell:getChildByName("btn_get"):setScale(1.2)
	self._taskCell:getChildByName("btn_go"):setScale(1.2)
	self._taskCell:getChildByName("btn_get"):setOpacity(0)
	self._taskCell:getChildByName("btn_go"):setOpacity(0)
	self._taskCell:getChildByName("descNode"):setPosition(cc.p(60, 29.9))

	local children = self._taskCell:getChildByFullName("icon"):getChildren()

	for i = 1, #children do
		local node = children[i]:getChildByTag(123)

		node:stopAllActions()
		node:setOpacity(0)
	end

	performWithDelay(self:getView(), function()
		self._taskCell:fadeIn({
			time = 0.16666666666666666
		})
	end, 0.06666666666666667)
	performWithDelay(self:getView(), function()
		local moveTo = cc.MoveTo:create(0.23333333333333334, cc.p(-4.27, 29.9))

		self._taskCell:getChildByName("descNode"):setPosition(cc.p(60, 29.9)):runAction(moveTo)

		local delayTime = 0.16666666666666666

		for i = 1, #children do
			local node = children[i]:getChildByTag(123)

			node:stopAllActions()

			local time = (i - 1) * delayTime
			local delayAction = cc.DelayTime:create(time)
			local callfunc = cc.CallFunc:create(function()
				CommonUtils.runActionEffect(node, "Node_1.myPetClone", "TaskDailyEffect", "anim1", false)
			end)
			local callfunc1 = cc.CallFunc:create(function()
				node:setOpacity(255)
			end)
			local seq = cc.Sequence:create(delayAction, callfunc, callfunc1)

			self:getView():runAction(seq)
		end
	end, 0.1)
	performWithDelay(self:getView(), function()
		self._main:getChildByName("text"):fadeIn({
			time = 0.13333333333333333
		})

		local scaleTo = cc.ScaleTo:create(0.23333333333333334, 1)
		local fadeIn = cc.FadeIn:create(0.23333333333333334)
		local spawn = cc.Spawn:create(scaleTo, fadeIn)

		self._taskCell:getChildByName("btn_get"):runAction(spawn)

		local scaleTo = cc.ScaleTo:create(0.23333333333333334, 1)
		local fadeIn = cc.FadeIn:create(0.23333333333333334)
		local spawn = cc.Spawn:create(scaleTo, fadeIn)

		self._taskCell:getChildByName("btn_go"):runAction(spawn)
	end, 0.13333333333333333)
	performWithDelay(self:getView(), function()
		self._tableView:stopScroll()
		self._tableView:reloadData()
		self:runListAnim()
	end, 0.16666666666666666)
end

function TaskStageMediator:runListAnim()
	self._tableView:setTouchEnabled(false)

	local allCells = self._tableView:getContainer():getChildren()

	for i = 1, 4 do
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

	local length = math.min(4, #allCells)
	local delayTime = 0.16666666666666666
	local delayTime1 = 0.06666666666666667

	for i = 1, 4 do
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
