-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\QQ\\QQPrivilegeDlg.lua

local QQPrivilegeAchievePart = require("UI/QQ/QQPrivilegeAchievePart")
local QQPrivilegeBeginnerPart = require("UI/QQ/QQPrivilegeBeginnerPart")
local QQPrivilegeDayPart = require("UI/QQ/QQPrivilegeDayPart")
local QQGameHelper = require("Helper/QQGameHelper")
local PAGE_CONFIG = {
	{
		QQPrivilegeBeginnerPart,
		"System/QQ/QQPrivilegeBeginnerChild",
		UIConst.RD_HINT_QQ_PRIVILEGE_ONCE
	},
	{
		QQPrivilegeAchievePart,
		"System/QQ/QQPrivilegeAchieveChild",
		UIConst.RD_HINT_QQ_PRIVILEGE_ACHIEVE
	},
	{
		QQPrivilegeDayPart,
		"System/QQ/QQPrivilegeDayChild",
		UIConst.RD_HINT_QQ_PRIVILEGE_DAY
	}
}
local strClassName = "QQPrivilegeDlg"
local QQPrivilegeDlg = Class(strClassName, UIControls.Window)

function QQPrivilegeDlg:ctor()
	self:initUI()
end

local MAX_PRIVILEGE_NUM = 3

function QQPrivilegeDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.tabBtns = {}

	for index, pageConfig in ipairs(PAGE_CONFIG) do
		local newBtn = UIControls.Button(self, "BgPanel/TabPanel/Content/TabBtn" .. index)

		newBtn.index = index

		newBtn:addEventClick(self.onTabBtnClick)

		local newRD = UIControls.RedDot(self, "BgPanel/TabPanel/Content/TabBtn" .. index .. "/IconNew")

		newRD:addHint({
			pageConfig[3]
		})
		table.insert(self.tabBtns, newBtn)
	end

	self.pages = {}
	self.btnJoinVip = UIControls.Button(self, "BgPanel/QQVipPanel/BtnJoin")

	self.btnJoinVip:addEventClick(self.onClickJoinVip)

	self.btnJoinVipYear = UIControls.Button(self, "BgPanel/QQVipPanel/BtnJoinYear")

	self.btnJoinVipYear:addEventClick(self.onClickJoinVipYear)

	self.btnOfficialLink = UIControls.Button(self, "BgPanel/QQVipPanel/OfficialLink", "Text")

	self.btnOfficialLink:addEventClick(self.onClickOfficial)
end

function QQPrivilegeDlg:onShow(showIndex)
	if self.tabBtns[showIndex] then
		self:onTabBtnClick(self.tabBtns[showIndex])
	end
end

function QQPrivilegeDlg:onTabBtnClick(sender)
	self.nowIndex = sender.index

	for index, btn in ipairs(self.tabBtns) do
		btn:setEnable(btn ~= sender)
	end

	if not self.pages[self.nowIndex] then
		local config = PAGE_CONFIG[self.nowIndex]

		self.pages[self.nowIndex] = config[1](self, "BgPanel/ChildContent", config[2])
	end

	for index, page in pairs(self.pages) do
		page:setVisible(index == self.nowIndex)
	end

	self.pages[self.nowIndex]:onRefresh()
end

function QQPrivilegeDlg:onDataRefresh()
	self.pages[self.nowIndex]:onRefresh()
end

function QQPrivilegeDlg:onCloseClick()
	self:setVisible(false)
end

function QQPrivilegeDlg:onClickJoinVip()
	QQGameHelper.joinVip()
end

function QQPrivilegeDlg:onClickJoinVipYear()
	QQGameHelper.joinVipYear()
end

function QQPrivilegeDlg:onClickOfficial()
	QQGameHelper.openOfficialWebsite()
end

return QQPrivilegeDlg
