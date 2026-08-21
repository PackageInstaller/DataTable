-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainMenu\\EditAdressDlg.lua

local EditAdressDlg = Class("EditAdressDlg", UIControls.Window)

function EditAdressDlg:ctor()
	self:initUI()
end

function EditAdressDlg:initUI()
	self.nameInputField = UIControls.Input(self, "Bg/ContentPanel/NameInputField")

	ClientUtils.checkInputValueChange(self.nameInputField)

	self.phoneInputField = UIControls.Input(self, "Bg/ContentPanel/PhoneInputField")

	ClientUtils.checkInputValueChange(self.phoneInputField)

	self.adressInputField = UIControls.Input(self, "Bg/ContentPanel/AdressInputField")

	ClientUtils.checkInputValueChange(self.adressInputField)

	self.btnDeny = UIControls.Button(self, "Bg/BtnDeny")

	self.btnDeny:addEventClick(self.onBtnDenyClick)

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)
end

function EditAdressDlg:setData()
	if CurAvatar.consigneeName then
		self.nameInputField:setText(CurAvatar.consigneeName)
	end

	if CurAvatar.consigneeName then
		self.phoneInputField:setText(CurAvatar.consigneePhone)
	end

	if CurAvatar.consigneeName then
		self.adressInputField:setText(CurAvatar.consigneeAddress)
	end
end

function EditAdressDlg:markInputIllegal(hint)
	ClientUtils.markInputIllegal(self.nameInputField, hint)
	ClientUtils.markInputIllegal(self.phoneInputField, hint)
	ClientUtils.markInputIllegal(self.adressInputField, hint)
end

function EditAdressDlg:onBtnConfirmClick()
	local name = self.nameInputField:getText()
	local phone = self.phoneInputField:getText()
	local adress = self.adressInputField:getText()
	local nameLen = utils.utf8len(name, 2)
	local phoneLen = utils.utf8len(phone)
	local adressLen = utils.utf8len(adress, 2)

	if nameLen > 20 then
		MsgManager.notice(Lang.get(83181))

		return
	elseif phoneLen > 20 then
		MsgManager.notice(Lang.get(83182))

		return
	elseif adressLen > 128 then
		MsgManager.notice(Lang.get(83183))

		return
	end

	RPC.roleMiscConsignee(name, phone, adress)
end

function EditAdressDlg:onBtnDenyClick()
	self:setVisible(false)
end

return EditAdressDlg
