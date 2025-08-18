-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RentTask\\RentTeamBorrowDlg.lua

local RentTeamChoosePanel = require("UI/RentTask/RentTeamChoosePanel")
local RentTeamNewsPanel = require("UI/RentTask/RentTeamNewsPanel")
local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local strClassName = "RentTeamBorrowDlg"
local RentTeamBorrowDlg = Class(strClassName, UIControls.Window)

function RentTeamBorrowDlg:ctor(...)
	self:initUI()
end

function RentTeamBorrowDlg:initUI(...)
	self.closeBtn = UIControls.Button(self, "Bg/BtnClose")

	self.closeBtn:addEventClick(self._onClickClose)

	self.chooseBtn = UIControls.Button(self, "Bg/TabPanel/BtnTabChoose")

	self.chooseBtn:addEventClick(self._onClickChooseTab)

	self.chooseNewImg = UIControls.Image(self, "Bg/TabPanel/BtnTabChoose/IconNew")
	self.newsBtn = UIControls.Button(self, "Bg/TabPanel/BtnTabNews")

	self.newsBtn:addEventClick(self._onClickNewsTab)

	self.newsNewImg = UIControls.Image(self, "Bg/TabPanel/BtnTabNews/IconNew")
	self.bossRole = UIControls.Role(self, "Bg/BossPanel/GridHeroPortraitPanel/HeroPanel", 0, 0)
	self.bossRoleShadow = UIControls.Role(self, "Bg/BossPanel/GridHeroPortraitPanelShadow/HeroPanel", 0, 0)
	self.bossTitleTxt = UIControls.Label(self, "Bg/BossPanel/TextTitle")
	self.bossPowerTxt = UIControls.Label(self, "Bg/BossPanel/TextPower")
	self.choosePanel = RentTeamChoosePanel(self, "Bg/ChoosePanel")
	self.newsPanel = RentTeamNewsPanel(self, "Bg/NewsPanel")
	self.requestNumTxt = UIControls.Label(self, "Bg/TextRequestNum")
end

function RentTeamBorrowDlg:setTeamBorrowInfo(groupTaskId, taskId)
	self.groupTaskId = groupTaskId
	self.taskId = taskId

	local taskTitle = RentTaskUtils.getTaskTitle(taskId)

	self.bossTitleTxt:setText(taskTitle or "")

	local taskInfo = RentTaskUtils.getTaskData(taskId)

	if not taskInfo then
		return
	end

	local portList = taskInfo.port_list

	if #portList == 2 then
		self.bossRole:showRole(portList[2], UIConst.ROLEIMAGE_SHOWTYPE_RENT_TASK)
		self.bossRoleShadow:showRole(portList[2], UIConst.ROLEIMAGE_SHOWTYPE_RENT_TASK)
	end

	local pveIdList = taskInfo.pve

	self.pveId = pveIdList[2].pveid

	local svrMaxStage = RentTaskUtils.getGroupTaskMaxStage(groupTaskId)
	local stageConfig = utils.getRentStageData(taskId, true, ClientUtils.getMainStageLevelNum(), svrMaxStage)

	self.bossPowerTxt:setText(stageConfig.show_level)
	self.choosePanel:setTeamChooseInfo(groupTaskId)
	self.newsPanel:setTeamNewsInfo(groupTaskId, self.taskId, self.pveId)
	self:refreshNowNum()
end

function RentTeamBorrowDlg:selectChoosePanel(...)
	self:_onClickChooseTab()
end

function RentTeamBorrowDlg:selectNewsPanel(...)
	self:_onClickNewsTab()
end

function RentTeamBorrowDlg:initMatchTeams(...)
	if self.curPanel ~= self.choosePanel then
		return
	end

	self.curPanel:initMatchList()
end

function RentTeamBorrowDlg:refreshTeamBorrowInfo(...)
	self:refreshChoosePanel()
	self:refreshNewsPanel()
	self:refreshNowNum()
end

function RentTeamBorrowDlg:refreshChoosePanel()
	if self.curPanel ~= self.choosePanel then
		return
	end

	self.choosePanel:refreshTeamChoosePanel()
end

function RentTeamBorrowDlg:refreshNewsPanel(...)
	if self.curPanel ~= self.newsPanel then
		return
	end

	self.newsPanel:refreshTeamNewsPanel()
end

function RentTeamBorrowDlg:refreshNowNum(...)
	local reqCount = RentTaskUtils.getRequestCount(self.groupTaskId)
	local maxCount = RentTaskUtils.maxRequestPerTask()

	self.requestNumTxt:setText(reqCount .. "/" .. maxCount)
	self.chooseNewImg:setVisible(CurAvatar:checkRentGroupTaskUnBorrowRD(self.groupTaskId))
	self.newsNewImg:setVisible(CurAvatar:checkRentGroupTaskBorrowSucRD(self.groupTaskId))
end

function RentTeamBorrowDlg:_onClickChooseTab(...)
	self.choosePanel:setVisible(true)
	self.chooseBtn:setEnable(false)
	self.newsPanel:setVisible(false)
	self.newsBtn:setEnable(true)

	self.curPanel = self.choosePanel

	self.curPanel:onPanelOpen()
end

function RentTeamBorrowDlg:_onClickNewsTab(...)
	coroutine.start(self._corOpenNewsPanel, self)
end

function RentTeamBorrowDlg:_corOpenNewsPanel()
	self.choosePanel:onPanelClose()
	self.choosePanel:setVisible(false)
	self.chooseBtn:setEnable(true)
	self.newsPanel:setVisible(true)
	self.newsBtn:setEnable(false)

	self.curPanel = self.newsPanel

	self.curPanel:onPanelOpen()
end

function RentTeamBorrowDlg:_onClickClose(...)
	self:setVisible(false)
end

function RentTeamBorrowDlg:onClose(...)
	self.choosePanel:clear()
	self.newsPanel:clear()
	RentTeamBorrowDlg.super.onClose(self)
end

return RentTeamBorrowDlg
