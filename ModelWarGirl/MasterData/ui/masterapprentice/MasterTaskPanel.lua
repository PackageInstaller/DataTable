-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MasterApprentice\\MasterTaskPanel.lua

local ResMasterLevel = require("ClientData/ResMasterLevel")
local MasterApprenticeTaskCell = require("UI/MasterApprentice/MasterApprenticeTaskCell")
local ApprenticeCell = Class("MasterTaskPanel_ApprenticeCell", UIControls.Panel)

function ApprenticeCell:ctor()
	self.lockPart = UIControls.Image(self, self.mPath .. "/ImgLock")
	self.unlockPart = UIControls.Image(self, self.mPath .. "/ImgUnlock")
	self.playerPart = UIControls.Panel(self, self.mPath .. "/GridPlayer")
end

function ApprenticeCell:setData(checkUnlock, otherPlayer)
	self.lockPart:setVisible(not checkUnlock)
	self.unlockPart:setVisible(checkUnlock and otherPlayer == nil)
	self.playerPart:setVisible(checkUnlock and otherPlayer ~= nil)

	if otherPlayer then
		if not self.headCell then
			self.headCell = UIControls.PlayerHeadGridChild(self, self.mPath .. "/GridPlayer", "System/Common/Grid/GridPlayerCommon")
		end

		self.headCell:setPlayer(otherPlayer, true, self)
	end
end

local MasterTaskPanel = Class("MasterTaskPanel", UIControls.Child)

function MasterTaskPanel:ctor()
	self.btnDaily = UIControls.Button(self, "TabPanel/BtnDayTask")

	self.btnDaily:addEventClick(Functor(self.onClickBtnTask, self, Const.MASTER_APPRENTICE_TASK_TYPE.MasterDaily))

	self.imgRedDaily = UIControls.Image(self, "TabPanel/BtnDayTask/IconNew")
	self.btnOnce = UIControls.Button(self, "TabPanel/BtnAchiTask")

	self.btnOnce:addEventClick(Functor(self.onClickBtnTask, self, Const.MASTER_APPRENTICE_TASK_TYPE.MasterCycle))

	self.imgRedCycle = UIControls.Image(self, "TabPanel/BtnAchiTask/IconNew")
	self.btnGetAll = UIControls.Button(self, "BtnGetAll")

	self.btnGetAll:addEventClick(self.onClickBtnGetAll)

	self.scrollTask = UIControls.ScrollViewLoopV(self, "TaskList")

	self.scrollTask:addEventCellChanged(self.onScrollTaskChange)

	self.imgLv = UIControls.Image(self, "TeacherPanel/ImgLv")
	self.txtLv = UIControls.Label(self, "TeacherPanel/TextLv")
	self.slider = UIControls.Slider(self, "TeacherPanel/Slider")
	self.txtSlider = UIControls.Label(self, "TeacherPanel/TextNum")
	self.nextAwardPart = UIControls.Panel(self, "TeacherPanel/NextAwardPanel")
	self.btnAward = UIControls.Button(self, "TeacherPanel/BtnLvAward")

	self.btnAward:addEventClick(self.onClickBtnAward)

	self.redDotAward = UIControls.RedDot(self, "TeacherPanel/BtnLvAward/IconNew")

	self.redDotAward:addHint({
		UIConst.RD_HINT_MASTER_LV_AWARD
	})

	self.ApprenticeCellList = {}

	for i = 1, 8 do
		local cell = ApprenticeCell(self, "TeacherPanel/ManagementPanel/GridStudent" .. i)

		table.insert(self.ApprenticeCellList, cell)
	end

	self.upStepLvEfx = UIControls.LazyEffectPlayer(self, "TeacherPanel/ImgLv/Efx")
	self.upLvEfx = UIControls.LazyEffectPlayer(self, "TeacherPanel/Slider/Efx")
	self.upExpEfx = UIControls.LazyEffectPlayer(self, "TeacherPanel/Slider/Fill Area/Fill/Efx")
	self.stepLvEfxList = {}

	for i = 1, 4 do
		local efx = UIControls.LazyEffectPlayer(self, "TeacherPanel/ImgLv/Efx" .. i)

		table.insert(self.stepLvEfxList, efx)
	end

	self.slotSortTask = Slot(self.sortTask, self)
end

function MasterTaskPanel:onShow()
	self:onClickBtnTask(Const.MASTER_APPRENTICE_TASK_TYPE.MasterDaily)
	self:refreshMasterPart()
	self:refreshTaskRed()
end

function MasterTaskPanel:refreshTasks()
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

function MasterTaskPanel:sortTask(task1, task2)
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

function MasterTaskPanel:onScrollTaskChange(sender, cell, idx)
	if not cell then
		cell = MasterApprenticeTaskCell(sender, self.cellPath, idx)
	else
		cell.mIndex = idx
	end

	cell:setData(self.taskList[idx], self.taskType)
