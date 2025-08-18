-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\PrivilegeMonthCardConfirmBoxJP.lua

local PrivilegeMonthCardConfirmBoxJP = Class("PrivilegeMonthCardConfirmBoxJP", UIControls.Window)

function PrivilegeMonthCardConfirmBoxJP:ctor(...)
	self:initUI()
end

function PrivilegeMonthCardConfirmBoxJP:initUI(...)
	self.checkmark = UIControls.Image(self, "Bg/ContentPanel/AgreementCheckPanel/Background/Checkmark")
	self.btnAgreement = UIControls.Button(self, "Bg/ContentPanel/AgreementCheckPanel/BtnAgreement")

	self.btnAgreement:addEventClick(self.onBtnAgreementClick)

	self.btnDeny = UIControls.Button(self, "Bg/BtnDeny")

	self.btnDeny:addEventClick(self.onBtnDenyClick)

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.agreementCheckPanel = UIControls.Toggle(self, "Bg/ContentPanel/AgreementCheckPanel")

	self.agreementCheckPanel:addEventValueChanged(self.onClickAgree)
end

function PrivilegeMonthCardConfirmBoxJP:onOpen()
	PrivilegeMonthCardConfirmBoxJP.super.onOpen(self)

	if self.isAgree == nil then
		self.isAgree = false
	end

	self.btnConfirm:setEnable(self.isAgree)
	self.checkmark:setVisible(self.isAgree)
end

function PrivilegeMonthCardConfirmBoxJP:onBtnDenyClick()
	self:setVisible(false)
end

function PrivilegeMonthCardConfirmBoxJP:onClickAgree(...)
	self.isAgree = not self.isAgree

	self.btnConfirm:setEnable(self.isAgree)
	self.checkmark:setVisible(self.isAgree)
end

function PrivilegeMonthCardConfirmBoxJP:onBtnAgreementClick()
	UIManager.getUI("storeLawJP", true):showLaw(3)
end

function PrivilegeMonthCardConfirmBoxJP:onBtnConfirmClick()
	if self.confirmCallBack then
		self:setVisible(false)
		self.confirmCallBack()
	end
end

return PrivilegeMonthCardConfirmBoxJP
