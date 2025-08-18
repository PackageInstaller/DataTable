-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Achieve\\AdvanceTaskDlg.lua

local ResTask = require("ClientData/ResTask")
local ResAdvanceTask = require("ClientData/ResAdvanceTask")
local ResRandClient = require("ClientData/ResRandClient")
local AdvanceTaskUtils = require("UI/Achieve/AdvanceTaskUtils")
local RechargeManager = require("System/Recharge/RechargeManager")
local TaskConfig = require("DesignerScript/TaskConfig")
local strClassName = "AdvanceTaskDlg"
local AdvanceTaskDlg = Class(strClassName, UIControls.Window)
local AdvanceSubTaskCell = Class("AdvanceSubTaskCell", UIControls.ScrollViewLoopCell)

function AdvanceSubTaskCell:ctor(...)
	self:initUI()
end

function AdvanceSubTaskCell:initUI(...)
	self.bgImg = UIControls.Image(self, "")
	self.bgAwardImg = UIControls.Image(self, "BgTaskCell")
	self.titleTxt = UIControls.Label(self, "RulePanel/TextRuleTitle")
	self.ruleTxt = UIControls.Label(self, "RulePanel/TextRule")
	self.efxPanel = UIControls.Panel(self, "EfxGridItem")
	self.progressSlider = UIControls.Slider(self, "Slider")
	self.sonNumTxt = UIControls.Label(self, "TextNum1")
	self.momNumTxt = UIControls.Label(self, "TextNum2")
	self.getAwardBtn = UIControls.Button(self, "BtnConfirm")

	self.getAwardBtn:addEventClick(self.onClickGetAward)

	self.gotoBtn = UIControls.Button(self, "BtnGo")

	self.gotoBtn:addEventClick(self.onClickGoto)

	self.stateTxt = UIControls.Label(self, "TextState")
	self.itemGridPath = "GridItemPanel"
end

function AdvanceSubTaskCell:setAdvanceSubTaskCell(isGroup, focusId, targetId)
	if self.isGroup == isGroup and self.focusId == focusId and self.targetId == targetId then
		return
	end

	self.isGroup = isGroup
	self.focusId = focusId
	self.targetId = targetId

	local itemId, itemNum, taskName, taskDesc, needProgress, jumpId

	if not isGroup then
		local taskInfo = ResTask[targetId]

		if not taskInfo then
			return
		end

		local awardRandId = taskInfo.award_value

		if awardRandId and ResRandClient[awardRandId] then
			itemId = ResRandClient[awardRandId].show_ids[1]
			itemNum = ResRandClient[awardRandId].show_nums[1]
		end

		taskName = taskInfo.name or ""
		taskDesc = taskInfo.action_desc or ""
		needProgress = taskInfo.action_param
		jumpId = taskInfo.jump_guide_id
	else
		local miscInfo = AdvanceTaskUtils.getAdvanceMiscData(focusId)

		if miscInfo then
			itemId = miscInfo.score_item_id
		end

		itemNum = ResAdvanceTask[focusId][targetId].score
		needProgress = ResAdvanceTask[focusId][targetId].action_param

		local clientInfo = AdvanceTaskUtils.getAdvanceGroupClientData(focusId, targetId)

		if clientInfo then
			taskName = clientInfo.task_name or ""
			taskDesc = clientInfo.task_desc or ""
			jumpId = clientInfo.jump_id
		end
	end

	if self.itemGrid then
		self.itemGrid:destroy()

		self.itemGrid = nil
	end

	if itemId then
		local fakeItem = BaseObject.GetObject(itemId, itemNum)

		self.itemGrid = UIControls.ItemGridChild(self, self.itemGridPath, "System/Common/Grid/GridMaterialItem", 0, 0, true)
		self.itemGrid.mDisableWays = true

		self.itemGrid:setObj(fakeItem)
	end

	if RegionUtils.isLangJP() then
		self.titleTxt:setVisible(false)
	else
		self.titleTxt:setVisible(true)
		self.titleTxt:setText(taskName)
	end

	self.ruleTxt:setText(taskDesc)

	self.needProgress = needProgress
	self.jumpId = jumpId
end

