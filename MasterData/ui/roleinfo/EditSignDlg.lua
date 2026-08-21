-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RoleInfo\\EditSignDlg.lua

local strClassName = "EditSignDlg"
local EditSignDlg = Class(strClassName, UIControls.Window)

function EditSignDlg:ctor(...)
	self:initUI()
end

function EditSignDlg:initUI(...)
	self.inputSign = UIControls.Input(self, "Bg/SignInputField")

	ClientUtils.checkInputValueChange(self.inputSign)

	self.txtPlaceHolder = UIControls.Label(self, "Bg/SignInputField/Placeholder")
	self.txtText = UIControls.Label(self, "Bg/SignInputField/Text")
	self.btnDeny = UIControls.Button(self, "Bg/BtnDeny")

	self.btnDeny:addEventClick(self.onBtnDenyClick)

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)
	self.inputSign:setCharacterLimit(60)
end

function EditSignDlg:setData(roleInfo)
	self.roleInfo = roleInfo

	if self.roleInfo.signature ~= "" then
		self.inputSign:setText(self.roleInfo.signature)
	end
end

function EditSignDlg:markInputIllegal(hint)
	ClientUtils.markInputIllegal(self.inputSign, hint)
end

function EditSignDlg:onBtnDenyClick(...)
	self:setVisible(false)
end

function EditSignDlg:onBtnConfirmClick(...)
	if CurAvatar.nextEditSignTime > ClientUtils.getServerTime() then
		MsgManager.notice(Lang.get(31307))

		return
	end

	local content = self.inputSign:getText()
	local len = utils.utf8len(content, 2)

	if len > 60 then
		MsgManager.notice(Lang.get(30743))

		return
	end

	if content == self.roleInfo.signature then
		MsgManager.notice(Lang.get(31308))

		return
	end

	CurAvatar.nextEditSignTime = ClientUtils.getServerTime() + Const.EDIT_SIGN_INTERVAL

	RPC.roleCommEditSignature(content)

	CurAvatar.cacheSign = content
end

return EditSignDlg
