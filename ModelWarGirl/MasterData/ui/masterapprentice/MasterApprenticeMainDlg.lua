-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MasterApprentice\\MasterApprenticeMainDlg.lua

local RankSelectPanel = require("UI.MasterApprentice.RankSelectPanel")
local MasterTaskPanel = require("UI.MasterApprentice.MasterTaskPanel")
local ApprenticeTaskPanel = require("UI.MasterApprentice.ApprenticeTaskPanel")
local MasterApprenticeFindPanel = require("UI.MasterApprentice.MasterApprenticeFindPanel")
local ApprenticePanel = require("UI.MasterApprentice.ApprenticePanel")
local MasterPanel = require("UI.MasterApprentice.MasterPanel")
local Tab = Class("MasterApprenticeMainDlg_Tab", UIControls.Panel)

function Tab:ctor()
	self.btn = UIControls.Button(self, self.mPath)

	self.btn:addEventClick(self.onClickBtn)

	self.redDot = UIControls.RedDot(self, self.mPath .. "/IconNew")
end

function Tab:init(tabType, hintList)
	self.tabType = tabType

	if hintList then
		self.redDot:addHint(hintList)
	end
end

function Tab:setSelect(value)
	self.btn:setEnable(not value)
end

function Tab:onClickBtn()
	self.mParent:onSelectTab(self)
end

local MasterApprenticeMainDlg = Class("MasterApprenticeMainDlg", UIControls.Window)

MasterApprenticeMainDlg.TabType = {
	FindApprentice = 6,
	Master = 3,
	MasterTask = 1,
	FindMaster = 5,
	ApprenticeTask = 2,
	Apprentice = 4,
	RankSelect = 7
}

function MasterApprenticeMainDlg:ctor()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.tabTask = Tab(self, "MainInfoPanel/TabPanel/Content/BtnTask")
	self.tabApprentice = Tab(self, "MainInfoPanel/TabPanel/Content/BtnTeacherManage")

	self.tabApprentice:init(MasterApprenticeMainDlg.TabType.Apprentice, {
		UIConst.RD_HINT_APPRENTICE_DEVELOP_GUIDE,
		UIConst.RD_HINT_APPRENTICE_BATTLE_GUIDE
	})

	self.tabMaster = Tab(self, "MainInfoPanel/TabPanel/Content/BtnStudentManage")

	self.tabMaster:init(MasterApprenticeMainDlg.TabType.Master, {
		UIConst.RD_HINT_APPRENTICE_BATTLE_GUIDE
	})

	self.tabFindMaster = Tab(self, "MainInfoPanel/TabPanel/Content/BtnStudentFind")

	self.tabFindMaster:init(MasterApprenticeMainDlg.TabType.FindMaster, {
		UIConst.RD_HINT_MASTER_APPRENTICE_INVITE
	})

	self.tabFindApprentice = Tab(self, "MainInfoPanel/TabPanel/Content/BtnTeacherFind")

	self.tabFindApprentice:init(MasterApprenticeMainDlg.TabType.FindApprentice, {
		UIConst.RD_HINT_MASTER_APPRENTICE_INVITE
	})

	self.tabRankSelect = Tab(self, "MainInfoPanel/TabPanel/Content/BtnRankSelect")

	self.tabRankSelect:init(MasterApprenticeMainDlg.TabType.RankSelect, {
		UIConst.RD_HINT_HANDBOOK_MONUMENT
	})

	self.tabList = {
		self.tabTask,
		self.tabMaster,
		self.tabApprentice,
		self.tabFindMaster,
		self.tabFindApprentice,
		self.tabRankSelect
	}
	self.btnGuide = UIControls.Button(self, "MainInfoPanel/BtnGuide")

	self.btnGuide:addEventClick(self.onClickBtnGuide)

	self.redDotGuide = UIControls.RedDot(self, "MainInfoPanel/BtnGuide/IconNew")

	self.redDotGuide:addHint({
		UIConst.RD_HINT_APPRENTICE_DEVELOP_GUIDE
	})

	self.panelDic = {}
