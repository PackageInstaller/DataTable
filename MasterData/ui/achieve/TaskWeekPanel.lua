-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Achieve\\TaskWeekPanel.lua

local ResTask = require("ClientData/ResTask")
local ResColor = require("ClientData/ResColor")
local ResRandClient = require("ClientData/ResRandClient")
local TaskConfig = require("DesignerScript/TaskConfig")
local TaskWeekPanel = Class("TaskWeekPanel", UIControls.Child)
local WeeklySubTaskCell = Class("WeeklySubTaskCell", UIControls.ScrollViewLoopCell)

function WeeklySubTaskCell:ctor(...)
	self:initUI()
end

function WeeklySubTaskCell:initUI(...)
	self.ruleTxt = UIControls.Label(self, "TaskWeekListCell/RulePanel/TextRule")
	self.titleTxt = UIControls.Label(self, "TaskWeekListCell/RulePanel/TextRuleTitle")
	self.processSlider = UIControls.Slider(self, "TaskWeekListCell/Slider")
	self.processTxt1 = UIControls.Label(self, "TaskWeekListCell/TextNum1")
	self.processTxt2 = UIControls.Label(self, "TaskWeekListCell/TextNum2")
	self.getAwardBtn = UIControls.Button(self, "TaskWeekListCell/BtnConfirm")

	self.getAwardBtn:addEventClick(self.onClickGetAward)

	self.gotoBtn = UIControls.Button(self, "TaskWeekListCell/BtnGo")

	self.gotoBtn:addEventClick(self.onClickGoto)

	self.completeTxt = UIControls.Label(self, "TaskWeekListCell/TextState")
	self.jumpLockTxt = UIControls.Label(self, "TaskWeekListCell/TextLock")
	self.awardImg = UIControls.Image(self, "TaskWeekListCell/IconAward")
	self.awardNum = UIControls.Label(self, "TaskWeekListCell/IconAward/TextNum")
	self.awardMultiTxt = UIControls.Label(self, "TaskWeekListCell/IconAward/Text")
	self.cellBgImg = UIControls.Image(self, "TaskWeekListCell")
	self.dayBgImg = UIControls.Image(self, "TaskWeekListCell/BgDayCell")
	self.anim = UIControls.UIAni(self, "")
	self.animator = UIControls.Panel(self, "TaskWeekListCell")
end

function WeeklySubTaskCell:setSubTaskCell(taskId)
	if self.subTaskId and self.subTaskId == taskId then
		return
	end

	self.subTaskId = taskId

	local taskInfo = ResTask[taskId]

	if not taskInfo then
		return
	end

	self.awardValue = taskInfo.award_value or 1

	self.awardNum:setText(self.awardValue)

	if RegionUtils.isLangJP() then
		self.titleTxt:setVisible(false)
	else
		self.titleTxt:setText(taskInfo.name or "")
	end

	self.ruleTxt:setText(taskInfo.action_desc or "")

	self.needProgress = taskInfo.action_param
	self.jumpId = taskInfo.jump_guide_id
end

function WeeklySubTaskCell:refreshSubTaskCell(...)
	local progress, needProgress = CurAvatar:getTaskProcess(self.subTaskId)

	if needProgress then
		self.processTxt1:setText(progress)
		self.processTxt2:setText(needProgress)

		local percent = progress / needProgress

		self.processSlider:setValue(percent)
	end

	local status = CurAvatar:getTaskStatus(self.subTaskId)
	local inProcess = status == Const.TASK_STATUS.IN_PROCESS
	local isGot = status == Const.TASK_STATUS.AWARD_GOT
	local isComplete = status == Const.TASK_STATUS.COMPLETE
	local jumpLock = false
	local jumpLockDesc

	if self.jumpId ~= nil then
		jumpLock, jumpLockDesc = JumpGuideManager.isConditionLimited(self.jumpId)
	end

	self.getAwardBtn:setVisible(isComplete)
	self.gotoBtn:setVisible(inProcess and self.jumpId ~= nil and not jumpLock)
	self.completeTxt:setVisible(isGot)
	self.jumpLockTxt:setVisible(jumpLock)

	if jumpLock and jumpLockDesc then
		self.jumpLockTxt:setText(jumpLockDesc)
	end

	local dayColor

	if isGot then
		-- block empty
	end

	if isComplete then
		-- block empty
	end

	local nextState = "TaskWeekListCellNml"

	if inProcess then
		-- block empty
	else
		nextState = isComplete and "TaskWeekListCellHigh" or "TaskWeekListCellDis"
	end

	self.animator:playStateAnimator(nextState)
	self.anim:startAni("ShowTaskWeekListCell", true)