function AdvanceSubTaskCell:refreshAdvanceSubTaskCell()
	if not self.focusId or not self.targetId then
		return
	end

	local progress, needProgress, status

	if not self.isGroup then
		progress, needProgress = CurAvatar:getTaskProcess(self.targetId)
		status = CurAvatar:getTaskStatus(self.targetId)
	else
		progress, needProgress = AdvanceTaskUtils.getAdvanceTaskProcess(self.focusId, self.targetId)
		status = AdvanceTaskUtils.getAdvanceTaskStatus(self.focusId, self.targetId)
	end

	self.sonNumTxt:setText(progress)
	self.momNumTxt:setText(needProgress)

	local percent = progress / needProgress

	self.progressSlider:setValue(percent)

	local isInProcess = status == Const.TASK_STATUS.IN_PROCESS
	local isComplete = status == Const.TASK_STATUS.COMPLETE
	local isGot = status == Const.TASK_STATUS.AWARD_GOT

	self.getAwardBtn:setVisible(isComplete)
	self.gotoBtn:setVisible(isInProcess and self.jumpId ~= nil)
	self.stateTxt:setVisible(isGot)
	self.itemGrid:setIconGray(isGot)

	local nextState = "NmlBeginnerTaskBPListCell"

	if isComplete then
		nextState = "HighBeginnerTaskBPListCell"
	end

	if isGot then
		nextState = "DisBeginnerTaskBPListCell"
	end

	self:playStateAnimator(nextState)
end

function AdvanceSubTaskCell:destroy(...)
	if self.getAwardTimer then
		self.getAwardTimer:Stop()

		self.getAwardTimer = nil
	end

	AdvanceSubTaskCell.super.destroy(self)
end

function AdvanceSubTaskCell:onClickGetAward()
	if self.getAwardTimer then
		return
	end

	self.efxPanel:setVisible(true)

	if self.itemGrid and self.itemGrid.object and BaseObject.isAttrs(self.itemGrid.object.id) then
		self.itemGrid:flyToCommonFuncEntryPanel()
	end

	self.getAwardTimer = Timer.New(Slot(self._delayGetAward, self), TaskConfig.AWARD_EFX_LENGTH)

	self.getAwardTimer:Start()
end

function AdvanceSubTaskCell:_delayGetAward()
	self.efxPanel:setVisible(false)

	self.getAwardTimer = nil

	if not self.isGroup then
		CurAvatar:getNewbieTaskAward(self.targetId)
	else
		RPC.advanceGetTaskAward(self.focusId, self.targetId)
	end
end

function AdvanceSubTaskCell:onClickGoto(...)
	if self.jumpId then
		JumpGuideManager.jump(self.jumpId)
	end
end

local BPAwardCell = Class("BPAwardCell", UIControls.Panel)

function BPAwardCell:ctor(...)
	self:initUI()
end

function BPAwardCell:initUI(...)
	self.commStatePanel = UIControls.Panel(self, self.mPath .. "/NumPanel")
	self.scoreTxt = UIControls.Label(self, self.mPath .. "/NumPanel/TextNum")
	self.scoreImg = UIControls.Image(self, self.mPath .. "/NumPanel/Icon")
	self.afterNormalPanel = UIControls.Panel(self, self.mPath .. "/PayPanel")
	self.efxPanel = UIControls.Panel(self, self.mPath .. "/EfxGet")
	self.slotOfClickGrid = Slot(self.onClickGrid, self)
end

function BPAwardCell:setAwardInfo(stepInfo, scoreItem)
	self.groupId = stepInfo.group_id
	self.stepId = stepInfo.step

	self.scoreTxt:setText(stepInfo.score_need or 0)

	self.normalAward = stepInfo.normal_award
	self.superAward = stepInfo.super_award
	self.needExtraEfx = stepInfo.extra_efx == 1

	if scoreItem then
		local iconPath = BaseObject.getItemIconPath(scoreItem)

		if iconPath and #iconPath == 2 then
			self.scoreImg:setImage(iconPath[1], iconPath[2])
		end
	end
end

