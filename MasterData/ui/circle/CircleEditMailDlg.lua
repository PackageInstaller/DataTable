-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleEditMailDlg.lua

local ResClanMisc = require("ClientData/ResClanMisc")
local strClassName = "CircleEditMailDlg"
local CircleEditMailDlg = Class(strClassName, UIControls.Window)

function CircleEditMailDlg:ctor()
	self:initUI()
end

function CircleEditMailDlg:initUI()
	self.inputTitle = UIControls.Input(self, "Bg/MailPanel/TitleInputField")

	ClientUtils.checkInputValueChange(self.inputTitle)

	self.inputContent = UIControls.Input(self, "Bg/MailPanel/ContentInputField")

	ClientUtils.checkInputValueChange(self.inputContent)

	self.txtDefaultTitle = UIControls.Label(self, "Bg/MailPanel/TitleInputField/Placeholder")
	self.txtDefaultContent = UIControls.Label(self, "Bg/MailPanel/ContentInputField/Placeholder")
	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnDeny = UIControls.Button(self, "Bg/BtnDeny")

	self.btnDeny:addEventClick(self.onBtnDenyClick)

	self.txtTips = UIControls.Label(self, "Bg/TextTips")

	self.txtTips:setText(utils.format(Lang.get(30179), ResClanMisc[1].mail_cd, ResClanMisc[1].day_mail))
end

function CircleEditMailDlg:onBtnConfirmClick()
	if self.btnLockFlag then
		return
	end

	if ClientUtils.getServerTime() < CurAvatar:getMailTick() + ResClanMisc[1].mail_cd * 60 + 3 then
		MsgManager.clientNotice(224)

		return
	end

	local title = self.inputTitle:getText()
	local content = self.inputContent:getText()

	if title == "" then
		MsgManager.clientNotice(225)

		return
	end

	if content == "" then
		MsgManager.clientNotice(226)

		return
	end

	if string.find(title, "</size>") or string.find(title, "<quad name") then
		MsgManager.notice(Lang.get(30181))

		return
	end

	if string.find(content, "</size>") or string.find(content, "<quad name") then
		MsgManager.notice(Lang.get(30182))

		return
	end

	title = string.format(Lang.get(30180), title)

	local len = utils.utf8len(title, 2)

	if len > Const.MAX_CIRCLE_MAIL_TITLE_MAXLEN then
		MsgManager.notice(Lang.get(30183))

		return
	end

	len = utils.utf8len(content, 2)

	if len > Const.MAX_CIRCLE_MAIL_CONTENT_MAXLEN then
		MsgManager.notice(Lang.get(30184))

		return
	end

	RPC.clanSendMail(title, content)

	self.btnLockFlag = true
end

function CircleEditMailDlg:onBtnDenyClick()
	self:setVisible(false)
end

function CircleEditMailDlg:markInputIllegal(hint)
	ClientUtils.markInputIllegal(self.inputTitle, hint)
	ClientUtils.markInputIllegal(self.inputContent, hint)
end

return CircleEditMailDlg
