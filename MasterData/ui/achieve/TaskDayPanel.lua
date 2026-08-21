-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Achieve\\TaskDayPanel.lua

local ResTask = require("ClientData/ResTask")
local ResColor = require("ClientData/ResColor")
local ResRandClient = require("ClientData/ResRandClient")
local TaskConfig = require("DesignerScript/TaskConfig")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local TaskDayPanel = Class("TaskDayPanel", UIControls.Child)
local DailySubTaskCell = Class("DailySubTaskCell", UIControls.ScrollViewLoopCell)

function DailySubTaskCell:ctor(...)
	self:initUI()
end

function DailySubTaskCell:initUI(...)
	self.animator = UIControls.Panel(self, "TaskDayListCell")
	self.titleTxt = UIControls.Label(self, "TaskDayListCell/RulePanel/TextRuleTitle")
	self.ruleTxt = UIControls.Label(self, "TaskDayListCell/RulePanel/TextRule")
	self.processSlider = UIControls.Slider(self, "TaskDayListCell/Slider")
	self.processTxt1 = UIControls.Label(self, "TaskDayListCell/TextNum1")
	self.processTxt2 = UIControls.Label(self, "TaskDayListCell/TextNum2")
	self.getAwardBtn = UIControls.Button(self, "TaskDayListCell/BtnConfirm")

	self.getAwardBtn:addEventClick(self.onClickGetAward)

	self.gotoBtn = UIControls.Button(self, "TaskDayListCell/BtnGo")

	self.gotoBtn:addEventClick(self.onClickGoto)

	self.completeTxt = UIControls.Label(self, "TaskDayListCell/TextState")
	self.jumpLockTxt = UIControls.Label(self, "TaskDayListCell/TextLock")
	self.efxPanel = UIControls.Panel(self, "TaskDayListCell/EfxGridItem")
	self.itemGridPath = "TaskDayListCell/GridItemPanel"
	self.cellBgImg = UIControls.Image(self, "TaskDayListCell")
	self.dayBgImg = UIControls.Image(self, "TaskDayListCell/BgDayCell")
	self.anim = UIControls.UIAni(self, "")
end

function DailySubTaskCell:setSubTaskCell(taskId)
	if self.subTaskId and self.subTaskId == taskId then
		return
	end

	self.subTaskId = taskId

	local taskInfo = ResTask[taskId]

	if not taskInfo then
		return
	end

	if self.itemGrid then
		self.itemGrid:destroy()

		self.itemGrid = nil
	end

	local awardRandId = taskInfo.award_value

	if awardRandId and ResRandClient[awardRandId] then
		local itemId = ResRandClient[awardRandId].show_ids[1]
		local itemNum = ResRandClient[awardRandId].show_nums[1]

		itemNum = CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_EBONUS_DAILY_TASK, itemNum)

		local fakeItem = BaseObject.GetObject(itemId, itemNum)

		self.itemGrid = UIControls.ItemGridChild(self, self.itemGridPath, "System/Common/Grid/GridMaterialItem", 0, 0, true)
		self.itemGrid.mDisableWays = true

		self.itemGrid:setObj(fakeItem)
	end

	if RegionUtils.isLangJP() then
		self.titleTxt:setVisible(false)
	else
		self.titleTxt:setText(taskInfo.name or "")
	end

	self.ruleTxt:setText(taskInfo.action_desc or "")

	self.needProcess = taskInfo.action_param
	self.jumpId = taskInfo.jump_guide_id
end