function BPAwardCell:refresAwardInfo()
	local groupInfo = AdvanceTaskUtils.getGroupSvrData(self.groupId)
	local curScore = 0
	local boughtBP = false

	if groupInfo then
		curScore = groupInfo.score
		boughtBP = groupInfo.boughtBP
	end

	local stepState = AdvanceTaskUtils.getStepState(self.groupId, self.stepId)

	self.commStatePanel:setVisible(stepState ~= AdvanceTaskUtils.STEP_STATE.NORMAL_GOT)
	self.afterNormalPanel:setVisible(stepState == AdvanceTaskUtils.STEP_STATE.NORMAL_GOT)

	local showAwardId = self.normalAward

	if stepState >= AdvanceTaskUtils.STEP_STATE.NORMAL_GOT and boughtBP then
		showAwardId = self.superAward
	end

	if showAwardId and ResRandClient[showAwardId] then
		self.itemId = ResRandClient[showAwardId].show_ids[1]
		self.itemNum = ResRandClient[showAwardId].show_nums[1]

		if not self.itemGrid then
			self.itemGrid = UIControls.getGridAwardContainer(self, self.mPath .. "/GridPanel")

			self.itemGrid:setVisible(true)
		end

		local item = BaseObject.GetObject(self.itemId, self.itemNum)

		self.itemGrid:setObj(item)

		self.itemGrid.grid.mDisableWays = true
		self.itemGrid.grid.mEnableTips = false
		self.itemGrid.grid.mEventClick = self.slotOfClickGrid
	end

	local hasNew = stepState == AdvanceTaskUtils.STEP_STATE.COMPLETE or stepState == AdvanceTaskUtils.STEP_STATE.NORMAL_GOT and boughtBP

	if self.itemGrid then
		self.itemGrid.grid:showNewHint(hasNew)
		self.itemGrid:setGet(stepState == AdvanceTaskUtils.STEP_STATE.SUPER_GOT)

		if self.needExtraEfx then
			self.itemGrid:setSpecEffect("Effects/UI/efx_ui_Reminder02.prefab", "System/Task/GridEfxCellNoMask")
		elseif self.itemGrid.lazyEffChild then
			self.itemGrid.lazyEffChild:setVisible(false)
		end
	end

	self.efxPanel:setVisible(hasNew)

	self.boughtBP = boughtBP
end

function BPAwardCell:onClickGrid()
	local stepState = AdvanceTaskUtils.getStepState(self.groupId, self.stepId)

	if stepState == AdvanceTaskUtils.STEP_STATE.COMPLETE then
		RPC.advanceGetStepAward(self.groupId, self.stepId, 0)
	elseif stepState == AdvanceTaskUtils.STEP_STATE.NORMAL_GOT then
		if self.boughtBP then
			RPC.advanceGetStepAward(self.groupId, self.stepId, 1)
		else
			MsgManager.clientNotice(511)
		end
	else
		BaseObject.ShowObjectTips(self.itemId, self.itemNum, self)
	end
end

local AdvanceBannerPanel = Class("AdvanceBannerPanel", UIControls.Panel)

function AdvanceBannerPanel:ctor(...)
	self:initUI()
end

function AdvanceBannerPanel:initUI(...)
	self.rechargePanel = UIControls.Panel(self, self.mPath .. "/BeforePayPanel")
	self.rechargeBtn = UIControls.Button(self, self.mPath .. "/BeforePayPanel/BtnFunc", "TextPrice")
	self.rechargeRuleTxt = UIControls.Label(self, self.mPath .. "/BeforePayPanel/BtnFunc/TextTitle")

	self.rechargeBtn:addEventClick(self._onClickRecharge)

	self.afterRechargePanel = UIControls.Panel(self, self.mPath .. "/AfterPayPanel")
	self.rootImg = UIControls.Image(self, self.mPath .. "/ImgAward")
	self.scoreTxt = UIControls.Label(self, self.mPath .. "/BPGetNumPanel/TextNum")
	self.scoreImg = UIControls.Image(self, self.mPath .. "/BPGetNumPanel/Icon")
	self.awardCells = {}

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, self.mPath .. "/BeforePayPanel/BtnFunc/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, self.mPath .. "/BeforePayPanel/BtnFunc/TextPt")

		self.priceDmmPanel:setVisible(true)
	end
end