end

function WeeklySubTaskCell:onClickGetAward(...)
	if self.getAwardTimer then
		return
	end

	self.anim:startAni("TaskWeekListCellEnd", true)

	self.getAwardTimer = Timer.New(Slot(self._delayGetAward, self), TaskConfig.AWARD_EFX_LENGTH)

	self.getAwardTimer:Start()
	self.mParent:predictGetBonus(self.awardValue)
end

function WeeklySubTaskCell:_delayGetAward()
	self.getAwardTimer = nil

	CurAvatar:getWeeklyTaskAward(self.subTaskId)
end

function WeeklySubTaskCell:onClickGoto(...)
	if self.jumpId then
		JumpGuideManager.jump(self.jumpId)
	end
end

local WeeklyAwardCell = Class("WeeklyAwardCell", UIControls.Child)

function WeeklyAwardCell:ctor(...)
	self:initUI()
end

function WeeklyAwardCell:initUI(...)
	self.awardIconList = {}
	self.awardIconGetList = {}
	self.efxAwardIconList = {}
	self.efxPanelList = {}

	for i = 1, 3 do
		local icon = UIControls.Image(self, "IconAwardPanel/Icon" .. i)

		self.awardIconList[i] = icon

		local getIcon = UIControls.Image(self, "IconAwardPanel/Icon" .. i .. "/IconSel")

		self.awardIconGetList[i] = getIcon

		local animIcon = UIControls.UIAni(self, "IconAwardPanel/Icon" .. i)

		self.efxAwardIconList[i] = animIcon

		local efxPanel = UIControls.Panel(self, "EfxGridItemPanel/EfxGridItem" .. i)

		self.efxPanelList[i] = efxPanel
	end

	self.itemGridPath = "GridItemPanel"
	self.itemGrids = {}
	self.cellBgImg = UIControls.Image(self, "")
	self.iconPanel = UIControls.Panel(self, "IconAwardPanel")
	self.gotTxt = UIControls.Label(self, "TextState")
end

function WeeklyAwardCell:setWeeklyAward(taskId, lastCost)
	if self.taskId and self.taskId == taskId then
		return
	end

	self.taskId = taskId
	self.needCost = ResTask[taskId].action_param
	self.lastCost = lastCost
	self.costCount = math.min(self.needCost - lastCost, 3)

	for i = 1, 3 do
		self.awardIconList[i]:setVisible(i <= self.costCount)
	end

	local taskInfo = ResTask[taskId]

	if not taskInfo then
		return
	end

	local awardRandId = taskInfo.award_value

	if awardRandId and ResRandClient[awardRandId] then
		self.itemIdList = ResRandClient[awardRandId].show_ids

		local itemNumList = ResRandClient[awardRandId].show_nums

		for i = 1, 2 do
			local itemGrid = self.itemGrids[i]

			if itemGrid then
				itemGrid:destroy()

				itemGrid = nil
			end

			if self.itemIdList[i] then
				local fakeItem = BaseObject.GetObject(self.itemIdList[i], itemNumList[i])

				itemGrid = UIControls.getGridChild(fakeItem, self, self.itemGridPath)
				itemGrid.mDisableWays = true
				self.itemGrids[i] = itemGrid

				itemGrid:setVisible(true)
				itemGrid:setObj(fakeItem)
			elseif itemGrid then
				itemGrid:setVisible(false)
			end
		end
	end
end

function WeeklyAwardCell:refreshWeeklyAward(predictStar)
	if not self.taskId then
		return
	end

	local status = CurAvatar:getTaskStatus(self.taskId)
	local isGot = status == Const.TASK_STATUS.AWARD_GOT

	self.gotTxt:setVisible(isGot)

	for _, itemGrid in ipairs(self.itemGrids) do
		itemGrid:setIconGray(isGot)
	end

	for _, efxPanel in ipairs(self.efxPanelList) do
		efxPanel:setVisible(false)
	end

	if isGot then
		self.cellBgImg:setImage("Atlas/TaskAtlas/TaskAtlas", "BgWeekDis")
		self.iconPanel:setVisible(false)
	else
		self.cellBgImg:setImage("Atlas/TaskAtlas/TaskAtlas", "BgWeekSel")
		self.iconPanel:setVisible(true)

		local nowProcess = CurAvatar:getTaskProcess(self.taskId)
		local hasCost = nowProcess - self.lastCost

		for i = 1, 3 do
			local icon = self.awardIconList[i]

			if icon:getVisible() then
				local getIcon = self.awardIconGetList[i]

				if i <= hasCost then
					getIcon:setVisible(true, true)
				else
					getIcon:setVisible(false, true)

					if predictStar and i <= hasCost + predictStar then
						self.efxAwardIconList[i]:startAni("TaskWeekAwardIcon", true)
					end
				end
			end
		end

		if predictStar and nowProcess + predictStar >= self.lastCost + self.costCount then
			self:playGetAwardEfxs()
		end
	end
