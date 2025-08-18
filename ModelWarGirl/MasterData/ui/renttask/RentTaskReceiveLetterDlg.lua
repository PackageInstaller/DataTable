-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RentTask\\RentTaskReceiveLetterDlg.lua

local RentOwnerMsgPanel = require("UI/RentTask/RentOwnerMsgPanel")
local RentLetterListDlg = require("UI/RentTask/RentLetterListPanel")
local strClassName = "RentTaskReceiveLetterDlg"
local RentTaskReceiveLetterDlg = Class(strClassName, UIControls.Window)

function RentTaskReceiveLetterDlg:ctor()
	self:initUI()
end

function RentTaskReceiveLetterDlg:initUI()
	self.btnClose = UIControls.Button(self, "Bg/BtnClose")

	self.btnClose:addEventClick(self._onClickClose)

	self.btnTabReceive = UIControls.Button(self, "Bg/TabPanel/BtnTabReceive")

	self.btnTabReceive:addEventClick(self._onClickTabReceive)

	self.btnTabLetter = UIControls.Button(self, "Bg/TabPanel/BtnTabLetter")

	self.btnTabLetter:addEventClick(self._onClickTabLetter)

	self.receivePanel = RentOwnerMsgPanel(self, "Bg/ReceivePanel")
	self.letterPanel = RentLetterListDlg(self, "Bg/LetterPanel")
	self.redLetter = UIControls.RedDot(self, "Bg/TabPanel/BtnTabLetter/IconNew")

	self.redLetter:addHint({
		UIConst.RD_HINT_RENT_NEWLETTER
	})
end

function RentTaskReceiveLetterDlg:onOpen()
	RentTaskReceiveLetterDlg.super.onOpen(self)
end

function RentTaskReceiveLetterDlg:selectOwnerMsgPanel(...)
	self.curPanel = self.receivePanel

	self.receivePanel:setVisible(true)
	self.letterPanel:setVisible(false)
	self.btnTabReceive:setEnable(false)
	self.btnTabLetter:setEnable(true)
	self.receivePanel:onPanelOpen()
end

function RentTaskReceiveLetterDlg:selectLetterListPanel(...)
	self.curPanel = self.letterPanel

	self.receivePanel:setVisible(false)
	self.letterPanel:setVisible(true)
	self.btnTabReceive:setEnable(true)
	self.btnTabLetter:setEnable(false)
	self.letterPanel:onPanelOpen()
end

function RentTaskReceiveLetterDlg:_onClickClose()
	if self.letterPanel then
		self.letterPanel:onPanelClose()
	end

	self:setVisible(false)
end

function RentTaskReceiveLetterDlg:_onClickTabReceive()
	self:selectOwnerMsgPanel()
end

function RentTaskReceiveLetterDlg:_onClickTabLetter()
	self:selectLetterListPanel()
end

function RentTaskReceiveLetterDlg:refreshReceivePanel(...)
	if self.curPanel == self.receivePanel then
		self.receivePanel:refreshOwnerMsgPanel()
	end
end

function RentTaskReceiveLetterDlg:refreshLetterPanel(...)
	if self.curPanel == self.letterPanel then
		self.letterPanel:setData()
		self.letterPanel:refresh()
	end
end

function RentTaskReceiveLetterDlg:onRentGetLetter(...)
	if self.letterPanel then
		self.letterPanel:onRentGetLetter()
	end
end

function RentTaskReceiveLetterDlg:onClose(...)
	self.receivePanel:clear()
	RentTaskReceiveLetterDlg.super.onClose(self)
end

return RentTaskReceiveLetterDlg