function AdvanceBannerPanel:setAdvanceTaskBanner(groupId)
	self.groupId = groupId

	local groupClientInfo = AdvanceTaskUtils.getAdvanceGroupClientData(groupId, 1)

	if groupClientInfo then
		local bannerPath = groupClientInfo.banner_path
		local bannerIcon = groupClientInfo.banner_icon

		if bannerPath and bannerIcon then
			self.rootImg:setImage(bannerPath, bannerIcon)
		end

		self.rechargeRuleTxt:setText(groupClientInfo.buy_rule or "")

		self.rechargeConfirmRule = groupClientInfo.confirm_rule or ""
	end

	local miscInfo = AdvanceTaskUtils.getAdvanceMiscData(groupId)

	if miscInfo then
		self.rechargeId = miscInfo.recharge_id

		local product = RechargeManager.getProductByRechargeId(self.rechargeId)

		if product then
			self.rechargeBtn:setText(product.priceText)
		end

		self.scoreItem = miscInfo.score_item_id

		if self.scoreItem then
			local iconPath = BaseObject.getItemIconPath(self.scoreItem)

			if iconPath and #iconPath == 2 then
				self.scoreImg:setImage(iconPath[1], iconPath[2])
			end
		end
	end

	local stepClientInfo = AdvanceTaskUtils.getAdvanceStepData(groupId)

	if stepClientInfo then
		for i, stepInfo in ipairs(stepClientInfo) do
			local cell = self.awardCells[i]

			if not cell then
				cell = BPAwardCell(self, self.mPath .. "/TaskBPAwardPanel" .. i)
				cell.index = i
				self.awardCells[i] = cell
			end

			cell:setAwardInfo(stepInfo, self.scoreItem)
		end

		if #self.awardCells > #stepClientInfo then
			for i = #self.awardCells, #stepClientInfo + 1, -1 do
				self.awardCells[i]:destroy()

				self.awardCells[i] = nil
			end
		end
	end

	self.totalScore = 0

	local groupInfo = AdvanceTaskUtils.getAdvanceGroupData(groupId)

	if groupInfo then
		for taskId, taskInfo in pairs(groupInfo) do
			self.totalScore = self.totalScore + taskInfo.score
		end
	end
end

function AdvanceBannerPanel:refreshAdvanceTaskBanner(...)
	local groupInfo = AdvanceTaskUtils.getGroupSvrData(self.groupId)
	local curScore = 0
	local boughtBP = false

	if groupInfo then
		curScore = groupInfo.score or 0
		boughtBP = groupInfo.boughtBP or false
	end

	self.scoreTxt:setText(curScore .. "/" .. self.totalScore)
	self.rechargePanel:setVisible(not boughtBP)
	self.afterRechargePanel:setVisible(boughtBP)

	for i, cell in ipairs(self.awardCells) do
		cell:refresAwardInfo()
	end
end

function AdvanceBannerPanel:_onClickRecharge(...)
	local confirmDlg = UIManager.getUI("advanceBPConfirmDlg", true)

	confirmDlg:setBPInfo(self.rechargeId, self.rechargeConfirmRule)
end

local SpecBannerPanel = Class("SpecBannerPanel", UIControls.Panel)

function SpecBannerPanel:ctor(parent, path)
	self:initUI()
end

function SpecBannerPanel:initUI(...)
	self.itemIcon = UIControls.Image(self, self.mPath .. "/ImgAward")
	self.itemNameTxt = UIControls.Label(self, self.mPath .. "/BgName/TextName")
	self.itemTipsBtn = UIControls.Button(self, self.mPath .. "/BgName/TextName/BtnTips")

	self.itemTipsBtn:addEventClick(self.onClickItemTips)

	self.ruleTxt = UIControls.Label(self, self.mPath .. "/TextRule")
	self.progressSlider = UIControls.Slider(self, self.mPath .. "/Slider")
	self.progressTxt = UIControls.Label(self, self.mPath .. "/TextNum")
	self.completeTxt = UIControls.Label(self, self.mPath .. "/TextComplete")
	self.getAwardBtn = UIControls.Button(self, self.mPath .. "/BtnConfirm", "Text")

	self.getAwardBtn:addEventClick(self.onClickGetAward)
end

function SpecBannerPanel:setSpecTaskBanner(taskId)
	self.currentMainTask = taskId

	local mainTaskInfo = CurAvatar.advanceSpecTask[taskId]

	if not mainTaskInfo then
		return
	end

	local displayInfo = mainTaskInfo.displayInfo
	local bannerIconPath = displayInfo.iconPath
	local bannerIcon = displayInfo.icon
	local itemId = displayInfo.itemId

	if itemId then
		self:_setItemDisplay(itemId, bannerIconPath, bannerIcon)

		self.itemId = itemId
	end

	local taskInfo = ResTask[taskId]

	if not taskInfo then
		return
	end

	self.ruleTxt:setText(taskInfo.action_desc or "")

	self.needProgress = taskInfo.action_param
end

