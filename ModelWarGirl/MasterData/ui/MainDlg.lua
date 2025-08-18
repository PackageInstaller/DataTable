-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainDlg.lua

local UIControls = require("UI/UIControls")
local MainCell = Class("MainCell", UIControls.ScrollViewLoopCell)

function MainCell:ctor()
	self.box = UIControls.Button(self, "")

	self.box:addEventClick(self.onBoxClick)
end

function MainCell:onBoxClick(sender)
	return
end

local strClassName = "MainDlg"
local MainDlg = Class(strClassName, UIControls.Window)

function MainDlg:ctor()
	self.btnl = UIControls.Button(self, "ButtonL")

	self.btnl:addEventClick(self.onBackClick)

	self.btnr = UIControls.Button(self, "ButtonR")

	self.btnr:addEventClick(self.onNextClick)

	self.btn3 = UIControls.Button(self, "Button3")

	self.btn3:addEventClick(self.onTestClick)

	self.cells = {}
	self.scroll = UIControls.ScrollViewLoopV(self, "Bg/LoopVScrollRect")

	self.scroll:addEventCellChanged(self.onCellChanged)
end

function MainDlg:onOpen()
	MainDlg.super.onOpen(self)
end

function MainDlg:onBackClick(sender)
	GameFsm.translateState(Const.STATE_LOGIN)
end

function MainDlg:onNextClick(sender)
	GameFsm.translateState(Const.STATE_BATTLE)
end

function MainDlg:onTestClick(sender)
	UIManager.getUI("talkBox", true)
end

function MainDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = MainCell(sender, "MainCell", newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell
end

return MainDlg