function DailySubTaskCell:refreshSubTaskCell(...)
	local process, needProcess = CurAvatar:getTaskProcess(self.subTaskId)

	if needProcess then
		self.processTxt1:setText(process)
		self.processTxt2:setText(needProcess)

		local percent = process / needProcess

		self.processSlider:setValue(percent)
	end

	local status = CurAvatar:getTaskStatus(self.subTaskId)

	self.status = status

	local isGot = status == Const.TASK_STATUS.AWARD_GOT
	local isComplete = status == Const.TASK_STATUS.COMPLETE
	local inProcess = status == Const.TASK_STATUS.IN_PROCESS
	local jumpLock = false
	local jumpLockDesc

	if self.jumpId ~= nil then
		jumpLock, jumpLockDesc = JumpGuideManager.isConditionLimited(self.jumpId)
	end

	self.getAwardBtn:setVisible(status == Const.TASK_STATUS.COMPLETE)
	self.gotoBtn:setVisible(status == Const.TASK_STATUS.IN_PROCESS and self.jumpId ~= nil and not jumpLock)
	self.completeTxt:setVisible(isGot)
	self.jumpLockTxt:setVisible(jumpLock)

	if jumpLock and jumpLockDesc then
		self.jumpLockTxt:setText(jumpLockDesc)
	end

	if isGot then
		-- block empty
	end

	self.itemGrid:setIconGray(isGot)

	local nextState = "TaskDayListCellNml"

	if inProcess then
		-- block empty
	else
		nextState = isComplete and "TaskDayListCellHigh" or "TaskDayListCellDis"
	end

	self.animator:playStateAnimator(nextState)
	self.anim:startAni("ShowTaskDayListCell", true)
end

function DailySubTaskCell:destroy(...)
	if self.getAwardTimer then
		self.getAwardTimer:Stop()

		self.getAwardTimer = nil
	end

	DailySubTaskCell.super.destroy(self)
end

function DailySubTaskCell:onClickGetAward(...)
	if self.getAwardTimer then
		return
	end

	self.anim:startAni("TaskDayListCellEnd", true)
	self.efxPanel:setVisible(true)

	if self.itemGrid and self.itemGrid.object and BaseObject.isAttrs(self.itemGrid.object.id) then
		self.itemGrid:flyToCommonFuncEntryPanel()
	end

	self.getAwardTimer = Timer.New(Slot(self._delayGetAward, self), TaskConfig.AWARD_EFX_LENGTH)

	self.getAwardTimer:Start()
end

function DailySubTaskCell:onGetAllAnim()
	if self.itemGrid and self.itemGrid.object and BaseObject.isAttrs(self.itemGrid.object.id) then
		self.itemGrid:flyToCommonFuncEntryPanel()
	end
end

function DailySubTaskCell:_delayGetAward()
	self.efxPanel:setVisible(false)

	self.getAwardTimer = nil

	CurAvatar:getDailyTaskAward(self.subTaskId)
end

function DailySubTaskCell:onClickGoto(...)
	if self.jumpId then
		JumpGuideManager.jump(self.jumpId)
	end
end

function TaskDayPanel:ctor(...)
	self:initUI()
end

function TaskDayPanel:initUI(...)
	self.awardNameTxt = UIControls.Label(self, "TextName")
	self.awardTipsBtn = UIControls.Button(self, "TextName/BtnTips")

	self.awardTipsBtn:setVisible(false)

	self.awardImg = UIControls.Image(self, "ImgAward")
	self.awardTitleTxt = UIControls.Label(self, "TextRuleTitle")
	self.awardRuleTxt = UIControls.Label(self, "TextRule")
	self.awardProcessSlider = UIControls.Slider(self, "Slider")
	self.awardProcessTxt = UIControls.Label(self, "TextNum")
	self.getAwardBtn = UIControls.Button(self, "BtnConfirm", "Text")

	self.getAwardBtn:addEventClick(self.onClickGetAward)

	self.getAwardEfx = UIControls.Panel(self, "BtnConfirm/EfxBtnConfirm")
	self.completeTxt = UIControls.Label(self, "TextComplete")
	self.countDownTxt = UIControls.Label(self, "TextNumBreak")

	self.countDownTxt:setVisible(false)

	self.subTaskPath = "TaskListPanel/TaskList/Content"
	self.subTaskScroll = UIControls.ScrollViewLoopV(self, "TaskListPanel/TaskList")

	self.subTaskScroll:addEventCellChanged(self.onSubTaskChanged)

	self.subTaskCells = {}
	self.panelGetAll = UIControls.Panel(self, "TaskListPanel/GetAllPanel")
	self.btnGetAll = UIControls.Button(self, "TaskListPanel/GetAllPanel/BtnGetAll")

	self.btnGetAll:addEventClick(self.onGetAllClick)
end

