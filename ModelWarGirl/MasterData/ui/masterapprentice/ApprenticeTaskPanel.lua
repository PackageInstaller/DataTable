-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MasterApprentice\\ApprenticeTaskPanel.lua

local ResConditionLimit = require("ClientData.ResConditionLimit")
local ResMasterMisc = require("ClientData.ResMasterMisc")
local MasterApprenticeTaskCell = require("UI/MasterApprentice/MasterApprenticeTaskCell")
local ConditionCell = Class("ApprenticeTaskPanel_ConditionCell", UIControls.Panel)

function ConditionCell:ctor()
	self.txtGoal = UIControls.Label(self, self.mPath .. "/TextGoal2")
	self.txtProgress = UIControls.Label(self, self.mPath .. "/TextProgress")
	self.slider = UIControls.Slider(self, self.mPath .. "/Slider")
	self.txtSlider = UIControls.Label(self, self.mPath .. "/TextNum")
end

function ConditionCell:setData(conditionId)
	self.conditionId = conditionId

	local config = ResConditionLimit[conditionId]

	self.txtGoal:setText(config.unlock_desc or "")

	self.ratio = 0

	if config.unlock_stage then
		local curData = CurAvatar.mainStageCur
		local strLevel = ClientUtils.getMainStageLevelStr(curData.season, curData.chapter, curData.level)

		self.txtProgress:setText(strLevel)

		local goalData = CurAvatar:getMainStageInfo(config.unlock_stage[1], config.unlock_stage[2], config.unlock_stage[3])

		self.ratio = curData.idx / goalData.idx
	elseif config.unlock_crystal_level then
		local curLv = CurAvatar:getCrystalMaxLevel()

		self.txtProgress:setText(string.format(Lang.get(30171), curLv))

		self.ratio = curLv / config.unlock_crystal_level
	end

	self.ratio = math.min(self.ratio, 1)

	self.slider:setValue(self.ratio)
	self.txtSlider:setText(math.floor(self.ratio * 100) .. "%")
end

local ApprenticeTaskPanel = Class("ApprenticeTaskPanel", UIControls.Child)

function ApprenticeTaskPanel:ctor()
	self.btnDaily = UIControls.Button(self, "TabPanel/BtnDayTask")

	self.btnDaily:addEventClick(Functor(self.onClickBtnTask, self, Const.MASTER_APPRENTICE_TASK_TYPE.ApprenticeDaily))

	self.imgRedDaily = UIControls.Image(self, "TabPanel/BtnDayTask/IconNew")
	self.btnOnce = UIControls.Button(self, "TabPanel/BtnAchiTask")

	self.btnOnce:addEventClick(Functor(self.onClickBtnTask, self, Const.MASTER_APPRENTICE_TASK_TYPE.ApprenticeOnce))

	self.imgRedOnce = UIControls.Image(self, "TabPanel/BtnAchiTask/IconNew")
	self.scrollTask = UIControls.ScrollViewLoopV(self, "TaskList")

	self.scrollTask:addEventCellChanged(self.onScrollTaskChange)

	self.btnGetAll = UIControls.Button(self, "BtnGetAll")

	self.btnGetAll:addEventClick(self.onClickBtnGetAll)

	self.conditionCellList = {}

	for i = 1, 2 do
		local cell = ConditionCell(self, "GraduatePanel/GoalPanel" .. i)

		table.insert(self.conditionCellList, cell)
	end

	self.btnGraduate = UIControls.Button(self, "GraduatePanel/BtnGetAward")

	self.btnGraduate:addEventClick(self.onClickBtnGraduate)

	self.redDotGraduate = UIControls.RedDot(self, "GraduatePanel/BtnGetAward/IconNew")

	self.redDotGraduate:addHint({
		UIConst.RD_HINT_APPRENTICE_GRADUATE
	})

	self.slotSortTask = Slot(self.sortTask, self)
end

function ApprenticeTaskPanel:onShow()
	self:onClickBtnTask(Const.MASTER_APPRENTICE_TASK_TYPE.ApprenticeDaily)
	self:refreshGraduate()
	self:refreshTaskRed()
end

