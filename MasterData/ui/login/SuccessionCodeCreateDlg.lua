-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\SuccessionCodeCreateDlg.lua

local strClassName = "SuccessionCodeCreateDlg"
local SuccessionCodeCreateDlg = Class(strClassName, UIControls.Window)
local UIControls = require("UI/UIControls")
local OpenServerHelper = require("Network/OpenServerHelper")
local UrlConfig = require("Network/UrlConfig")
local SDKConst = require("SDK/SDKConst")
local PluginManager = require("SDK/Plugin/PluginManager")
local UserData = require("Helper/UserData")
local UrlConfig = require("Network/UrlConfig")
local OpenServerHelper = require("Network/OpenServerHelper")
local ResponseCode = SDKConst.ResponseCode

function SuccessionCodeCreateDlg:ctor()
	self.passwordInput = UIControls.Label(self, "Bg/SetPanel/PasswordInputField/Text")
	self.passwordConfirm = UIControls.Label(self, "Bg/SetPanel/PasswordConfirmField/Text")
	self.agreementSwitch = UIControls.Toggle(self, "Bg/SetPanel/AgreementSwitch")

	self.agreementSwitch:setOn(false)
	self.agreementSwitch:addEventValueChanged(self.onAgreementSelectChanged)

	self.btnCancel = UIControls.Button(self, "Bg/SetPanel/BtnCancel")

	self.btnCancel:addEventClick(self.onCancelClick)

	self.btnConfirm = UIControls.Button(self, "Bg/SetPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onConfirmClick)
	self.btnConfirm:setEnable(false)

	self.privacy = UIControls.Button(self, "Bg/SetPanel/AgreementSwitch/BtnPrivacy")

	self.privacy:addEventClick(self.onPrivacyClick)

	self.textTitle = UIControls.Label(self, "Bg/TextTitle")
	self.setPanel = UIControls.Panel(self, "Bg/SetPanel")
	self.showPanel = UIControls.Panel(self, "Bg/ShowPanel")
	self.IDText = UIControls.Label(self, "Bg/ShowPanel/IDPanel/Text")
	self.passwordText = UIControls.Label(self, "Bg/ShowPanel/PasswordPanel/Text")
	self.btnScreenShot = UIControls.Button(self, "Bg/ShowPanel/BtnScreenshot")

	self.btnScreenShot:addEventClick(self.onScreenShotClick)

	self.btnConfirmInShow = UIControls.Button(self, "Bg/ShowPanel/BtnConfirm")

	self.btnConfirmInShow:addEventClick(self.onConfirmClickInShow)

	self.successionPassword = nil
	self.successionID = nil
end

function SuccessionCodeCreateDlg:show()
	if not self:getVisible() then
		self:setVisible(true)
	end
end

function SuccessionCodeCreateDlg:onConfirmClick()
	if self.passwordInput:getText() == "" then
		MsgManager.notice(Lang.get(76352))

		return
	end

	if self.passwordConfirm:getText() == "" then
		MsgManager.notice(Lang.get(76352))

		return
	end

	if self.passwordInput:getText() == self.passwordConfirm:getText() then
		self.successionPassword = self.passwordInput:getText()

		local token = UserData.loadCommonData("jp_login_token")
		local acctype = UserData.loadCommonData("jp_login_acctype")
		local access_token = UserData.loadCommonData("jp_sdk_token")
		local data = {}

		data.acctype = acctype
		data.token = token
		data.connection_code_password = self.successionPassword
		data.access_token = access_token
		data.language = "ja"

		local urls = UrlConfig.SetCode

		OpenServerHelper.httpPost(urls, data, Slot(self._onSetCodeIdResp, self), 3)
	else
		MsgManager.notice(Lang.get(76353))
	end
end

function SuccessionCodeCreateDlg:onCancelClick()
	local successionCodeChooseDlg = UIManager.getUI("successionCodeChooseDlg")

	if successionCodeChooseDlg then
		successionCodeChooseDlg:show()
		self:setVisible(false)
	end
end

function SuccessionCodeCreateDlg:onPrivacyClick()
	SDKAgent.openAgreement("privacy")
end

function SuccessionCodeCreateDlg:onAgreementSelectChanged()
	if self.agreementSwitch:isOn() then
		self.btnConfirm:setEnable(true)
	else
		self.btnConfirm:setEnable(false)
	end
end

function SuccessionCodeCreateDlg:onScreenShotClick()
	PluginManager.tryInitShare()

	local captureDlg = UIManager.getUI("captureDlg", true)

	captureDlg:captureDMM(nil, {
		frameType = 0
	})
end

function SuccessionCodeCreateDlg:onConfirmClickInShow()
	self:setVisible(false)
end

function SuccessionCodeCreateDlg:_onSetCodeIdResp(succ, data)
	Framework.Tools.LuaToolkit.LogEx("cwtjp _onSetCodeIdResp:" .. succ .. "|" .. data)

	if succ then
		if string.find(data, "error") then
			local data = ClientUtils.string2Table(data)
			local code = data.error.code
			local msg = data.error.message

			MsgManager.notice(code .. "," .. msg)

			return
		end

		local respData = ClientUtils.string2Table(data)

		self.successionID = respData.connection_code_id

		self.textTitle:setText(Lang.get(75618))
		self.setPanel:setVisible(false)
		self.showPanel:setVisible(true)
		self.IDText:setText(self.successionID)
		self.passwordText:setText(respData.connection_code_password)
	end
end

return SuccessionCodeCreateDlg