function SpecBannerPanel:refreshSpecTaskBanner(...)
	if not self.currentMainTask then
		return
	end

	local progress, needProgress = CurAvatar:getTaskProcess(self.currentMainTask)

	if needProgress then
		self.progressTxt:setText(math.floor(progress * 100 / needProgress))

		local percent = progress / needProgress

		self.progressSlider:setValue(percent)
	end

	local status = CurAvatar:getTaskStatus(self.currentMainTask)

	self.completeTxt:setVisible(status == Const.TASK_STATUS.AWARD_GOT)
	self.getAwardBtn:setVisible(status ~= Const.TASK_STATUS.AWARD_GOT)

	if status == Const.TASK_STATUS.IN_PROCESS then
		self.getAwardBtn:setEnable(false)
		self.getAwardBtn:setText(Lang.get(30119))
	elseif status == Const.TASK_STATUS.COMPLETE then
		self.getAwardBtn:setEnable(true)

		self.jumpId = nil

		self.getAwardBtn:setText(Lang.get(38))
	end
end

function SpecBannerPanel:_setItemDisplay(itemId, bannerPath, bannerIcon)
	local item = BaseObject.GetObject(itemId)

	if item then
		self.itemNameTxt:setText(item.name)
	end

	if bannerPath and bannerIcon then
		self.itemIcon:setImage(bannerPath, bannerIcon)
	end
end

function SpecBannerPanel:onClickGetAward(...)
	if self.jumpId then
		JumpGuideManager.jump(self.jumpId)
	else
		CurAvatar:getNewbieTaskAward(self.currentMainTask)
	end
end

function SpecBannerPanel:onClickItemTips(...)
	if not self.itemId then
		return
	end

	local fakeItem = BaseObject.GetObject(self.itemId)

	UIManager.getUI("itemTips"):showObj(self, fakeItem)
end

local AdvanceMainTaskCell = Class("AdvanceMainTaskCell", UIControls.Child)

function AdvanceMainTaskCell:ctor(...)
	self:initUI()
end

function AdvanceMainTaskCell:initUI(...)
	self.lockBtn = UIControls.Button(self, "BtnTaskDis")

	self.lockBtn:addEventClick(self.onClickWhenDis)

	self.unlockBtn = UIControls.Button(self, "BtnTask", "TextNum")

	self.unlockBtn:addEventClick(self.onClickSelect)

	self.newImg = UIControls.Image(self, "BtnTask/IconNew")
	self.finishImg = UIControls.Image(self, "BtnTask/IconFinish")
	self.ruleTxt = UIControls.Label(self, "BtnTask/TaskNamePanel/TextName")
	self.lockRuleTxt = UIControls.Label(self, "BtnTaskDis/TaskNamePanel/TextName")
	self.lockAwardImg = UIControls.Image(self, "BtnTaskDis/IconAward")
	self.unlockAwardImg = UIControls.Image(self, "BtnTask/IconAward")
end

function AdvanceMainTaskCell:setMainTaskTab(taskInfo)
	self.mainTaskId = taskInfo.parentTaskId
	self.groupId = nil

	local taskInfo = ResTask[self.mainTaskId]

	if not taskInfo then
		return
	end

	local displayInfo = {}

	if taskInfo.icon_path and taskInfo.icon then
		displayInfo.iconPath = {
			taskInfo.icon_path,
			taskInfo.icon
		}
	else
		local awardRandId = taskInfo.award_value

		if awardRandId and ResRandClient[awardRandId] then
			local itemId = ResRandClient[awardRandId].show_ids[1]
			local itemNum = ResRandClient[awardRandId].show_nums[1]
			local fakeItem = BaseObject.GetObject(itemId, itemNum)

			displayInfo.iconPath = fakeItem:getIconPath()
		end
	end

	displayInfo.unlockDesc = taskInfo.unlockDesc or Lang.get(30118)
	displayInfo.ruleDesc = nil

	self:_setDisplayInfo(displayInfo)
end

function AdvanceMainTaskCell:setAdvanceGroupTab(groupId, groupInfo)
	self.groupId = groupId
	self.mainTaskId = nil

	local displayInfo = {}
	local groupClientInfo = AdvanceTaskUtils.getAdvanceGroupClientData(groupId, 1)

	displayInfo.iconPath = {
		groupClientInfo.tab_path,
		groupClientInfo.tab_icon
	}
	displayInfo.unlockDesc = groupClientInfo.unlock_desc or Lang.get(30118)
	displayInfo.ruleDesc = groupClientInfo.tab_rule

	self:_setDisplayInfo(displayInfo)