function ApprenticeTaskPanel:refreshTasks()
	self.taskList = CurAvatar.masterApprenticeTaskDic[self.taskType] or {}

	table.sort(self.taskList, self.slotSortTask)
	self.scrollTask:setTotalCount(#self.taskList)

	self.completeTaskIdList = {}

	for _, task in ipairs(self.taskList) do
		if task.status == Const.TASK_STATUS.COMPLETE then
			table.insert(self.completeTaskIdList, task.task_id)
		end
	end

	self.btnGetAll:setVisible(#self.completeTaskIdList > 1)
end

function ApprenticeTaskPanel:sortTask(task1, task2)
	if task1.status ~= task2.status then
		local s1 = 100
		local s2 = 100

		if task1.status == Const.TASK_STATUS.COMPLETE then
			s1 = 200
		elseif task1.status == Const.TASK_STATUS.AWARD_GOT then
			s1 = 0
		end

		if task2.status == Const.TASK_STATUS.COMPLETE then
			s2 = 200
		elseif task2.status == Const.TASK_STATUS.AWARD_GOT then
			s2 = 0
		end

		return s2 < s1
	else
		return task1.task_id < task2.task_id
	end
end

function ApprenticeTaskPanel:onScrollTaskChange(sender, cell, idx)
	if not cell then
		cell = MasterApprenticeTaskCell(sender, self.cellPath, idx)
	else
		cell.mIndex = idx
	end

	cell:setData(self.taskList[idx], self.taskType)
end

function ApprenticeTaskPanel:refreshTaskRed()
	local check = false
	local taskList = CurAvatar.masterApprenticeTaskDic[Const.MASTER_APPRENTICE_TASK_TYPE.ApprenticeDaily] or {}

	for _, task in ipairs(taskList) do
		if task.status == Const.TASK_STATUS.COMPLETE then
			check = true

			break
		end
	end

	self.imgRedDaily:setVisible(check)

	check = false

	local taskList = CurAvatar.masterApprenticeTaskDic[Const.MASTER_APPRENTICE_TASK_TYPE.ApprenticeOnce] or {}

	for _, task in ipairs(taskList) do
		if task.status == Const.TASK_STATUS.COMPLETE then
			check = true

			break
		end
	end

	self.imgRedOnce:setVisible(check)
end

function ApprenticeTaskPanel:refreshGraduate()
	local miscConfig = ResMasterMisc[1]
	local conditionList = miscConfig.graduate_condition
	local checkGraduate = true

	for i = 1, #self.conditionCellList do
		local cell = self.conditionCellList[i]
		local checkData = i <= #conditionList

		cell:setVisible(checkData)

		if checkData then
			cell:setData(conditionList[i])

			if cell.ratio < 1 then
				checkGraduate = false
			end
		end
	end

	self.awardCellList = self.awardCellList or {}

	ClientUtils.CreateBonusGrid(self, self.awardCellList, "GraduatePanel/AwardPanel/AwardList", miscConfig.graduate_award)
	self.btnGraduate:setEnable(checkGraduate)
end

function ApprenticeTaskPanel:onClickBtnTask(taskType)
	if self.btnTask then
		self.btnTask:setEnable(true)
	end

	self.taskType = taskType
	self.cellPath = "System/HandBook/RankSelectAchiTaskCell"

	if taskType == Const.MASTER_APPRENTICE_TASK_TYPE.ApprenticeDaily then
		self.btnTask = self.btnDaily
	elseif taskType == Const.MASTER_APPRENTICE_TASK_TYPE.ApprenticeOnce then
		self.btnTask = self.btnOnce
	end

	self.btnTask:setEnable(false)
	self:refreshTasks()
end

function ApprenticeTaskPanel:onClickBtnGetAll()
	RPC.masterApprenticeGetTaskAward(self.taskType, self.completeTaskIdList)
end

function ApprenticeTaskPanel:onClickBtnGraduate()
	UIManager.getUI("apprenticeGraduateDlg", true)
end

function ApprenticeTaskPanel:onMasterApprenticeGetTaskAwardResp(taskType)
	if taskType == self.taskType then
		self:refreshTasks()
	end

	self:refreshTaskRed()
end

return ApprenticeTaskPanel