end

function MasterApprenticeMainDlg:onDestroy()
	MasterApprenticeMainDlg.super.onDestroy(self)

	for _, panel in pairs(self.panelDic) do
		if panel.onDestroy then
			panel:onDestroy()
		end
	end
end

function MasterApprenticeMainDlg:onOpen()
	MasterApprenticeMainDlg.super.onOpen(self)
	self:refreshTabs(true)
end

function MasterApprenticeMainDlg:refreshTabs(isOpen)
	local checkHaveMaster = CurAvatar:checkHaveMaster()
	local checkShowAddMaster = CurAvatar:checkCanAddMaster()
	local checkShowAddApprentice = not checkHaveMaster and not CurAvatar:checkAddMasterCondition()
	local checkHistoryHaveApprentice = CurAvatar:checkHistoryHaveApprentice()

	if checkHaveMaster then
		self.tabTask:init(MasterApprenticeMainDlg.TabType.ApprenticeTask, {
			UIConst.RD_HINT_MASTER_APPRENTICE_TASK,
			UIConst.RD_HINT_APPRENTICE_GRADUATE
		})
	else
		self.tabTask:init(MasterApprenticeMainDlg.TabType.MasterTask, {
			UIConst.RD_HINT_MASTER_APPRENTICE_TASK,
			UIConst.RD_HINT_MASTER_LV_AWARD
		})
	end

	self.tabTask:setVisible(checkHaveMaster or checkHistoryHaveApprentice)
	self.tabMaster:setVisible(checkHaveMaster)
	self.tabApprentice:setVisible(checkHistoryHaveApprentice)
	self.tabFindMaster:setVisible(checkShowAddMaster)
	self.tabFindApprentice:setVisible(checkShowAddApprentice)
	self.btnGuide:setVisible(checkHaveMaster)
	self:duelHidePanel(MasterApprenticeMainDlg.TabType.MasterTask, checkHistoryHaveApprentice)
	self:duelHidePanel(MasterApprenticeMainDlg.TabType.ApprenticeTask, checkHaveMaster)
	self:duelHidePanel(MasterApprenticeMainDlg.TabType.Master, checkHaveMaster)
	self:duelHidePanel(MasterApprenticeMainDlg.TabType.Apprentice, checkHistoryHaveApprentice)
	self:duelHidePanel(MasterApprenticeMainDlg.TabType.FindMaster, checkShowAddMaster)
	self:duelHidePanel(MasterApprenticeMainDlg.TabType.FindApprentice, checkShowAddApprentice)

	if isOpen or not self.tab or not self.tab:getVisible() then
		self:defaultSelectTab()
	end
end

function MasterApprenticeMainDlg:defaultSelectTab()
	for _, tab in ipairs(self.tabList) do
		if tab:getVisible() then
			self:onSelectTab(tab)

			break
		end
	end
end

function MasterApprenticeMainDlg:onSelectTab(tab)
	if self.tab then
		self.tab:setSelect(false)

		if self.panel then
			self.panel:setVisible(false)
		end
	end

	self.tab = tab
	self.tabType = self.tab.tabType

	self.tab:setSelect(true)
	self:refreshPanel()
end

