-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RentTask\\RentGroupTaskInfoPage.lua

local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local strClassName = "RentGroupTaskInfoPage"
local RentGroupTaskInfoPage = Class(strClassName, UIControls.Child)
local RentSubTaskCell = Class("RentSubTaskCell", UIControls.Child)

function RentSubTaskCell:ctor(...)
	self:initUI()
end

function RentSubTaskCell:initUI(...)
	self.difficutyImg = UIControls.Image(self, "DifficultyPanel/ImgDifficultyLv")
	self.modelImg = UIControls.Image(self, "DifficultyPanel/ImgMode")
	self.singleBossPanel = UIControls.Panel(self, "DifficultyPanel/BossPanelOne")
	self.singleBossRole = UIControls.Role(self, "DifficultyPanel/BossPanelOne/GridHeroPortraitPanel/HeroPanel", 0, 0)
	self.multiBossPanel = UIControls.Panel(self, "DifficultyPanel/BossPanelTwo")
	self.multiBossRole1 = UIControls.Role(self, "DifficultyPanel/BossPanelTwo/GridHeroPortraitPanel1/HeroPanel", 0, 0)
	self.multiBossRole2 = UIControls.Role(self, "DifficultyPanel/BossPanelTwo/GridHeroPortraitPanel2/HeroPanel", 0, 0)
	self.multiBossRole1Mask = UIControls.Image(self, "DifficultyPanel/BossPanelTwo/Bg1Mask/Bg1")
	self.awardCells = {}
	self.awardUpImg = UIControls.Panel(self, "DifficultyPanel/ImgUp")
	self.inProcessingTxt = UIControls.Image(self, "DifficultyPanel/TextGoOn")
	self.finishedTxt = UIControls.Image(self, "DifficultyPanel/TextFinish")
	self.easyBlock = UIControls.Panel(self, "DifficultyPanel/ImgBlockEasy")
	self.hardBlock = UIControls.Panel(self, "DifficultyPanel/ImgBlockHard")
	self.newImg = UIControls.Image(self, "DifficultyPanel/IconNew")
	self.rootPanel = UIControls.Panel(self, "DifficultyPanel")
	self.rootBtn = UIControls.Button(self, "")

	self.rootBtn:addEventClick(self._onSelectBoss)

	self.rareBtn = UIControls.Button(self, "DifficultyPanel/BtnRare")

	self.rareBtn:addEventClick(self._onClickRareNotice)
end