end

function MasterTaskPanel:refreshMasterPart()
	local config = ResMasterLevel[math.max(CurAvatar.masterLv, 1)]

	self.imgLv:setImage(config.icon_path, config.icon)
	self.txtLv:setText(string.format(Lang.get(80803), CurAvatar.masterLv))

	local checkMaxLv = CurAvatar:isMaxMasterLevel()

	self.txtSlider:setVisible(not checkMaxLv)
	self.nextAwardPart:setVisible(not checkMaxLv)

	if not checkMaxLv then
		local lastExp = ResMasterLevel[CurAvatar.masterLv] and ResMasterLevel[CurAvatar.masterLv].need_xp or 0
		local nextExp = ResMasterLevel[CurAvatar.masterLv + 1].need_xp - lastExp

		self.txtSlider:setText(CurAvatar.masterExp .. "/" .. nextExp)
		self.slider:setValue(CurAvatar.masterExp / nextExp)

		self.awardCellList = self.awardCellList or {}

		local nextConfig = ResMasterLevel[CurAvatar.masterLv + 1]

		ClientUtils.CreateBonusGrid(self, self.awardCellList, "TeacherPanel/NextAwardPanel", nextConfig.award, false, 1)
	else
		self.slider:setValue(1)
	end

	local curApprenticeNum = CurAvatar.apprenticeUidList and #CurAvatar.apprenticeUidList or 0
	local curMaxApprenticeNum = CurAvatar:getCurMaxApprenticeNum()
	local maxApprenticeNum = ResMasterLevel[#ResMasterLevel].apprentice_num

	for i = 1, #self.ApprenticeCellList do
		local cell = self.ApprenticeCellList[i]

		cell:setVisible(i <= maxApprenticeNum)

		if i <= curApprenticeNum then
			cell:setData(true, CurAvatar.apprenticeDic[CurAvatar.apprenticeUidList[i]])
		elseif i <= curMaxApprenticeNum then
			cell:setData(true)
		else
			cell:setData(false)
		end
	end

	if self.masterLv and CurAvatar.masterLv > self.masterLv then
		self.upLvEfx:playEffect()

		if self.masterLv % 5 == 0 then
			self.upStepLvEfx:playEffect()
		end
	end

	if self.totalMasterExp and CurAvatar.totalMasterExp > self.totalMasterExp then
		self.upExpEfx:playEffect()
	end

	self.masterLv = CurAvatar.masterLv
	self.totalMasterExp = CurAvatar.totalMasterExp

	local step = math.floor((self.masterLv - 1) / 5) + 1

	for i = 1, #self.stepLvEfxList do
		self.stepLvEfxList[i]:setVisible(i == step)
	end
end

function MasterTaskPanel:refreshTaskRed()
	local check = false
	local taskList = CurAvatar.masterApprenticeTaskDic[Const.MASTER_APPRENTICE_TASK_TYPE.MasterDaily] or {}

	for _, task in ipairs(taskList) do
		if task.status == Const.TASK_STATUS.COMPLETE then
			check = true

			break
		end
	end

	self.imgRedDaily:setVisible(check)

	check = false

	local taskList = CurAvatar.masterApprenticeTaskDic[Const.MASTER_APPRENTICE_TASK_TYPE.MasterCycle] or {}

	for _, task in ipairs(taskList) do
		if task.status == Const.TASK_STATUS.COMPLETE then
			check = true

			break
		end
	end

	self.imgRedCycle:setVisible(check)
end

function MasterTaskPanel:onClickBtnTask(taskType)
	if self.btnTask then
		self.btnTask:setEnable(true)
	end

	self.taskType = taskType
	self.cellPath = "System/HandBook/RankSelectAchiTaskCell"

	if taskType == Const.MASTER_APPRENTICE_TASK_TYPE.MasterDaily then
		self.btnTask = self.btnDaily
	elseif taskType == Const.MASTER_APPRENTICE_TASK_TYPE.MasterCycle then
		self.btnTask = self.btnOnce
	end

	self.btnTask:setEnable(false)
	self:refreshTasks()
end

function MasterTaskPanel:onClickBtnGetAll()
	RPC.masterApprenticeGetTaskAward(self.taskType, self.completeTaskIdList)
end

function MasterTaskPanel:onClickBtnAward()
	UIManager.getUI("masterAwardDlg", true)
end

function MasterTaskPanel:onMasterApprenticeGetTaskAwardResp(taskType)
	if taskType == self.taskType then
		self:refreshTasks()
	end

	self:refreshTaskRed()
end

function MasterTaskPanel:onMasterExperienceNotify()
	self:refreshMasterPart()
end

return MasterTaskPanel
