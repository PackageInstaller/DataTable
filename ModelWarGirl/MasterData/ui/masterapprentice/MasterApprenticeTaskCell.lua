-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MasterApprentice\\MasterApprenticeTaskCell.lua

local ResMasterTask = require("ClientData/ResMasterTask")
local MasterApprenticeTaskCell = Class("MasterApprenticeTaskCell", UIControls.ScrollViewLoopCell)

function MasterApprenticeTaskCell:ctor()
	self.imgDailyBg = UIControls.Image(self, "TaskDayListCell/ImgDayTask")
	self.imgAchiBg = UIControls.Image(self, "TaskDayListCell/ImgAchiTask")
	self.txtDes = UIControls.Label(self, "TaskDayListCell/TextRule")
	self.slider = UIControls.Slider(self, "TaskDayListCell/Slider")
	self.txtSlider = UIControls.Label(self, "TaskDayListCell/TextNum")
	self.btnGet = UIControls.Button(self, "TaskDayListCell/BtnConfirm")

	self.btnGet:addEventClick(self.onClickBtnGet)

	self.gotPanel = UIControls.Panel(self, "TaskDayListCell/TextState")
	self.btnNml = UIControls.Panel(self, "TaskDayListCell/BtnGo")
end

function MasterApprenticeTaskCell:setData(task, taskType)
	self.taskType = taskType
	self.taskId = task.task_id

	local config = ResMasterTask[self.taskId]

	self.txtDes:setText(config.desc)

	local checkNml = task.status ~= Const.TASK_STATUS.COMPLETE and task.status ~= Const.TASK_STATUS.AWARD_GOT

	self.btnNml:setVisible(checkNml)
	self.btnGet:setVisible(task.status == Const.TASK_STATUS.COMPLETE)
	self.gotPanel:setVisible(task.status == Const.TASK_STATUS.AWARD_GOT)

	if config.show_progress == 1 then
		self.txtSlider:setText(checkNml and "0/1" or "1/1")
	elseif checkNml then
		self.txtSlider:setText((task.value or "0") .. "/" .. config.param)
	else
		self.txtSlider:setText(config.param .. "/" .. config.param)
	end

	self.slider:setValue((task.value or 0) / config.param)

	self.awardCellList = self.awardCellList or {}

	ClientUtils.CreateBonusGrid(self, self.awardCellList, "GridItemPanel", config.award)

	local checkDailyBg = taskType == Const.MASTER_APPRENTICE_TASK_TYPE.MasterDaily or taskType == Const.MASTER_APPRENTICE_TASK_TYPE.ApprenticeDaily

	self.imgDailyBg:setVisible(checkDailyBg)
	self.imgAchiBg:setVisible(not checkDailyBg)
end

function MasterApprenticeTaskCell:onClickBtnGet()
	RPC.masterApprenticeGetTaskAward(self.taskType, {
		self.taskId
	})
end

return MasterApprenticeTaskCell