function RentSubTaskCell:setSubTaskCell(taskId, taskItem, index, status, overdueTick)
	if taskId then
		local taskInfo = RentTaskUtils.getTaskData(taskId)

		if not taskInfo then
			return
		end

		local difficuty = taskInfo.type
		local difficutyStateName

		self.difficutyImg:setImage("Atlas/CaseTaskAtlas/CaseTaskAtlas", "BgDifficultyLv" .. difficuty)

		if difficuty == Const.RENT_TASK_TYPE.Normal then
			self.modelImg:setImage("Atlas/CaseTaskAtlas/CaseTaskAtlas", "BgMode1")

			difficutyStateName = "EasyDifficultyPanel"
		elseif difficuty == Const.RENT_TASK_TYPE.Advanced then
			self.modelImg:setImage("Atlas/CaseTaskAtlas/CaseTaskAtlas", "BgMode2")

			difficutyStateName = "NormalDifficultyPanel"
		elseif difficuty == Const.RENT_TASK_TYPE.Rare or difficuty == Const.RENT_TASK_TYPE.ExtraRare then
			self.modelImg:setImage("Atlas/CaseTaskAtlas/CaseTaskAtlas", "BgMode2")

			difficutyStateName = "HardDifficultyPanel"
		end

		self.difficuty = difficuty
		self.multiBoss = difficuty ~= Const.RENT_TASK_TYPE.Normal

		local portList = taskInfo.port_list

		self.singleBossPanel:setVisible(not self.multiBoss)
		self.multiBossPanel:setVisible(self.multiBoss)

		if not self.multiBoss then
			if portList[1] then
				self.singleBossRole:showRole(portList[1], UIConst.ROLEIMAGE_SHOWTYPE_RENT_TASK)
			end
		elseif #portList == 2 then
			self.multiBossRole1:showRole(portList[1], UIConst.ROLEIMAGE_SHOWTYPE_RENT_TASK)
			self.multiBossRole2:showRole(portList[2], UIConst.ROLEIMAGE_SHOWTYPE_RENT_TASK)
		end

		local taskLastLong = RentTaskUtils.getTaskTimeLimit() * 3600
		local taskStartTime = overdueTick - taskLastLong
		local taskIsUp = CurAvatar:calcRentUpWeek(taskStartTime)
		local taskReplaceAward = RentTaskUtils.groupTaskReplaceAward(self.mParent.groupTaskId)

		if taskIsUp then
			if taskReplaceAward and taskInfo.up_replace_award then
				ClientUtils.CreateBonusGrid(self, self.awardCells, "DifficultyPanel/AwardPanel", taskInfo.up_replace_award, true, nil, true)
			else
				ClientUtils.CreateBonusGrid(self, self.awardCells, "DifficultyPanel/AwardPanel", taskInfo.up_award, true, nil, true)
			end
		elseif taskReplaceAward and taskInfo.normal_replace_award then
			ClientUtils.CreateBonusGrid(self, self.awardCells, "DifficultyPanel/AwardPanel", taskInfo.normal_replace_award, true, nil, true)
		else
			ClientUtils.CreateBonusGrid(self, self.awardCells, "DifficultyPanel/AwardPanel", taskInfo.normal_award, true, nil, true)
		end

		self.awardUpImg:setVisible(taskIsUp)

		self.battleCount = #taskInfo.pve

		self.rootPanel:playStateAnimator(difficutyStateName)
		self.rareBtn:setVisible(difficuty == Const.RENT_TASK_TYPE.ExtraRare)
	end

	self.taskId = taskId
	self.taskItem = taskItem
	self.index = index
	self.status = status
	self.taskBattleStatus = RentTaskUtils.getTaskStatus(taskId, taskItem)

	self.inProcessingTxt:setVisible(self.status == "selected")

	local bossOneNeedGray = false

	if self.status == "selected" then
		self.finishedTxt:setVisible(self.taskBattleStatus == Const.RENT_TASK_STATUS.Complete)
		self.easyBlock:setVisible(false)
		self.hardBlock:setVisible(false)

		bossOneNeedGray = self.taskBattleStatus == Const.RENT_TASK_STATUS.FinishHalf
	end

	self.multiBossRole1Mask:setObjGray(bossOneNeedGray)
	self.multiBossRole1:setObjGray(bossOneNeedGray)

	if self.multiBoss and self.status == "selected" then
		local hasNew = CurAvatar:checkRentGroupTaskUnBorrowRD(self.mParent.groupTaskId) or CurAvatar:checkRentGroupTaskBorrowSucRD(self.mParent.groupTaskId)

		self.newImg:setVisible(hasNew)
	else
		self.newImg:setVisible(false)
	end
end

function RentSubTaskCell:setTaskValid(isValid, selectTaskStatus, isOverdue)
	self.taskIsValid = isValid

	if isOverdue then
		self.rootPanel:setObjGray(true, true)

		return
	end

	if self.status == "unselected" then
		self.inProcessingTxt:setVisible(false)
		self.finishedTxt:setVisible(false)
		self.easyBlock:setVisible(false)
		self.hardBlock:setVisible(false)
		self.rootPanel:setObjGray(false, true)
	elseif self.status == "locked" then
		if selectTaskStatus == Const.RENT_TASK_STATUS.New or selectTaskStatus == Const.RENT_TASK_STATUS.FinishHalf then
			self.inProcessingTxt:setVisible(false)
			self.finishedTxt:setVisible(false)
			self.easyBlock:setVisible(self.difficuty == Const.RENT_TASK_TYPE.Normal or self.difficuty == Const.RENT_TASK_TYPE.Advanced)
			self.hardBlock:setVisible(self.difficuty == Const.RENT_TASK_TYPE.Rare or self.difficuty == Const.RENT_TASK_TYPE.ExtraRare)
			self.rootPanel:setObjGray(false, true)
		else
			self.inProcessingTxt:setVisible(false)
			self.finishedTxt:setVisible(false)
			self.easyBlock:setVisible(false)
			self.hardBlock:setVisible(false)
			self.rootPanel:setObjGray(true, true)
		end
	elseif self.status == "selected" then
		self.rootPanel:setObjGray(not isValid, true)
		self.inProcessingTxt:setVisible(isValid)

		if not isValid then
			self.finishedTxt:setObjGray(true)
			self.finishedTxt:setObjGray(false)
		end
	end
