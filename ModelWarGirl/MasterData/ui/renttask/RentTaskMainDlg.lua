-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RentTask\\RentTaskMainDlg.lua

local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local DragTwoPages = require("UI/Control/DragTwoPages")
local RentGroupTaskInfoPage = require("UI/RentTask/RentGroupTaskInfoPage")
local strClassName = "RentTaskMainDlg"
local RentTaskMainDlg = Class(strClassName, UIControls.Window)

function RentTaskMainDlg:ctor(...)
	self:initUI()
end

function RentTaskMainDlg:initUI(...)
	self.closeBtn = UIControls.Button(self, "BtnClose", "Text")

	self.closeBtn:addEventClick(self._onClickClose)

	self.tipsBtn = UIControls.Button(self, "BtnTips")

	self.tipsBtn:addEventClick(self._onClickTips)

	self.dragPages = DragTwoPages(self, "MainInfoPanel/ContentPanel1", "MainInfoPanel/ContentPanel2", "MainInfoPanel/PreNextPanel/BtnPre", "MainInfoPanel/PreNextPanel/BtnNext", nil, "MainInfoPanel/PagePanel/Page")
	self.dragPages.dragEvent = Slot(self.onDragEvent, self)

	local page1 = RentGroupTaskInfoPage(self, "MainInfoPanel/ContentPanel1", "System/CaseTask/ChildCasePanel")

	page1:setVisible(true)

	local page2 = RentGroupTaskInfoPage(self, "MainInfoPanel/ContentPanel2", "System/CaseTask/ChildCasePanel")

	page2:setVisible(true)

	self.pages = {
		page1,
		page2
	}
	self.friendScoreTxt = UIControls.Label(self, "MainInfoPanel/FriendGiftPanel/TextNum")
	self.friendTipsBtn = UIControls.Button(self, "MainInfoPanel/FriendGiftPanel/BtnTips")

	self.friendTipsBtn:addEventClick(self._onClickFriendTips)

	self.recordBtn = UIControls.Button(self, "MainInfoPanel/BtnRecord")

	self.recordBtn:addEventClick(self._onClickRecord)

	self.recordRD = UIControls.RedDot(self, "MainInfoPanel/BtnRecord/IconNew")

	self.recordRD:addHint({
		UIConst.RD_HINT_RENT_NEWSENDLETTER
	})

	self.setupTeamBtn = UIControls.Button(self, "MainInfoPanel/BtnSeTupTeams")

	self.setupTeamBtn:addEventClick(self._onClickSetup)

	self.setupRD = UIControls.RedDot(self, "MainInfoPanel/BtnSeTupTeams/IconNew")

	self.setupRD:addHint({
		UIConst.RD_HINT_RENT_FORAMTIONLACK
	})

	self.newsBtn = UIControls.Button(self, "MainInfoPanel/BtnNews")

	self.newsBtn:addEventClick(self._onClickNews)

	self.newsRD = UIControls.RedDot(self, "MainInfoPanel/BtnNews/IconNew")

	self.newsRD:addHint({
		UIConst.RD_HINT_RENT_MESSAGE
	})

	self.selectConfirmBtn = UIControls.Button(self, "MainInfoPanel/BtnConfirm")

	self.selectConfirmBtn:addEventClick(self._onClickConfirmSelect)

	self.selectCancelBtn = UIControls.Button(self, "MainInfoPanel/BtnDeny")

	self.selectCancelBtn:addEventClick(self._onClickCancelSelect)

	self.rootAni = UIControls.UIAni(self, "")
	self.preRD = UIControls.RedDot(self, "MainInfoPanel/PreNextPanel/BtnPre/IconNew")
	self.nextRD = UIControls.RedDot(self, "MainInfoPanel/PreNextPanel/BtnNext/IconNew")
	self.upPanel = UIControls.Panel(self, "MainInfoPanel/UpPanel")
	self.upCountDownTxt = UIControls.Label(self, "MainInfoPanel/UpPanel/TextNum")
	self.upBtn = UIControls.Button(self, "MainInfoPanel/UpPanel/BtnTips")

	self.upBtn:addEventClick(self._onClickUpTips)
end

