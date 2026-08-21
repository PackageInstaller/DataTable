-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/setting/AccountSettingView.lua

module("logic.extensions.mainui.view.setting.AccountSettingView", package.seeall)

local M = class("AccountSettingView", ViewComponent)
local kOpenType = {
	Agreement = 1,
	Privacy = 2
}

function M:buildUI()
	self._btnLogout = self:getBtn("4&btn_middle_-31477526")
	self._btnFeedback = self:getBtn("5&com_btn_2_-31477526")
	self._btnExchange = self:getBtn("6&com_btn_2_-31477526")
	self._btnAgreement = self:getBtn("7&com_btn_2_-31477526")
	self._btnPrivacy = self:getBtn("8&com_btn_2_-31477526")
	self._inputExchange = self:getInput("main_setting_tips_-1248404435")
	self._btnUploadLog = self:getBtn("10&com_btn_2_-31477526")
	self._goExchange = self._inputExchange.transform.parent.parent.gameObject

	goutil.setActive(self._goExchange, not BootstrapGameConfigMgr.getIsReview())

	self._canExchange = true
end

function M:destroyUI()
	self._btnLogout = nil
	self._btnFeedback = nil
	self._btnExchange = nil
	self._btnAgreement = nil
	self._btnPrivacy = nil
	self._inputExchange = nil

	removetimer(self._exchangeAvailable, self)
end

function M:bindEvents()
	self._btnLogout:AddClickListener(self._onClickLogout, self)
	self._btnFeedback:AddClickListener(self._onClickFeedback, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnAgreement:AddClickListener(self._onClickAgreement, self)
	self._btnPrivacy:AddClickListener(self._onClickPrivacy, self)
	self._btnUploadLog:AddClickListener(self._onClickUploadLog, self)
end

function M:unbindEvents()
	self._btnLogout:RemoveClickListener()
	self._btnFeedback:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnAgreement:RemoveClickListener()
	self._btnPrivacy:RemoveClickListener()
	self._btnUploadLog:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:_onClickLogout()
	UserAgent.instance:sendLogoutRequest()
end

function M:_onClickFeedback()
	ViewMgr.instance:open(ViewName.FeedbackView)
end

function M:_exchangeAvailable()
	self._canExchange = true
end

function M:_onClickExchange()
	if not self._canExchange then
		FloatWordMgr.instance:show(lang("tip_exchange_frequently"))

		return
	end

	self._canExchange = false

	settimer(20, self._exchangeAvailable, self, false)

	local code = self._inputExchange:GetText()

	if code ~= nil and code ~= "" then
		FloatWordMgr.instance:show(lang("tip_exchange") .. code)
	else
		FloatWordMgr.instance:show(lang("tip_input_code"))
	end
end

function M:_onClickAgreement()
	local isExist = SDKManager.getSDKInstacne():showProtocolView()

	if not isExist then
		local url = string.format(GameRequestUrl.URL_USER_PROTOCAL, os.time())

		self:_showUserView(url, kOpenType.Agreement)
	end
end

function M:_onClickPrivacy()
	local isExist = SDKManager.getSDKInstacne():showPrivacyView()

	if not isExist then
		local url = string.format(GameRequestUrl.URL_USER_PRIVATE, os.time())

		self:_showUserView(url, kOpenType.Privacy)
	end
end

function M:_onClickUploadLog()
	SDKManager.loganUpload()
end

function M:_showUserView(url, openType)
	local isShowWeb = UnityWebBridge.isExistFunc()

	if isShowWeb then
		UnityWebBridge.openWebView(url, false)
	else
		print("当前平台无法打开网址", url)
		UnityEngine.Application.OpenURL(url)
	end
end

return M
