-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Achieve\\AchieveMainDlg.lua

local TaskDayPanel = require("UI/Achieve/TaskDayPanel")
local TaskWeekPanel = require("UI/Achieve/TaskWeekPanel")
local TaskAchievePanel = require("UI/Achieve/TaskAchievePanel")
local strClassName = "AchieveMainDlg"
local AchieveMainDlg = Class(strClassName, UIControls.Window)

AchieveMainDlg.PAGE_ID = {
	Achieve = 3,
	Daily = 1,
	Weekly = 2
}

function AchieveMainDlg:ctor(...)
	self:initUI()
end

function AchieveMainDlg:initUI(...)
	self.closeBtn = UIControls.Button(self, "BtnClose")

	self.closeBtn:addEventClick(self.onClickClose)

	self.tipsBtn = UIControls.Button(self, "BtnTips")

	self.tipsBtn:addEventClick(self.onClickTips)

	self.tabs = {}
	self.tabs[1] = UIControls.Button(self, "MainInfoPanel/TabPanel/BtnDayTask")

	self.tabs[1]:addEventClick(Functor(self.selectPage, self, self.PAGE_ID.Daily))

	self.tabs[2] = UIControls.Button(self, "MainInfoPanel/TabPanel/BtnWeekTask")

	self.tabs[2]:addEventClick(Functor(self.selectPage, self, self.PAGE_ID.Weekly))

	self.tabs[3] = UIControls.Button(self, "MainInfoPanel/TabPanel/BtnMainTask")

	self.tabs[3]:addEventClick(Functor(self.selectPage, self, self.PAGE_ID.Achieve))

	self.dailyRD = UIControls.RedDot(self, "MainInfoPanel/TabPanel/BtnDayTask/IconNew")

	self.dailyRD:addHint({
		UIConst.RD_HINT_DAILY_TASK
	})

	self.weeklyRD = UIControls.RedDot(self, "MainInfoPanel/TabPanel/BtnWeekTask/IconNew")

	self.weeklyRD:addHint({
		UIConst.RD_HINT_WEEKLY_TASK
	})

	self.achieveRD = UIControls.RedDot(self, "MainInfoPanel/TabPanel/BtnMainTask/IconNew")

	self.achieveRD:addHint({
		UIConst.RD_HINT_ACHIEVE_TASK
	})

	self.dayRetunUp = UIControls.Panel(self, "MainInfoPanel/TabPanel/BtnDayTask/ReturnUpPanel")
	self.pageMountPath = "MainInfoPanel"
	self.pageDict = {}
end

function AchieveMainDlg:selectPage(pageId)
	self.currentPage = pageId

	for id, tabBtn in ipairs(self.tabs) do
		tabBtn:setEnable(pageId ~= id)
	end

	local hasPrivilege = CurAvatar:hasPrivilegeType(Const.PRIVITY_KEY_EBONUS_DAILY_TASK)

	self.dayRetunUp:setVisible(hasPrivilege)

	for id, page in pairs(self.pageDict) do
		if id ~= pageId then
			page:setVisible(false)
		end
	end

	local page = self.pageDict[pageId]

	if not page then
		if pageId == self.PAGE_ID.Daily then
			page = TaskDayPanel(self, self.pageMountPath, "System/Task/TaskDayPanel", 0, 0, true)
		elseif pageId == self.PAGE_ID.Weekly then
			page = TaskWeekPanel(self, self.pageMountPath, "System/Task/TaskWeekPanel", 0, 0, true)
		elseif pageId == self.PAGE_ID.Achieve then
			page = TaskAchievePanel(self, self.pageMountPath, "System/Task/TaskMainPanel", 0, 0, true)
		end

		self.pageDict[pageId] = page
	end

	page:setVisible(true)
	page:setTaskPanel()
	page:refreshTeskPanel()
end

function AchieveMainDlg:selectAchievePanel()
	self:selectPage(3)
	self.pageDict[3]:_onClickViewAward()
end

function AchieveMainDlg:onOpen(...)
	AchieveMainDlg.super.onOpen(self)
	self:selectPage(self:_selectFirstRedPage())
end

function AchieveMainDlg:refreshTasks(forceResetData)
	if self.currentPage ~= self.PAGE_ID.Achieve then
		local page = self.pageDict[self.currentPage]

		if page then
			if forceResetData then
				page:setTaskPanel()
			end

			page:refreshTeskPanel()
		end
	end
end

function AchieveMainDlg:refreshAchieves(...)
	if self.currentPage == self.PAGE_ID.Achieve then
		local page = self.pageDict[self.currentPage]

		if page then
			page:refreshTeskPanel()
		end
	end
end

function AchieveMainDlg:getCurPage()
	if self.currentPage and self.pageDict then
		return self.pageDict[self.currentPage]
	end
end

function AchieveMainDlg:curPageIsAchieve()
	return self.currentPage == self.PAGE_ID.Achieve
end

function AchieveMainDlg:_selectFirstRedPage()
	local selectPageId = self.PAGE_ID.Daily

	if self.dailyRD:getHintState() then
		-- block empty
	elseif self.weeklyRD:getHintState() then
		selectPageId = self.PAGE_ID.Weekly
	elseif self.achieveRD:getHintState() then
		selectPageId = self.PAGE_ID.Achieve
	end

	return selectPageId
end

function AchieveMainDlg:onClickClose(...)
	self:setVisible(false)
end

function AchieveMainDlg:onClickTips(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_TASK)
end

return AchieveMainDlg