end

function RentSubTaskCell:_onSelectBoss(...)
	if not self.index or not self.taskId then
		return
	end

	if not self.taskIsValid then
		return
	end

	if self.status == "unselected" then
		self.mParent:inSelectState(self.index, self.taskId)
	elseif self.status == "locked" then
		if CurAvatar.rentChangeSelectTimeStamp[self.mParent.groupTaskId] then
			local overdueTick = CurAvatar.rentChangeSelectTimeStamp[self.mParent.groupTaskId] + 180
			local nowTime = ClientUtils.getServerTime()

			if nowTime < overdueTick then
				local leftTime = overdueTick - nowTime
				local leftTimeStr

				if leftTime < 60 then
					leftTimeStr = os.date(Lang.get(30722), leftTime)
				else
					leftTimeStr = os.date(Lang.get(30723), leftTime)
				end

				MsgManager.notice(string.format(RentTaskUtils.getRentNotice(11), leftTimeStr))

				return
			end
		end

		local function confirmChangeSelection(...)
			RentTaskUtils.selectRentTask(self.mParent.groupTaskId, self.taskId)
		end

		UIManager.showConfirmWithId(1028, confirmChangeSelection, nil, nil, nil)

		return
	else
		local bossInfoDlg = UIManager.getUI("rentBossInfoDlg", true)

		bossInfoDlg:setRentBossInfo(self.mParent.groupTaskId)
	end
end

function RentSubTaskCell:selectStateActive(isActive)
	self.rootBtn:setEnable(not isActive)
end

function RentSubTaskCell:_onClickRareNotice()
	MsgManager.clientNotice(636)
end

function RentGroupTaskInfoPage:ctor(...)
	self:initUI()
end

function RentGroupTaskInfoPage:initUI(...)
	self.ruleTxt = UIControls.Label(self, "TextRule")
	self.titleTxt = UIControls.Label(self, "TextTile")
	self.timeTxt = UIControls.Label(self, "TextTime")
	self.timeEndImg = UIControls.Image(self, "TextTime/ImgEnd")
	self.newImg = UIControls.Image(self, "IconNew")
	self.taskCellMountPath = "CasePanel"
	self.cells = {}
end

function RentGroupTaskInfoPage:setRentGroupTaskInfo(taskData, isInit)
	self.titleTxt:setText(RentTaskUtils.getGroupTaskTitle(taskData.taskList))
	self:_startCountDownTimer(taskData.overdueTick)

	self.groupTaskId = taskData.groupTaskId

	self:setTaskCells(taskData.taskList, taskData.taskItems, taskData.selection, taskData.overdueTick)
	self:refreshTaskStatus(taskData.taskStatus, taskData.overdueTick)

	if isInit and self.inSelectingState then
		self:outSelectState()
	end
end

function RentGroupTaskInfoPage:setTaskCells(taskList, taskItems, selectTaskId, overdueTick)
	self.taskList = taskList

	for i, taskId in ipairs(self.taskList) do
		if not self.cells[i] then
			self.cells[i] = RentSubTaskCell(self, self.taskCellMountPath, "System/CaseTask/ChildCase", 0, 0, true)
		end

		local cell = self.cells[i]

		cell:setVisible(true)

		local selectStatus = "unselected"

		if selectTaskId and selectTaskId ~= 0 then
			if taskId == selectTaskId then
				selectStatus = "selected"
				self.selectTaskStatus = RentTaskUtils.getTaskStatus(taskId, taskItems[taskId])
			else
				selectStatus = "locked"
			end
		end

		cell:setSubTaskCell(taskId, taskItems[taskId], i, selectStatus, overdueTick)
	end

	if #self.cells > #self.taskList then
		for i = #self.cells, #self.taskList + 1, -1 do
			self.cells[i]:setVisible(false)
		end
	end
end

