-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleEditNoticeDlg.lua

local ResClanMisc = require("ClientData/ResClanMisc")
local strClassName = "CircleEditNoticeDlg"
local CircleEditNoticeDlg = Class(strClassName, UIControls.Window)

function CircleEditNoticeDlg:ctor()
	self:initUI()
end

function CircleEditNoticeDlg:initUI()
	self.inputTitle = UIControls.Input(self, "Bg/NoticePanel/TitleInputField")

	self.inputTitle:addEventValueChanged(self.onInputTitleChanged)
	ClientUtils.checkInputValueChange(self.inputTitle)

	self.inputContent = UIControls.Input(self, "Bg/NoticePanel/ContentInputField")

	self.inputContent:addEventValueChanged(self.onInputContentChanged)
	ClientUtils.checkInputValueChange(self.inputContent)

	self.txtDefaultTitle = UIControls.Label(self, "Bg/NoticePanel/TitleInputField/Placeholder")
	self.txtDefaultContent = UIControls.Label(self, "Bg/NoticePanel/ContentInputField/Placeholder")
	self.btnDeny = UIControls.Button(self, "Bg/BtnDeny")

	self.btnDeny:addEventClick(self.onBtnDenyClick)

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.txtTips = UIControls.Label(self, "Bg/TextTips")

	self.txtTips:setText(utils.format(Lang.get(30185), ResClanMisc[1].renotice_cd, ResClanMisc[1].day_notice))

	if CurAvatar.myCircle then
		self.inputContent:setText(utils.replaceString(CurAvatar.myCircle.notice, "\n", ""))
		self.inputTitle:setText(utils.replaceString(CurAvatar.myCircle.title, "\n", ""))
	end
end

function CircleEditNoticeDlg:onBtnDenyClick()
	self:setVisible(false)
end

function CircleEditNoticeDlg:onBtnConfirmClick()
	if self.btnLockFlag then
		return
	end

	if CurAvatar.myCircle.notice == self.inputContent:getText() and CurAvatar.myCircle.title == self.inputTitle:getText() then
		MsgManager.clientNotice(236)

		return
	end

	if ClientUtils.getServerTime() < CurAvatar.myCircle.renoticeTick + ResClanMisc[1].renotice_cd * 60 + 3 then
		MsgManager.clientNotice(229)

		return
	end

	local title = utils.replaceString(self.inputTitle:getText(), "\n", "")
	local content = utils.replaceString(self.inputContent:getText(), "\n", "")

	if title == "" then
		MsgManager.notice(Lang.get(30186))

		return
	end

	if content == "" then
		MsgManager.notice(Lang.get(30187))

		return
	end

	local len = utils.utf8len(title, 2)

	if len > Const.MAX_CIRCLE_TITLE_MAXLEN then
		MsgManager.notice(Lang.get(30188))

		return
	end

	len = utils.utf8len(content, 2)

	if len > Const.MAX_CIRCLE_CONTENT_MAXLEN then
		MsgManager.notice(Lang.get(30189))

		return
	end

	RPC.clanRenotice(title, content)

	self.btnLockFlag = true
end

function CircleEditNoticeDlg:onInputTitleChanged()
	return
end

function CircleEditNoticeDlg:onInputContentChanged()
	return
end

function CircleEditNoticeDlg:markInputIllegal(hint)
	ClientUtils.markInputIllegal(self.inputTitle, hint)
	ClientUtils.markInputIllegal(self.inputContent, hint)
end

return CircleEditNoticeDlg
