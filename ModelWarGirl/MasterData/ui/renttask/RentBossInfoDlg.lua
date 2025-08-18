-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RentTask\\RentBossInfoDlg.lua

local DragTwoPages = require("UI/Control/DragTwoPages")
local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local strClassName = "RentBossInfoDlg"
local RentBossInfoDlg = Class(strClassName, UIControls.Window)
local RentBossInfoPage = Class("RentBossInfoPage", UIControls.Child)

function RentBossInfoPage:ctor(...)
	self:initUI()
end

function RentBossInfoPage:initUI(...)
	self.upPanel = UIControls.Panel(self, "ImgUpPanel/ImgUp")
	self.awardNoticeTxt = UIControls.Label(self, "ImgUpPanel/TextRule")
	self.awardCells = {}
	self.singleBossPanel = UIControls.Panel(self, "BossPanelOne")
	self.multiBossPanel = UIControls.Panel(self, "BossPanelTwo")
	self.singleBossLvTxt = UIControls.Label(self, "BossPanelOne/TextPower")
	self.singleBossRole = UIControls.Role(self, "BossPanelOne/GridHeroPortraitPanel/HeroPanel", 0, 0)
	self.singleBossRoleShadow = UIControls.Role(self, "BossPanelOne/GridHeroPortraitPanelShadow/HeroPanel", 0, 0)
	self.singleBossBtn = UIControls.Button(self, "BossPanelOne/BtnConfirm")

	self.singleBossBtn:addEventClick(self._onClickSingleBossBattle)

	self.multiBossLvTxt1 = UIControls.Label(self, "BossPanelTwo/TextPower1")
	self.multiBossRole1 = UIControls.Role(self, "BossPanelTwo/GridHeroPortraitPanel1/HeroPanel")
	self.multiBossRole1Shadow = UIControls.Role(self, "BossPanelTwo/GridHeroPortraitPanelShadow1/HeroPanel")
	self.multiBossBtn1 = UIControls.Button(self, "BossPanelTwo/BtnConfirm1")

	self.multiBossBtn1:addEventClick(self._onClickMultiBossBattle1)

	self.multiBossLvTxt2 = UIControls.Label(self, "BossPanelTwo/TextPower2")
	self.multiBossRole2 = UIControls.Role(self, "BossPanelTwo/GridHeroPortraitPanel2/HeroPanel")
	self.multiBossRole2Shadow = UIControls.Role(self, "BossPanelTwo/GridHeroPortraitPanelShadow2/HeroPanel")
	self.multiBossBtn2 = UIControls.Button(self, "BossPanelTwo/BtnConfirm2")
	self.multiBossNewImg = UIControls.Image(self, "BossPanelTwo/BtnConfirm2/IconNew")

	self.multiBossBtn2:addEventClick(self._onClickMultiBossBattle2)

	self.multiBoss1Mask = UIControls.Panel(self, "BossPanelTwo/MaskBgL")
	self.finishedTxt = UIControls.Label(self, "BossPanelTwo/TextFinish")
end

