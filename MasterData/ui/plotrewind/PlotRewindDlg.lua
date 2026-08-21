-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PlotRewind\\PlotRewindDlg.lua

local strClassName = "PlotRewindDlg"
local CommonFuncEntryPanel = require("UI/MainMenu/CommonFuncEntryPanel")
local PlotRewindDlg = Class(strClassName, UIControls.Window)
local PlotRewindUtils = require("UI/PlotRewind/PlotRewindUtils")
local UserData = require("Helper/UserData")

function PlotRewindDlg:ctor()
	self:initUI()
end

function PlotRewindDlg:initUI()
	self.panelFund = CommonFuncEntryPanel(self, "CommonFuncEntryPanel", "System/MainMenu/CommonFuncEntryPanel", 0, 0, true)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnClose)

	self.mainLineStoryBtn = UIControls.Button(self, "MainInfoPanel/MainLineStoryBtn")

	self.mainLineStoryBtn:addEventClick(self.onBtnMainLine)

	self.sideLineStoryBtn = UIControls.Button(self, "MainInfoPanel/SideLineStoryBtn")

	self.sideLineStoryBtn:addEventClick(self.onBtnSideLine)

	self.sideLineIconNew = UIControls.Image(self, "MainInfoPanel/SideLineStoryBtn/IconNew")

	self:checkSideLineExist()
	self:checkNew()
	UserData.saveCommonData(CurAvatar.uid .. PlotRewindUtils.HasClickedString, "1")

	self.isInited = true
end

function PlotRewindDlg:onVisibleChanged(isSee)
	if isSee and self.isInited then
		self:checkNew()
	end
end

function PlotRewindDlg:checkNew()
	local hasNew = PlotRewindUtils.CheckNewAllSiderLine()

	self.sideLineIconNew:setVisible(hasNew)
end

function PlotRewindDlg:checkSideLineExist()
	local sideLineChapter = PlotRewindUtils.getAllMainChapter(UIConst.PLOT_REWIND_SIDE_LINE)
	local hasUnlockedSideLine = false

	for index, data in ipairs(sideLineChapter) do
		local unlocked = PlotRewindUtils.CheckTimeUnlocked(data)

		if unlocked then
			hasUnlockedSideLine = true
		end
	end

	self.sideLineStoryBtn:setVisible(hasUnlockedSideLine)
end

function PlotRewindDlg:onBtnClose()
	self:setVisible(false)
end

function PlotRewindDlg:onBtnMainLine()
	local ui = UIManager.getUI("plotRewindMainLineDlg", true)

	ui:setData(UIConst.PLOT_REWIND_MAIN_LINE)
end

function PlotRewindDlg:onBtnSideLine()
	local ui = UIManager.getUI("plotRewindSideLineDlg", true)

	ui:setData(UIConst.PLOT_REWIND_SIDE_LINE)
end

return PlotRewindDlg
