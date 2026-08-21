-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookRankSelectDlg.lua

local HandBookRankSelectMixin = require("UI.HandBook.HandBookRankSelectMixin")
local HandBookRankSelectDlg = Class("HandBookRankSelectDlg", UIControls.Window)

MixinClass(HandBookRankSelectDlg, HandBookRankSelectMixin)

function HandBookRankSelectDlg:ctor()
	self:initUI()

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)
end

function HandBookRankSelectDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_HANDBOOK_RANK)
end

function HandBookRankSelectDlg:onBtnCloseClick()
	self:setVisible(false)
end

return HandBookRankSelectDlg