function RentBossInfoPage:setBossInfo(taskId, overdueTick)
	local taskInfo = RentTaskUtils.getTaskData(taskId)

	if not taskInfo then
		return
	end

	self.taskId = taskId
	self.overdueTick = overdueTick

	local taskLastLong = RentTaskUtils.getTaskTimeLimit() * 3600
	local taskStartTime = overdueTick - taskLastLong
	local taskIsUp = CurAvatar:calcRentUpWeek(taskStartTime)
	local taskReplaceAward = RentTaskUtils.groupTaskReplaceAward(self.mParent.groupTaskId)

	if taskIsUp then
		if taskReplaceAward and taskInfo.up_replace_award then
			ClientUtils.CreateBonusGrid(self, self.awardCells, "AwardPanel", taskInfo.up_replace_award, true, nil, true)
		else
			ClientUtils.CreateBonusGrid(self, self.awardCells, "AwardPanel", taskInfo.up_award, true, nil, true)
		end
	elseif taskReplaceAward and taskInfo.normal_replace_award then
		ClientUtils.CreateBonusGrid(self, self.awardCells, "AwardPanel", taskInfo.normal_replace_award, true, nil, true)
	else
		ClientUtils.CreateBonusGrid(self, self.awardCells, "AwardPanel", taskInfo.normal_award, true, nil, true)
	end

	self.upPanel:setVisible(taskIsUp)

	self.multiBoss = RentTaskUtils.hasMultiBattle(taskId)

	self.singleBossPanel:setVisible(not self.multiBoss)
	self.multiBossPanel:setVisible(self.multiBoss)

	local svrMaxStage = RentTaskUtils.getGroupTaskMaxStage(self.mParent.groupTaskId)
	local portList = taskInfo.port_list

	if not self.multiBoss then
		if portList[1] then
			self.singleBossRole:showRole(portList[1], UIConst.ROLEIMAGE_SHOWTYPE_RENT_TASK_DETAIL)
			self.singleBossRoleShadow:showRole(portList[1], UIConst.ROLEIMAGE_SHOWTYPE_RENT_TASK_DETAIL)
		end

		local stageConfig = utils.getRentStageData(taskId, false, ClientUtils.getMainStageLevelNum(), svrMaxStage)

		self.singleBossLvTxt:setText(stageConfig.show_level)
		self.awardNoticeTxt:setText(Lang.get(30721))
	else
		if #portList == 2 then
			self.multiBossRole1:showRole(portList[1], UIConst.ROLEIMAGE_SHOWTYPE_RENT_TASK_DETAIL)
			self.multiBossRole1Shadow:showRole(portList[1], UIConst.ROLEIMAGE_SHOWTYPE_RENT_TASK_DETAIL)
			self.multiBossRole2:showRole(portList[2], UIConst.ROLEIMAGE_SHOWTYPE_RENT_TASK_DETAIL)
			self.multiBossRole2Shadow:showRole(portList[2], UIConst.ROLEIMAGE_SHOWTYPE_RENT_TASK_DETAIL)
		end

		local stageConfig = utils.getRentStageData(taskId, false, ClientUtils.getMainStageLevelNum(), svrMaxStage)

		self.multiBossLvTxt1:setText(stageConfig.show_level)

		stageConfig = utils.getRentStageData(taskId, true, ClientUtils.getMainStageLevelNum(), svrMaxStage)

		self.multiBossLvTxt2:setText(stageConfig.show_level)
		self.awardNoticeTxt:setText(Lang.get(696))
	end

	self.pveIdList = taskInfo.pve

	local taskType = taskInfo.type

	if taskType == Const.RENT_TASK_TYPE.Advanced then
		self:playStateAnimator("NormalChildCaseTaskBossPanel")
	elseif taskType == Const.RENT_TASK_TYPE.Rare or taskType == Const.RENT_TASK_TYPE.ExtraRare then
		self:playStateAnimator("HardChildCaseTaskBossPanel")
	end
end

function RentBossInfoPage:isMultiBoss(...)
	return self.multiBoss
end

function RentBossInfoPage:refreshBossStatus(taskItem)
	self.taskStatus = RentTaskUtils.getTaskStatus(self.taskId, taskItem)

	local maskNeedGray = false

	if not self.multiBoss then
		self.singleBossBtn:setVisible(self.taskStatus ~= Const.RENT_TASK_STATUS.Complete)
	else
		self.multiBossBtn1:setVisible(self.taskStatus == Const.RENT_TASK_STATUS.New)
		self.multiBossBtn2:setEnable(self.taskStatus ~= Const.RENT_TASK_STATUS.New)
		self.finishedTxt:setVisible(self.taskStatus == Const.RENT_TASK_STATUS.FinishHalf)
		self.multiBossNewImg:setVisible(CurAvatar:checkRentGroupTaskUnBorrowRD(self.mParent.groupTaskId) or CurAvatar:checkRentGroupTaskBorrowSucRD(self.mParent.groupTaskId))

		maskNeedGray = self.taskStatus == Const.RENT_TASK_STATUS.FinishHalf
	end

	self.multiBoss1Mask:setObjGray(maskNeedGray)
	self.multiBossRole1:setObjGray(maskNeedGray)
	self.multiBossRole1Shadow:setObjGray(maskNeedGray)
end

function RentBossInfoPage:_onClickSingleBossBattle(...)
	if self.pveIdList and self.pveIdList[1] then
		local pveId = self.pveIdList[1].pveid
		local battleData = {}

		battleData.rentData = {
			hasAward = false,
			gtId = self.mParent.groupTaskId,
			taskId = self.taskId,
			pveId = pveId,
			overdueTick = self.overdueTick,
			svrMaxStage = RentTaskUtils.getGroupTaskMaxStage(self.mParent.groupTaskId)
		}

		CurAvatar:enterFormation(pveId, BattleConst.BATTLE_TYPE_RENT, battleData)
	end
end