end

function WeeklyAwardCell:playGetAwardEfxs()
	for i = 1, 3 do
		self.efxPanelList[i]:setVisible(i <= self.costCount)
	end
end

function TaskWeekPanel:ctor(...)
	self:initUI()
end

function TaskWeekPanel:initUI(...)
	self.awardCells = {}
	self.taskCellPath = "TaskList/Content"
	self.taskCellScroll = UIControls.ScrollViewLoopV(self, "TaskList")

	self.taskCellScroll:addEventCellChanged(self.onTaskCellChanged)

	self.taskCells = {}
end

function TaskWeekPanel:setTaskPanel()
	self.weeklyMainTask = CurAvatar.weeklyMainTask

	if not self.weeklyMainTask then
		return
	end

	local awardTaskInfo = ResTask[self.weeklyMainTask]
	local taskListByType = CurAvatar:getTaskListByTaskTypeAndActionType(awardTaskInfo.type, awardTaskInfo.action_type)

	self.awardTaskList = {}

	for i, v in ipairs(taskListByType) do
		self.awardTaskList[i] = v
	end

	self.awardTaskShowCost = {}
	self.awardTaskStatus = {}

	local lastCost = 0

	for i = 1, #self.awardTaskList do
		local taskId = self.awardTaskList[i]
		local taskInfo = ResTask[taskId]
		local needCost = taskInfo.action_param

		self.awardTaskShowCost[taskId] = lastCost
		lastCost = needCost
		self.awardTaskStatus[taskId] = CurAvatar:getTaskStatus(taskId)
	end
end

local function _sortAwardTasks(a, b)
	local aStatus = CurAvatar:getTaskStatus(a)
	local bStatus = CurAvatar:getTaskStatus(b)

	if aStatus == bStatus then
		return a < b
	else
		if aStatus == Const.TASK_STATUS.AWARD_GOT then
			aStatus = -2
		end

		if bStatus == Const.TASK_STATUS.AWARD_GOT then
			bStatus = -2
		end

		return bStatus < aStatus
	end
end

function TaskWeekPanel:refreshTeskPanel()
	self:_delayRefreshAwards()

	self.weeklyTaskList = CurAvatar:getSortedWeeklyTask()

	self.taskCellScroll:setTotalCount(#self.weeklyTaskList)
end

function TaskWeekPanel:_delayRefreshAwards(...)
	table.sort(self.awardTaskList, _sortAwardTasks)

	for index = #self.awardCells, #self.awardTaskList - 1 do
		local newCell = WeeklyAwardCell(self, "AwardList/Content", "System/Task/TaskWeekAwardCell")

		table.insert(self.awardCells, newCell)
	end

	for index, targetCell in ipairs(self.awardCells) do
		local taskId = self.awardTaskList[index]

		if taskId then
			targetCell:setVisible(true)
			targetCell:setWeeklyAward(taskId, self.awardTaskShowCost[taskId])
			targetCell:refreshWeeklyAward()
		else
			targetCell:setVisible(false)
		end
	end
end

function TaskWeekPanel:predictGetBonus(predictStar)
	for _, awardCell in ipairs(self.awardCells) do
		if awardCell.taskId then
			awardCell:refreshWeeklyAward(predictStar)
		end
	end
end

function TaskWeekPanel:onTaskCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = WeeklySubTaskCell(sender, "System/Task/TaskWeekListCellPanel", newIdx, 0, 0)
	else
		self.taskCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local taskId = self.weeklyTaskList[newIdx]

	if taskId then
		targetCell:setSubTaskCell(taskId)
		targetCell:refreshSubTaskCell()
	end

	self.taskCells[newIdx] = targetCell
end

return TaskWeekPanel
