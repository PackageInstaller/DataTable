-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Achieve\\NewbieTaskDlg.lua

local NewbieTaskPage = require("UI/Achieve/NewbieTaskPage")
local NewbieLoginPage = require("UI/Achieve/NewbieLoginPage")
local strClassName = "NewbieTaskDlg"
local NewbieTaskDlg = Class(strClassName, UIControls.Window)

function NewbieTaskDlg:ctor(...)
	self:initUI()
end

local LOGIN_PAGE = 1
local NEWBIE_PAGE = 2

function NewbieTaskDlg:initUI(...)
	self.closeBtn = UIControls.Button(self, "BtnClose")

	self.closeBtn:addEventClick(self.onClickClose)

	self.tipsBtn = UIControls.Button(self, "BtnTips")

	self.tipsBtn:addEventClick(self.onClickTips)

	self.pages = {}
end

function NewbieTaskDlg:onOpen()
	NewbieTaskDlg.super.onOpen(self)
	self:selectNewbieTaskPage()
end

function NewbieTaskDlg:_selectOpenPage()
	return
end

function NewbieTaskDlg:selectNewbieTaskPage(...)
	if not self.pages[NEWBIE_PAGE] then
		self.pages[NEWBIE_PAGE] = NewbieTaskPage(self, "MainInfoPanel/TaskList", "System/Task/BeginnerTaskPanel")
	end

	for pageId, page in pairs(self.pages) do
		page:setVisible(pageId == NEWBIE_PAGE)
	end

	self.pages[NEWBIE_PAGE]:onPageOpen()

	self.curPage = NEWBIE_PAGE
end

function NewbieTaskDlg:setNewbieTaskData()
	if self.curPage ~= NEWBIE_PAGE then
		return
	end

	self.pages[NEWBIE_PAGE]:setNewbieTaskData()
end

function NewbieTaskDlg:refreshNewbieTask(...)
	if self.curPage ~= NEWBIE_PAGE then
		return
	end

	self.pages[NEWBIE_PAGE]:refreshNewbieTask()
end

function NewbieTaskDlg:refreshLoginAchieve(...)
	if self.curPage ~= LOGIN_PAGE then
		return
	end

	self.pages[LOGIN_PAGE]:refreshLoginAchieve()
end

function NewbieTaskDlg:onClickClose(...)
	self:setVisible(false)
end

function NewbieTaskDlg:onClickTips(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_TASK)
end

return NewbieTaskDlg
