-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\commonBulletSendPanel.lua

local strClassName = "CommonBulletSendPanel"
local CommonBulletSendPanel = Class(strClassName, UIControls.Panel)

function CommonBulletSendPanel:ctor(...)
	self:initUI()
end

function CommonBulletSendPanel:initUI(...)
	self.bulletPanel = UIControls.Panel(self, self.mPath .. "/BulletPanel")
	self.btnBulletSwitch = UIControls.Button(self, self.mPath .. "/BulletPanel/BtnBulletSwitch")

	self.btnBulletSwitch:addEventClick(self.onBtnBulletSwitchClick)

	self.offPanel = UIControls.Panel(self, self.mPath .. "/BulletPanel/BtnBulletSwitch/OffPanel")
	self.onPanel = UIControls.Panel(self, self.mPath .. "/BulletPanel/BtnBulletSwitch/OnPanel")
	self.btnBullet = UIControls.Button(self, self.mPath .. "/BulletPanel/BtnBullet")

	self.btnBullet:addEventClick(self.onBtnBulletClick)

	self.btnSend = UIControls.Button(self, self.mPath .. "/InputPanel/Inputanel/BtnSend")

	self.btnSend:addEventClick(self.onBtnBulletSendClick)

	self.bulletSendText = UIControls.Label(self, self.mPath .. "/InputPanel/Inputanel/BtnSend/Text")
	self.inputPanel = UIControls.UIAni(self, self.mPath .. "/InputPanel")
	self.btnClose = UIControls.Button(self, self.mPath .. "/InputPanel/BtnClose")

	self.btnClose:addEventClick(self._closeBulletEdit)

	self.bulletEditInputField = UIControls.Input(self, self.mPath .. "/InputPanel/Inputanel/InputTextPanel/InputText")
	self.btnEmoji = UIControls.Button(self, self.mPath .. "/InputPanel/Inputanel/BtnEmoji")

	self.btnEmoji:addEventClick(self.onBtnEmojiClick)

	self.bulletEditAnim = UIControls.UIAni(self, self.mPath .. "/InputPanel")
	self.setBulletStateCb = nil
	self.bulletSendCb = nil
	self.bulletLengthLimit = nil
	self.bulletSendTimeLimit = nil
end

function CommonBulletSendPanel:_closeBulletEdit()
	if not self.inBulletEdit then
		return
	end

	if self.inputPanel then
		self.inputPanel:setVisible(false)
	end

	self.inBulletEdit = false

	local ui = UIManager.tryGetUI("avgBulletEmojiBox")

	if ui then
		ui:setVisible(false)
	end
end

function CommonBulletSendPanel:onBtnBulletClick()
	if self.inBulletEdit then
		self:_closeBulletEdit()
	else
		self.inBulletEdit = true

		self.inputPanel:setVisible(true)
	end
end

function CommonBulletSendPanel:onBtnEmojiClick()
	local ui = UIManager.tryGetUI("avgBulletEmojiBox")

	if not ui then
		ui = UIManager.getUI("avgBulletEmojiBox", true)

		ui:setOrder(self.mParent:getOrder() + 140)
		ui:show(self.editInput, Slot(self.onBtnBulletSendClick, self), Slot(self._onBulletEmojiClose, self))
		self.bulletEditAnim:startAni("ShowEmoji", true)
	end
end

function CommonBulletSendPanel:_onBulletEmojiClose()
	self.bulletEditAnim:startAni("CloseEmoji", true)
end

function CommonBulletSendPanel:checkBulletLength(text)
	local limit = self.bulletLengthLimit or 200
	local len = utils.utf8len(text, 2)

	if limit < len then
		MsgManager.notice(utils.format(Lang.get(51014), limit))

		return false
	end

	return true
end

function CommonBulletSendPanel:checkMsgSend()
	local now = ClientUtils.getServerTime()

	if not self.preSendTime then
		return
	end

	local time = now - self.preSendTime
	local cd = self.bulletSendTimeLimit or 15

	if time < cd then
		return string.format(Lang.get(30160), cd - time)
	end
end

function CommonBulletSendPanel:onBtnBulletSendClick(sender, content, moveFunc, moveEmojiInfo)
	local clear = true
	local type = UIConst.AVG_BULLET_TEXT
	local item_id
	local text = ""

	if content then
		clear = false
		text = content
		type = UIConst.AVG_BULLET_EMOJI
	else
		text = self.bulletEditInputField:getText()
		text = ClientUtils.checkMarkIllegal(text)
		type = UIConst.AVG_BULLET_TEXT
	end

	if moveEmojiInfo then
		item_id = moveEmojiInfo.item_id
		type = UIConst.AVG_BULLET_MOVEEMOJI
	end

	if text == "" then
		MsgManager.notice(Lang.get(30165))

		return
	end

	if not self:checkBulletLength(text) then
		return
	end

	local hint = self:checkMsgSend()

	if hint ~= nil then
		MsgManager.notice(hint)

		return
	end

	if clear then
		self.bulletEditInputField:setText("")
	end

	if self.bulletSendCb then
		self.bulletSendCb(self, text)
	end
end

function CommonBulletSendPanel:onBtnBulletSwitchClick(...)
	self:setBulletState(not self.showBulletFlag)
end

function CommonBulletSendPanel:setBulletState(state)
	self.showBulletFlag = state

	self.offPanel:setVisible(self.showBulletFlag)
	self.onPanel:setVisible(not self.showBulletFlag)

	if not state then
		local ui = UIManager.tryGetUI("bulletDlg")

		if ui then
			ui:clearAll()
		end
	end

	if self.setBulletStateCb then
		self.setBulletStateCb(self, state)
	end
end

return CommonBulletSendPanel