end

function AdvanceMainTaskCell:_setDisplayInfo(displayInfo)
	local iconPath = displayInfo.iconPath

	if iconPath and #iconPath == 2 then
		self.lockAwardImg:setImage(iconPath[1], iconPath[2])
		self.lockAwardImg:setImageGray(true)
		self.unlockAwardImg:setImage(iconPath[1], iconPath[2])
	end

	if displayInfo.ruleDesc then
		self.ruleTxt:setVisible(true)
		self.ruleTxt:setText(displayInfo.ruleDesc)
		self.lockRuleTxt:setVisible(true)
		self.lockRuleTxt:setText(displayInfo.ruleDesc)
	else
		self.ruleTxt:setVisible(false)
		self.lockRuleTxt:setVisible(false)
	end

	self.unlockDesc = displayInfo.unlockDesc
end

function AdvanceMainTaskCell:refreshAdvanceMainTaskCell(...)
	if self.mainTaskId then
		local status = CurAvatar:getTaskStatus(self.mainTaskId)

		self.lockBtn:setVisible(status == Const.TASK_STATUS.NOT_ACTIVE)
		self.unlockBtn:setVisible(status ~= Const.TASK_STATUS.NOT_ACTIVE)
		self.finishImg:setVisible(status == Const.TASK_STATUS.AWARD_GOT)

		local hasNew = CurAvatar:checkAdvanceSpecTaskRDById(self.mainTaskId)

		self.newImg:setVisible(hasNew)

		local process, needProgress = CurAvatar:getTaskProcess(self.mainTaskId)

		self.unlockBtn:setText(math.floor(process * 100 / needProgress))
	elseif self.groupId then
		local isUnlock = CurAvatar:advanceGroupUnlock(self.groupId)

		self.lockBtn:setVisible(not isUnlock)
		self.unlockBtn:setVisible(isUnlock)

		local finished = CurAvatar:advanceGroupFinished(self.groupId)

		self.finishImg:setVisible(finished)

		local hasNew = CurAvatar:checkAdvanceGroupRDById(self.groupId)

		self.newImg:setVisible(hasNew)

		local process, needProgress = AdvanceTaskUtils.getStepsProcess(self.groupId)

		self.unlockBtn:setText(math.floor(process * 100 / needProgress))
	end
end

function AdvanceMainTaskCell:setEnable(isEnabled)
	self.unlockBtn:setEnable(isEnabled)
end

function AdvanceMainTaskCell:setSelectFunc(selectFunc)
	self.selectFunc = selectFunc
end

function AdvanceMainTaskCell:onClickSelect(...)
	if self.selectFunc then
		if self.mainTaskId then
			self.selectFunc(self.mainTaskId)
		elseif self.groupId then
			self.selectFunc(self.groupId)
		end
	end
end

function AdvanceMainTaskCell:onSelected(isSelect)
	return
end

function AdvanceMainTaskCell:onClickWhenDis(...)
	if self.unlockDesc then
		MsgManager.notice(self.unlockDesc)
	end
end

function AdvanceTaskDlg:ctor(...)
	self:initUI()
end

function AdvanceTaskDlg:initUI(...)
	self.closeBtn = UIControls.Button(self, "BtnClose")

	self.closeBtn:addEventClick(self._onClickClose)

	self.tipsBtn = UIControls.Button(self, "BtnTips")

	self.tipsBtn:addEventClick(self._onClickTips)

	self.bgImg = UIControls.RawImage(self, "BgImage")
	self.mainTaskListPath = "MainInfoPanel/TaskChooseList/Content"
	self.mainTaskCells = {}
	self.slotOfSelectTask = Slot(self.selectTaskById, self)
	self.slotOfSelectGroup = Slot(self.selectGroupById, self)

	self:setAdvanceTabData()

	self.comBannerPanel = AdvanceBannerPanel(self, "MainInfoPanel/BigTaskPanel/AwardBPPanel")
	self.specBannerPanel = SpecBannerPanel(self, "MainInfoPanel/BigTaskPanel/AwardItemPanel")
	self.subTaskListPath = "MainInfoPanel/TaskList/Content"
	self.subTaskScroll = UIControls.ScrollViewLoopV(self, "MainInfoPanel/TaskList")

	self.subTaskScroll:addEventCellChanged(self.onSubTaskChanged)

	self.subTaskCells = {}
end