function TaskDayPanel:setTaskPanel()
	self.dailyMainTask = CurAvatar.dailyMainTask

	if not self.dailyMainTask then
		return
	end

	local awardNum = CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_EBONUS_DAILY_TASK, 100)
	local mainTaskInfo = CurAvatar.mainTaskClientInfo[self.dailyMainTask]

	if mainTaskInfo then
		local iconPath = mainTaskInfo.iconPath
		local icon = mainTaskInfo.icon

		if iconPath and icon then
			self.awardImg:setImage(iconPath, icon)
		end

		self.awardItemId = mainTaskInfo.itemId

		if not self.awardItemId then
			-- block empty
		else
			self.awardFakeItem = BaseObject.GetObject(self.awardItemId)

			self.awardNameTxt:setText(string.format(self.awardFakeItem.name, awardNum))
		end
	end

	local taskInfo = ResTask[self.dailyMainTask]

	self.awardTitleTxt:setText(taskInfo.name or "")
	self.awardRuleTxt:setText(string.format(taskInfo.action_desc or "", awardNum))

	self.needProcess = taskInfo.action_param
end

function TaskDayPanel:refreshTeskPanel()
	local process, needProcess = CurAvatar:getTaskProcess(self.dailyMainTask)

	if needProcess then
		self.awardProcessTxt:setText(math.floor(process * 100 / needProcess))

		local percent = process / needProcess

		self.awardProcessSlider:setValue(percent)
	end

	local status = CurAvatar:getTaskStatus(self.dailyMainTask)
	local isGot = status == Const.TASK_STATUS.AWARD_GOT

	self.getAwardBtn:setVisible(not isGot)
	self.completeTxt:setVisible(isGot)

	if not isGot then
		self.getAwardBtn:setEnable(status == Const.TASK_STATUS.COMPLETE)
		self.getAwardEfx:setVisible(status == Const.TASK_STATUS.COMPLETE)

		if status == Const.TASK_STATUS.COMPLETE then
			self.getAwardBtn:setText(Lang.get(38))
		else
			self.getAwardBtn:setText(Lang.get(30119))
		end
	end

	self.dailyTaskList = CurAvatar:getSortedDailyTask()
	self.corDelaySetTotalCnt = coroutine.start(self.delaySetTotalCnt, self)

	local canGet = status == Const.TASK_STATUS.COMPLETE

	if not canGet then
		for _, taskId in ipairs(self.dailyTaskList) do
			local status = CurAvatar:getTaskStatus(taskId)

			if status == Const.TASK_STATUS.COMPLETE then
				canGet = true

				break
			end
		end
	end

	self.panelGetAll:setVisible(canGet)
end

function TaskDayPanel:delaySetTotalCnt()
	coroutine.step()
	self.subTaskScroll:setTotalCount(#self.dailyTaskList)
end

function TaskDayPanel:onSubTaskChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = DailySubTaskCell(sender, "System/Task/TaskDayListCellPanel", newIdx, 0, 0)
	else
		self.subTaskCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local taskId = self.dailyTaskList[newIdx]

	if taskId then
		targetCell:setSubTaskCell(taskId)
		targetCell:refreshSubTaskCell()
	end

	self.subTaskCells[newIdx] = targetCell
end

function TaskDayPanel:onClickAwardTips(...)
	if not self.awardFakeItem then
		return
	end

	UIManager.getUI("itemTips"):showObj(self, self.awardFakeItem)
end

function TaskDayPanel:onClickGetAward(...)
	if BaseObject.isAttrs(self.awardItemId) then
		FlyIconUtils.sendFlyEvent(self.awardImg, self.awardFakeItem.id, self.awardFakeItem.num)
	end

	CurAvatar:getDailyTaskAward(self.dailyMainTask)
end

function TaskDayPanel:onGetAllClick()
	local canGotList = {}

	for _, taskId in ipairs(self.dailyTaskList) do
		local status = CurAvatar:getTaskStatus(taskId)

		if status == Const.TASK_STATUS.COMPLETE then
			table.insert(canGotList, taskId)
		end
	end

	for _, cell in pairs(self.subTaskCells) do
		if cell.status == Const.TASK_STATUS.COMPLETE then
			cell:onGetAllAnim()
		end
	end

	local process, needProcess = CurAvatar:getTaskProcess(self.dailyMainTask)

	if needProcess <= process + #canGotList then
		table.insert(canGotList, self.dailyMainTask)
	end

	CurAvatar:getAllDailyTask(canGotList)
end

return TaskDayPanel