function RentTaskMainDlg:refreshRentTasks(defaultGtid, forceInit)
	local maxFriendScore = RentTaskUtils.getGiftWeekLimit()
	local curFriendScore = math.min(CurAvatar.rentGiftNum, maxFriendScore)

	self.friendScoreTxt:setText(curFriendScore .. "/" .. maxFriendScore)
	self:refreshUpPanel()

	local oriRentData = RentTaskUtils.getGroupTaskSvrData()

	if not oriRentData or #oriRentData == 0 then
		return
	end

	local newRentTaskData = {}

	for _, groupInfo in pairs(oriRentData) do
		if groupInfo.taskStatus ~= Const.RENT_GROUPTASK_STATUS.OverDue then
			table.insert(newRentTaskData, groupInfo)
		end
	end

	table.sort(newRentTaskData, self._sortGroupTask)

	if not self.rentTaskData or forceInit then
		if not defaultGtid and self.curDataIdx and self.rentTaskData and self.rentTaskData[self.curDataIdx] then
			defaultGtid = self.rentTaskData[self.curDataIdx].groupTaskId
		end

		self.rentTaskData = newRentTaskData

		local maxPageIndex = math.min(4, #self.rentTaskData)

		if defaultGtid then
			for i, v in ipairs(self.rentTaskData) do
				if v.groupTaskId == defaultGtid then
					self.curDataIdx = i
				end
			end
		end

		if not self.curDataIdx then
			self.curDataIdx = 1

			for i, v in ipairs(self.rentTaskData) do
				if RentTaskUtils.isGroupTaskValid(v.groupTaskId) then
					self.curDataIdx = i

					break
				end
			end
		else
			self.curDataIdx = math.min(self.curDataIdx, maxPageIndex)
		end

		self.dragPages:initPage(maxPageIndex, self.curDataIdx, 4)
	else
		self.dragPages:onDragEvent(false)
	end
end

function RentTaskMainDlg:onDragEvent(sender, dataIndex, pageIndex, isOnOpen)
	self.curDataIdx = dataIndex
	self.curPageIdx = pageIndex

	for i, page in ipairs(self.pages) do
		if i == pageIndex then
			page:setRentGroupTaskInfo(self.rentTaskData[self.curDataIdx], isOnOpen)
		else
			page:onPageClose()
		end
	end

	self:_refrshPreNextRD(self.curDataIdx)
end

function RentTaskMainDlg._sortGroupTask(a, b)
	return a.overdueTick < b.overdueTick
end

function RentTaskMainDlg:onClose(...)
	for _, page in ipairs(self.pages) do
		page:onPageClose()
	end

	self:_stopUpTimer()
	RentTaskMainDlg.super.onClose(self)
end

function RentTaskMainDlg:onOpen(...)
	RentTaskMainDlg.super.onOpen(self)
	CurAvatar:checkRentUpWeek()
end

function RentTaskMainDlg:manualRefreshTask(...)
	RentTaskUtils.refreshRentTask()
end

function RentTaskMainDlg:_refrshPreNextRD(curDataIdx)
	local preHasNew = false
	local nextHasNew = false

	for i, taskData in ipairs(self.rentTaskData) do
		if i ~= curDataIdx then
			local gtid = taskData.groupTaskId
			local hasNew = RentTaskUtils.gtidHasNew(gtid)

			if i < curDataIdx then
				preHasNew = preHasNew or hasNew
			elseif curDataIdx < i then
				nextHasNew = nextHasNew or hasNew
			end
		end
	end

	self.preRD:setVisible(preHasNew)
	self.nextRD:setVisible(nextHasNew)
end

function RentTaskMainDlg:refreshUpPanel()
	local isUp, upEndTick = CurAvatar:calcRentUpWeek()

	self.upPanel:setVisible(isUp)

	if isUp then
		self.upEndTick = upEndTick

		self:_startUpTimer()
	else
		self:_stopUpTimer()
	end
end

function RentTaskMainDlg:_stopUpTimer(...)
	ClientTimerManager.RemoveSecondTickUI(self.upCountDownTxt)
end

function RentTaskMainDlg:_startUpTimer(...)
	if not self.upEndTick then
		return
	end

	local leftSecond = self.upEndTick - ClientUtils.getServerTime()
	local slotOfTimerBeat = Slot(self.refreshUpPanel, self)

	ClientTimerManager.AddSecondFormatTickUI(self.upCountDownTxt, leftSecond, false, Lang.get(48654), slotOfTimerBeat)
end

function RentTaskMainDlg:_onClickConfirmSelect()
	self.pages[self.curPageIdx]:confirmSelection()
end

function RentTaskMainDlg:_onClickCancelSelect()
	self.pages[self.curPageIdx]:outSelectState()
end

function RentTaskMainDlg:_onClickSetup(...)
	local setupDlg = UIManager.getUI("rentTeamSetupDlg", true)
end

function RentTaskMainDlg:_onClickRecord(...)
	UIManager.getUI("rentSendLetterListDlg", true):onPanelOpen()
end

function RentTaskMainDlg:_onClickNews(...)
	UIManager.getUI("rentTaskReceiveLetterDlg", true):_onClickTabReceive()
end

function RentTaskMainDlg:_onClickClose(...)
	self:setVisible(false)
end

function RentTaskMainDlg:_onClickTips(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_RENT_TASK)
end

function RentTaskMainDlg:_onClickFriendTips(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_RENT_GIFT)
end

function RentTaskMainDlg:_onClickUpTips(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_RENT_UP)
end

return RentTaskMainDlg