function RentBossInfoPage:_onClickMultiBossBattle1(...)
	if self.pveIdList and self.pveIdList[1] then
		local pveId = self.pveIdList[1].pveid
		local battleData = {}

		battleData.rentData = {
			hasAward = false,
			gtId = self.mParent.groupTaskId,
			taskId = self.taskId,
			pveId = pveId,
			overdueTick = self.overdueTick,
			svrMaxStage = RentTaskUtils.getGroupTaskMaxStage(self.mParent.groupTaskId)
		}

		CurAvatar:enterFormation(pveId, BattleConst.BATTLE_TYPE_RENT, battleData)
	end
end

function RentBossInfoPage:_onClickMultiBossBattle2(...)
	local borrowDlg = UIManager.getUI("rentTeamBorrowDlg", true)

	if borrowDlg then
		borrowDlg:setTeamBorrowInfo(self.mParent.groupTaskId, self.taskId)
		borrowDlg:selectChoosePanel()
	end
end

function RentBossInfoDlg:ctor(...)
	self:initUI()
end

function RentBossInfoDlg:initUI(...)
	self.closeBtn = UIControls.Button(self, "Bg/BtnClose")

	self.closeBtn:addEventClick(self._onClickClose)

	self.infoPage = RentBossInfoPage(self, "Bg/ContentPanel", "System/CaseTask/ChildCaseTaskBossPanel")

	self.infoPage:setVisible(true)

	self.timeTxt = UIControls.Label(self, "Bg/TextTime")
	self.timeEndImg = UIControls.Image(self, "Bg/TextTime/ImgEnd")
	self.titleTxt = UIControls.Label(self, "Bg/TextTile")
	self.rootPanel = UIControls.Panel(self, "Bg")
end

function RentBossInfoDlg:setRentBossInfo(groupTaskId)
	self.groupTaskId = groupTaskId

	local rentTaskData = RentTaskUtils.getGroupTaskSvrData(groupTaskId)

	self.taskList = rentTaskData.taskList
	self.taskId = rentTaskData.selection

	self.infoPage:setBossInfo(self.taskId, rentTaskData.overdueTick)

	local multiBoss = self.infoPage:isMultiBoss()
	local taskName = RentTaskUtils.getTaskTitle(self.taskId)

	if taskName then
		self.titleTxt:setText(taskName)
	end

	self:_startCountDownTimer(rentTaskData.overdueTick)
	self:refresRentBossInfo()

	local taskType = RentTaskUtils.getTaskType(self.taskId)
	local bgAnimName

	if taskType == Const.RENT_TASK_TYPE.Normal then
		bgAnimName = "EasyCaseTaskBossCanvas"
	elseif taskType == Const.RENT_TASK_TYPE.Advanced then
		bgAnimName = "NormalCaseTaskBossCanvas"
	elseif taskType == Const.RENT_TASK_TYPE.Rare or taskType == Const.RENT_TASK_TYPE.ExtraRare then
		bgAnimName = "HardCaseTaskBossCanvas"
	end

	self.rootPanel:playStateAnimator(bgAnimName)
end

function RentBossInfoDlg:refresRentBossInfo(...)
	local rentTaskData = RentTaskUtils.getGroupTaskSvrData(self.groupTaskId)

	if rentTaskData and rentTaskData.taskItems and rentTaskData.taskItems[self.taskId] then
		self.infoPage:refreshBossStatus(rentTaskData.taskItems[self.taskId])
	end
end

function RentBossInfoDlg:_startCountDownTimer(overdueTick)
	self:_stopCountDown()

	self.targetTick = overdueTick

	self:_onTimerBeat()

	if not self.countDownTimer then
		self.countDownTimer = Timer.New(Slot(self._onTimerBeat, self), 1, -1)
	end

	self.countDownTimer:Start()
end

function RentBossInfoDlg:_stopCountDown(...)
	if self.countDownTimer then
		self.countDownTimer:Stop()
	end
end

RentBossInfoDlg.RED_COUNTDOWN_TICK = 18000

function RentBossInfoDlg:_onTimerBeat(...)
	local nowTick = ClientUtils.getServerTime()

	if not self.targetTick or nowTick > self.targetTick then
		self.timeTxt:setText("")
		self.timeEndImg:setVisible(false)
		self:_stopCountDown()

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

function RentBossInfoDlg:_onClickClose()
	self:setVisible(false)
end

function RentBossInfoDlg:onClose(...)
	self:_stopCountDown()
	RentBossInfoDlg.super.onClose(self)
end

return RentBossInfoDlg
