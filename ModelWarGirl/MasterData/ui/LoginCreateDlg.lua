-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\LoginCreateDlg.lua

local strClassName = "LoginCreateDlg"
local LoginCreateDlg = Class(strClassName, UIControls.Window)

function LoginCreateDlg:ctor()
	self.btn = UIControls.Button(self, "UsernamePanel/FuncButton")

	self.btn:addEventClick(self.onConfirmClick)

	self.input = UIControls.Input(self, "UsernamePanel/InputUsername")
	self.toggleMale = UIControls.Toggle(self, "UsernamePanel/CheckMale")

	self.toggleMale:addEventValueChanged(self.onClickMale)

	self.bgMale = UIControls.Image(self, "BgMale")
	self.toggleFemale = UIControls.Toggle(self, "UsernamePanel/CheckFemal")

	self.toggleFemale:addEventValueChanged(self.onClickFemale)

	self.bgFemale = UIControls.Image(self, "BgFemal")

	self:onClickMale()

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onDlgClose)
end

function LoginCreateDlg:onClickMale()
	if self.inSettingMale then
		return
	end

	self.inSettingMale = true

	self.toggleMale:setOn(true)
	self.toggleFemale:setOn(false)
	self.bgMale:setVisible(true)
	self.bgFemale:setVisible(false)

	self.maleInfo = 0
	self.inSettingMale = false
end

function LoginCreateDlg:onClickFemale()
	if self.inSettingMale then
		return
	end

	self.inSettingMale = true

	self.toggleMale:setOn(false)
	self.toggleFemale:setOn(true)
	self.bgMale:setVisible(false)
	self.bgFemale:setVisible(true)

	self.maleInfo = 1
	self.inSettingMale = false
end

function LoginCreateDlg:onOpen()
	LoginCreateDlg.super.onOpen(self)
end

function LoginCreateDlg:onConfirmClick(sender)
	local name = self.input:getText()
	local failMsg = ClientUtils.checkPlayerName(name)

	if failMsg ~= "" then
		MsgManager.notice(failMsg)

		return
	end

	RPC.roleCreate(name, self.maleInfo)
end

function LoginCreateDlg:onDlgClose(sender)
	self:setVisible(false)
end

return LoginCreateDlg
