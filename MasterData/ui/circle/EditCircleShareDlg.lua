-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\EditCircleShareDlg.lua

local strClassName = "EditCircleShareDlg"
local EditCircleShareDlg = Class(strClassName, UIControls.Window)

function EditCircleShareDlg:ctor(...)
	self:initUI()
end

function EditCircleShareDlg:initUI(...)
	self.btnCancel = UIControls.Button(self, "Bg/BtnDeny")

	self.btnCancel:addEventClick(self.onBtnCancelClick)

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.inputField = UIControls.Input(self, "Bg/SignInputField")

	ClientUtils.checkInputValueChange(self.inputField)

	self.txtDefaultContent = UIControls.Label(self, "Bg/SignInputField/Placeholder")

	self.txtDefaultContent:setText(ClientUtils.getClientNotice(607))
end

function EditCircleShareDlg:markInputIllegal(hint)
	ClientUtils.markInputIllegal(self.inputField, hint)
end

function EditCircleShareDlg:onBtnConfirmClick(...)
	if not CurAvatar:isInCircle() and CurAvatar:getMyDutyPermission().advertise ~= nil then
		return
	end

	local content = self.inputField:getText()

	content = utils.trimStartEnd(content)

	local len = utils.utf8len(content, 2)

	if len > Const.CIRCLE_SHARE_CHARACTER then
		MsgManager.notice(Lang.get(45336))

		return
	end

	if len == 0 then
		content = ClientUtils.getClientNotice(607)
	end

	RPC.clanFuncShare(CurAvatar.myCircle.gid, content)
end

function EditCircleShareDlg:onBtnCancelClick(...)
	self:setVisible(false)
end

return EditCircleShareDlg