function AdvanceTaskDlg:onOpen(...)
	AdvanceTaskDlg.super.onOpen(self)

	local isGroup, focusId = CurAvatar:getFocusAdvanceGroup()

	if isGroup then
		self:selectGroupById(focusId)
	else
		self:selectTaskById(focusId)
	end
end

function AdvanceTaskDlg:setAdvanceTabData()
	local index = 1

	self.specTaskData = CurAvatar.advanceSpecTask

	for _, specTaskInfo in pairs(self.specTaskData) do
		local mainCell = self.mainTaskCells[index]

		if not mainCell then
			mainCell = AdvanceMainTaskCell(self, self.mainTaskListPath, "System/Task/BeginnerTaskChooseBPCell", 0, 0, true)
			mainCell.index = index

			mainCell:setSelectFunc(self.slotOfSelectTask)

			self.mainTaskCells[index] = mainCell
		end

		mainCell:setMainTaskTab(specTaskInfo)

		index = index + 1
	end

	self.advanceGroupData = CurAvatar.advanceTaskGroup

	for groupId, groupInfo in pairs(self.advanceGroupData) do
		local mainCell = self.mainTaskCells[index]

		if not mainCell then
			mainCell = AdvanceMainTaskCell(self, self.mainTaskListPath, "System/Task/BeginnerTaskChooseBPCell", 0, 0, true)
			mainCell.index = index

			mainCell:setSelectFunc(self.slotOfSelectGroup)

			self.mainTaskCells[index] = mainCell
		end

		mainCell:setAdvanceGroupTab(groupId, groupInfo)

		index = index + 1
	end
end

function AdvanceTaskDlg:onSubTaskChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = AdvanceSubTaskCell(sender, "System/Task/BeginnerTaskBPListCell", newIdx, 0, 0)
	else
		self.subTaskCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local taskId = self.subTaskIdList[newIdx]

	if taskId then
		targetCell:setAdvanceSubTaskCell(self.isGroup, self.focusId, taskId)
		targetCell:refreshAdvanceSubTaskCell()
	end

	self.subTaskCells[newIdx] = targetCell
end

function AdvanceTaskDlg:selectTaskById(taskId)
	for i, mainCell in ipairs(self.mainTaskCells) do
		mainCell:setEnable(mainCell.mainTaskId ~= taskId)
		mainCell:onSelected(mainCell.mainTaskId == taskId)
	end

	self:setCurGroupInfo(false, taskId)
end

function AdvanceTaskDlg:selectGroupById(groupId)
	for i, mainCell in ipairs(self.mainTaskCells) do
		mainCell:setEnable(mainCell.groupId ~= groupId)
		mainCell:onSelected(mainCell.groupId == groupId)
	end

	self:setCurGroupInfo(true, groupId)
end

function AdvanceTaskDlg:setCurGroupInfo(isGroup, focusId)
	self.isGroup = isGroup
	self.focusId = focusId

	self.comBannerPanel:setVisible(isGroup)
	self.specBannerPanel:setVisible(not isGroup)

	if isGroup then
		self.comBannerPanel:setAdvanceTaskBanner(focusId)

		local groupClientInfo = AdvanceTaskUtils.getAdvanceGroupClientData(focusId, 1)

		if groupClientInfo then
			local bgImgPath = groupClientInfo.bg_path

			if bgImgPath then
				self.bgImg:setImage(bgImgPath)
			end
		end
	else
		self.specBannerPanel:setSpecTaskBanner(focusId)
		self.bgImg:setImage("NoAlpha/TaskBP/BgTaskBackground1")
	end

	self:refreshCurGroupInfo()
end

function AdvanceTaskDlg:refreshCurGroupInfo()
	for i, mainCell in ipairs(self.mainTaskCells) do
		mainCell:refreshAdvanceMainTaskCell()
	end

	if self.isGroup then
		self.subTaskIdList = CurAvatar:getSortedAdvanceTaskList(self.focusId)

		self.comBannerPanel:refreshAdvanceTaskBanner()
	else
		self.subTaskIdList = CurAvatar:getSortedAdvSpecTaskList(self.focusId)

		self.specBannerPanel:refreshSpecTaskBanner()
	end

	self.subTaskScroll:setTotalCount(#self.subTaskIdList)
end

function AdvanceTaskDlg:_onClickTips(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(145)
end

function AdvanceTaskDlg:_onClickClose(...)
	self:setVisible(false)
end

return AdvanceTaskDlg
