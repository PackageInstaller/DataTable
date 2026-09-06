-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bulletscreen/view/SendBulletView.lua

module("logic.extensions.bulletscreen.view.SendBulletView", package.seeall)

local SendBulletView = class("SendBulletView", ViewComponent)

function SendBulletView:ctor()
	SendBulletView.super.ctor(self)
end

function SendBulletView:destroyUI()
	SendBulletView.super.destroyUI(self)
end

function SendBulletView:onExitFinished()
	SendBulletView.super.onExitFinished(self)
end

function SendBulletView:onEnterFinished()
	SendBulletView.super.onEnterFinished(self)
end

function SendBulletView:unbindEvents()
	SendBulletView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._bgBtn:RemoveClickListener()
	self._inputField:RemoveOnValueChanged()
	self._btnOk:RemoveClickListener()
	self._btnToggle:RemoveClickListener()
end

function SendBulletView:bindEvents()
	SendBulletView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._bgBtn:AddClickListener(self._onClickClose, self)
	self._inputField:AddOnValueChanged(self._onValueChanged, self)
	self._btnOk:AddClickListener(self._onClickOk, self)
	self._btnToggle:AddClickListener(self._onClickToggle, self)
end

function SendBulletView:onExit()
	SendBulletView.super.onExit(self)
	GlobalDispatcher:dispatch(GlobalNotify.SendBulletViewClosed)

	self._isEntered = false
end

function SendBulletView:buildUI()
	SendBulletView.super.buildUI(self)

	self._closeButton = self:getBtn("Nego_Main/Btn_Close")
	self._bgBtn = self:getBtn("Nego_Main/raycast")

	local Nego_Main = self:getGo("Nego_Main")

	self._btnOk = self:getBtn("Nego_Main/btnOk")
	self._inputField = Framework.InputFieldAdapter.GetFrom(Nego_Main, "inputField")
	self._txtLeftCount = goutil.findChildTextComponent(Nego_Main, "txtLeftCount")
	self._btnToggle = self:getBtn("Nego_Main/btnToggle")
	self._togOn = goutil.findChild(self._btnToggle.gameObject, "on")
	self._togOff = goutil.findChild(self._btnToggle.gameObject, "off")
end

function SendBulletView:onEnter()
	SendBulletView.super.onEnter(self)
	self:_updateBtnGray(true)

	self._maxLen = 30

	self._inputField:SetText("")
	self._inputField:SetCharacterLimit(self._maxLen)

	self._isEntered = true

	local isOn = BulletScreenController.instance:getOnOff()

	self:_updateToggle(isOn)

	self._lastSendTime = nil
end

function SendBulletView:_updateToggle(isOn)
	goutil.setActive(self._togOn, isOn)
	goutil.setActive(self._togOff, not isOn)
end

function SendBulletView:_onValueChanged()
	local text = self._inputField:GetText()
	local newText = string.gsub(text, "\n", "")

	if newText ~= text then
		self._inputField:SetText(newText)
	else
		self:_updateBtnGray(string.nilorempty(text))

		local t = StringUtil.utf8split(text)
		local len = 0

		for i = 1, #t do
			if i > self._maxLen then
				break
			else
				len = len + 1
			end
		end

		self._txtLeftCount.text = string.format("%s/%s", len, self._maxLen)
	end
end

function SendBulletView:_updateBtnGray(isGray)
	if self._isGray ~= isGray then
		self._isGray = isGray

		uGuiUtil.setGoGrayState(self._btnOk, isGray)

		self._isGray = isGray
	end
end

function SendBulletView:_onClickOk()
	local text = self._inputField:GetText()

	if string.nilorempty(text) then
		FloatWordMgr.instance:show("发送弹幕不能为空")
	elseif ServerTime.now() - checknumber(self._lastSendTime) <= 5 then
		FloatWordMgr.instance:show("发送弹幕太频繁了，请休息一下")
	else
		local key, subKey = BulletScreenModel.instance:getCurKeys()
		local time = ServerTime.now() - BulletScreenController.instance:getStartTime()

		SurveyAgent.instance:sendPM_DanMuCheckAndSaveReq(tostring(key), tostring(subKey), time, text, function(msg)
			local content = msg.afterCheckContent

			GlobalDispatcher:dispatch(GlobalNotify.BulletSendSuccess, content)
			BulletScreenModel.instance:localAddBullet(key, subKey, content, time)
			FloatWordMgr.instance:show("发送成功")
			self._inputField:SetText("")

			self._lastSendTime = ServerTime.now()
		end)
	end
end

function SendBulletView:_onClickToggle()
	local isOn = not BulletScreenController.instance:getOnOff()

	BulletScreenController.instance:setOnOff(isOn)
	GlobalDispatcher:dispatch(GlobalNotify.BulletScreenToggled, isOn)
	self:_updateToggle(isOn)
end

function SendBulletView:_onClickClose()
	self:close()
end

return SendBulletView