function MasterApprenticeMainDlg:refreshPanel()
	local panel = self.panelDic[self.tabType]

	if not panel then
		if self.tabType == MasterApprenticeMainDlg.TabType.MasterTask then
			panel = MasterTaskPanel(self, "MainInfoPanel/BgPanel", "System/HandBook/RankSelectTeacherTaskPanel")
		elseif self.tabType == MasterApprenticeMainDlg.TabType.ApprenticeTask then
			panel = ApprenticeTaskPanel(self, "MainInfoPanel/BgPanel", "System/HandBook/RankSelectStudentTaskPanel")
		elseif self.tabType == MasterApprenticeMainDlg.TabType.Apprentice then
			panel = ApprenticePanel(self, "MainInfoPanel/BgPanel", "System/HandBook/RankSelectTeacherManagePanel")
		elseif self.tabType == MasterApprenticeMainDlg.TabType.Master then
			panel = MasterPanel(self, "MainInfoPanel/BgPanel", "System/HandBook/RankSelectStudentManagePanel")
		elseif self.tabType == MasterApprenticeMainDlg.TabType.FindMaster then
			panel = MasterApprenticeFindPanel(self, "MainInfoPanel/BgPanel", "System/HandBook/RankSelectStudentFindPanel")

			panel:initData(Const.MASTER_APPRENTICE_TYPE.Master)
		elseif self.tabType == MasterApprenticeMainDlg.TabType.FindApprentice then
			panel = MasterApprenticeFindPanel(self, "MainInfoPanel/BgPanel", "System/HandBook/RankSelectTeacherFindPanel")

			panel:initData(Const.MASTER_APPRENTICE_TYPE.Apprentice)
		elseif self.tabType == MasterApprenticeMainDlg.TabType.RankSelect then
			panel = RankSelectPanel(self, "MainInfoPanel/BgPanel", "System/HandBook/RankSelectPanel")
		end
	end

	if panel then
		self.panelDic[self.tabType] = panel
		self.panel = panel

		self.panel:setVisible(true)

		if self.panel.onShow then
			self.panel:onShow()
		end
	end
end

function MasterApprenticeMainDlg:duelHidePanel(tabType, show)
	if show then
		return
	end

	local panel = self.panelDic[tabType]

	if panel then
		panel:setVisible(false)
	end
end

function MasterApprenticeMainDlg:onClickBtnGuide()
	local ui = UIManager.getUI("masterApprenticeGuideDlg", true)

	if ui then
		ui:setData(Const.MASTER_APPRENTICE_TYPE.Apprentice)
	end
end

function MasterApprenticeMainDlg:onClickBtnClose()
	self:setVisible(false)
end

function MasterApprenticeMainDlg:onMasterApprenticeEnrollResp(target_type)
	if self.panel.onMasterApprenticeEnrollResp then
		self.panel:onMasterApprenticeEnrollResp()
	end
end

function MasterApprenticeMainDlg:onMasterApprenticeInviteOpResp(targetType)
	self:refreshTabs()
end

function MasterApprenticeMainDlg:onMasterApprenticeAddNotify(target_type)
	self:refreshTabs()
end

function MasterApprenticeMainDlg:onMasterApprenticeDelNotify(target_type)
	self:refreshTabs()
end

function MasterApprenticeMainDlg:onMasterApprenticeGraduationResp()
	self:refreshTabs()
end

function MasterApprenticeMainDlg:onMasterApprenticeRecommendResp(target_type)
	if self.panel.onMasterApprenticeRecommendResp then
		self.panel:onMasterApprenticeRecommendResp(target_type)
	end
end

function MasterApprenticeMainDlg:onMasterApprenticeGetTaskAwardResp(taskType)
	if self.panel.onMasterApprenticeGetTaskAwardResp then
		self.panel:onMasterApprenticeGetTaskAwardResp(taskType)
	end
end

function MasterApprenticeMainDlg:onMasterExperienceNotify()
	if self.panel.onMasterExperienceNotify then
		self.panel:onMasterExperienceNotify()
	end
end

function MasterApprenticeMainDlg:setPlayerInfo(rank)
	if self.panelDic[MasterApprenticeMainDlg.TabType.RankSelect] then
		self.panelDic[MasterApprenticeMainDlg.TabType.RankSelect]:setPlayerInfo(rank)
	end
end

function MasterApprenticeMainDlg:refreshOnePlayer(rank, rankType)
	if self.panelDic[MasterApprenticeMainDlg.TabType.RankSelect] then
		self.panelDic[MasterApprenticeMainDlg.TabType.RankSelect]:refreshOnePlayer(rank, rankType)
	end
end

function MasterApprenticeMainDlg:refreshForAward()
	if self.panelDic[MasterApprenticeMainDlg.TabType.RankSelect] then
		self.panelDic[MasterApprenticeMainDlg.TabType.RankSelect]:refreshForAward()
	end
end

return MasterApprenticeMainDlg