function RentGroupTaskInfoPage:refreshTaskStatus(taskStatus, taskOverdueTick)
	local isOverdue = taskOverdueTick < ClientUtils.getServerTime()
	local isComplete = taskStatus == Const.RENT_GROUPTASK_STATUS.Complete or taskStatus == Const.RENT_GROUPTASK_STATUS.Thanked

	for i, taskId in ipairs(self.taskList) do
		local cell = self.cells[i]

		if cell then
			cell:setTaskValid(not isOverdue and not isComplete, self.selectTaskStatus, isOverdue)
		end
	end

	if isOverdue then
		self.timeTxt:setTextWithColor(Lang.get(653), "RED")
		self.timeEndImg:setVisible(false)
	end

	local hasNew = CurAvatar:checkRentGroupTaskUnselectRD(self.groupTaskId) and not isOverdue and not isComplete

	self.newImg:setVisible(hasNew)
end

function RentGroupTaskInfoPage:inSelectState(index, taskId)
	if not self.inSelectingState then
		self.mParent.rootAni:startAni("ShowCheckWin", true)

		self.inSelectingState = true
	end

	for i, cell in ipairs(self.cells) do
		cell:selectStateActive(i == index)
	end

	self.cacheSelectTask = taskId
end

function RentGroupTaskInfoPage:outSelectState()
	if self.inSelectingState then
		self.mParent.rootAni:startAni("CloseCheckWin", true)

		self.inSelectingState = nil
	end

	for i, cell in ipairs(self.cells) do
		cell:selectStateActive(false)
	end

	self.cacheSelectTask = nil
end

function RentGroupTaskInfoPage:confirmSelection()
	local function realConfirm()
		if self.cacheSelectTask then
			RentTaskUtils.selectRentTask(self.groupTaskId, self.cacheSelectTask)

			self.cacheSelectTask = nil

			self:outSelectState()
		end
	end

	if self.cacheSelectTask then
		local taskInfo = RentTaskUtils.getTaskData(self.cacheSelectTask)
		local taskType = Const.RENT_TASK_TYPE.Normal

		if taskInfo then
			taskType = taskInfo.type
		end

		if #self.taskList == 2 and taskType == Const.RENT_TASK_TYPE.Normal or #self.taskList == 3 and taskType ~= Const.RENT_TASK_TYPE.Rare and taskType ~= Const.RENT_TASK_TYPE.ExtraRare then
			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), Lang.get(30724), realConfirm, nil, -1)
		else
			realConfirm()
		end
	end
end

function RentGroupTaskInfoPage:_startCountDownTimer(overdueTick)
	self:_stopCountDown()

	if overdueTick <= ClientUtils.getServerTime() then
		self:_showOverdue()

		return
	end

	self.targetTick = overdueTick

	self:_onTimerBeat()

	if not self.countDownTimer then
		self.countDownTimer = Timer.New(Slot(self._onTimerBeat, self), 1, -1)
	end

	self.countDownTimer:Start()
end

function RentGroupTaskInfoPage:_stopCountDown(...)
	if self.countDownTimer then
		self.countDownTimer:Stop()
	end
end

RentGroupTaskInfoPage.RED_COUNTDOWN_TICK = 18000

function RentGroupTaskInfoPage:_onTimerBeat(...)
	local nowTick = ClientUtils.getServerTime()

	if not self.targetTick or nowTick > self.targetTick then
		self:_stopCountDown()
		self:_showOverdue()

		return
	end

	local leftTick = self.targetTick - nowTick
	local timeStr = string.format(Lang.get(30720), utils.calcShortTimeTxt(leftTick))

	if leftTick > self.RED_COUNTDOWN_TICK then
		self.timeTxt:setText(timeStr)
		self.timeEndImg:setVisible(false)
	else
		self.timeTxt:setTextWithColor(timeStr, "RED")
		self.timeEndImg:setVisible(true)
	end
end

function RentGroupTaskInfoPage:_showOverdue()
	local taskData = RentTaskUtils.getGroupTaskSvrData(self.groupTaskId)

	if taskData then
		self:refreshTaskStatus(taskData.taskStatus, taskData.overdueTick)
	end
end

function RentGroupTaskInfoPage:onPageClose()
	if self.inSelectingState then
		self:outSelectState()
	end

	self:_stopCountDown()
end

return RentGroupTaskInfoPage
