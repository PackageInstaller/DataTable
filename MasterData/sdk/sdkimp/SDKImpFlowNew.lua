-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\SDKImp\\SDKImpFlowNew.lua

local SDKImpBase = require("SDK/SDKImp/SDKImpBase")
local SDKImpFlowNew = Class("SDKImpFlowNew", SDKImpBase, true)
local SDKConst = require("SDK/SDKConst")
local SDKCore = require("SDK/SDKCore")
local DeviceHelper = require("Helper/DeviceHelper")
local ChannelUtil = require("SDK/ChannelUtil")
local WebView = require("SDK/Plugin/WebView")
local U3DOceanSDK = Framework.SDK.U3DOceanSDK
local AttName = SDKConst.AttName
local AccountManager = AccountManager
local LoginState = SDKConst.LoginState
local HttpUtils = Framework.Network.HttpUtils
local Base64 = require("Common/Tools/Base64")
local RetryHelper = require("Helper/RetryHelper")

function SDKImpFlowNew:init()
	SDKImpFlowNew.super.init(self)
end

function SDKImpFlowNew:_doLogin()
	self:_setQQSpinner(true)

	if RegionUtils.isJP() and VersionUtils.IsReviewVersion() then
		ChannelUtil.doAnyFunction("loginVisitor", {})
	else
		U3DOceanSDK.Login()
	end
end

function SDKImpFlowNew:_onSDKLoginSucc(data)
	self:_setQQSpinner(false)
	SDKImpFlowNew.super._onSDKLoginSucc(self, data)
end

function SDKImpFlowNew:_onSDKLoginCancel()
	self:_setQQSpinner(false)
	SDKImpFlowNew.super._onSDKLoginCancel(self)
end

function SDKImpFlowNew:_onSDKLoginFail(data)
	self:_setQQSpinner(false)
	SDKImpFlowNew.super._onSDKLoginFail(self, data)
end

function SDKImpFlowNew:_doLogout()
	U3DOceanSDK.Logout()
end

function SDKImpFlowNew:_doSwitchAccount()
	U3DOceanSDK.SwitchAccount()
end

function SDKImpFlowNew:_doAccountCenter()
	if AccountManager.getLoginState() == LoginState.UNLOGIN then
		U3DOceanSDK.Login()
	else
		U3DOceanSDK.SwitchAccount(SvrListManager.getAccountSeverAndRoleInfo())
	end
end

function SDKImpFlowNew:_doBindGuest()
	U3DOceanSDK.ShowUpgradeGuest()
end

function SDKImpFlowNew:_doSDKPay(content)
	U3DOceanSDK.SdkPay(content)
end

function SDKImpFlowNew:isGuest()
	return SDKCore.getUserValue(AttName.IS_GUEST) == "1"
end

function SDKImpFlowNew:customerService()
	if ChannelUtil.isSteam() then
		WebView.openWebView("tencent://AddContact/?fromId=45&fromSubId=1&subcmd=all&uin=1595584560&website=www.oicqzone.com")
	else
		ChannelUtil.doAnyFunction("customerService", {})
	end
end

function SDKImpFlowNew:agreement(protocol)
	if protocol then
		if protocol == "agreement" then
			self:openUserAgreement()
		elseif protocol == "privacy" then
			self:openPrivacy()
		elseif protocol == "privacyChildren" then
			self:openPrivacyChildren()
		elseif protocol == "thirdParty" then
			self:openThird()
		end
	else
		UIManager.getUI("agreementPop", true)
	end
end

function SDKImpFlowNew:questionnaire(url, callback)
	WebView.openWebView(url, callback)
end

function SDKImpFlowNew:showNotice()
	local notice

	if RegionUtils.isJP() then
		notice = UIManager.getUI("loginNoticeJP")
	else
		notice = UIManager.getUI("loginNotice")
	end

	if notice then
		notice:show()
	end
end

function SDKImpFlowNew:isSupportAccountSwitch()
	return U3DOceanSDK.IsSupportAccountSwitch()
end

function SDKImpFlowNew:_onGetToken(eventType, succ, data, reqTokenData)
	SDKImpFlowNew.super._onGetToken(self, eventType, succ, data, reqTokenData)
end

function SDKImpFlowNew:getSDKUserID()
	return SDKCore.getUserValue(AttName.USER_ID) or ""
end

function SDKImpFlowNew:_setQQSpinner(visible)
	if ChannelUtil.isQQGame() then
		RetryHelper.setSpinnerVisible(Const.RETRY_NAME_LOGIN_SDK, visible)
	end
end

function SDKImpFlowNew:getQQInfo()
	local userData = SDKCore.getUserData()
	local openID = userData[AttName.TENCENT_OPEN_ID]
	local openKey = userData[AttName.TENCENT_OPEN_KEY]

	return openID, openKey
end

function SDKImpFlowNew:openUserAgreement()
	if RegionUtils.isCN() then
		WebView.openWebView("https://resource.xgjoy.com/agreement/figurestory/User-Protocol.html")
	elseif RegionUtils.isSEA() then
		WebView.openWebView("https://resource-global.flowgame.com/agreement/eng/user-protocol.htm")
	elseif RegionUtils.isKR() then
		WebView.openWebView("https://resource-global.flowgame.com/agreement/ko/user-protocol.htm")
	elseif RegionUtils.isJP() then
		WebView.openWebView("https://resource-global.flowgame.com/agreement/jp/user-protocol.htm")
	end
end

function SDKImpFlowNew:openPrivacy()
	if RegionUtils.isCN() then
		if ChannelUtil.getSubChannelID() == "xxgame" then
			WebView.openWebView("https://s-cdn.xxbox.cn/cdn/txt/privacy_2.html")
		else
			WebView.openWebView("https://resource.xgjoy.com/agreement/figurestory/Privacy-Protocol.html")
		end
	elseif RegionUtils.isSEA() then
		WebView.openWebView("https://resource-global.flowgame.com/agreement/eng/privacy-protocol.htm")
	elseif RegionUtils.isKR() then
		WebView.openWebView("https://resource-global.flowgame.com/agreement/ko/privacy-protocol.htm")
	elseif RegionUtils.isJP() then
		WebView.openWebView("https://resource-global.flowgame.com/agreement/jp/privacy-protocol.htm")
	end
end

function SDKImpFlowNew:openPrivacyChildren()
	if RegionUtils.isCN() then
		WebView.openWebView("https://resource.xgjoy.com/agreement/figurestory/Children-Privacy.html")
	end
end

function SDKImpFlowNew:openThird()
	if RegionUtils.isCN() then
		WebView.openWebView("http://resource.xgjoy.com/agreement/figurestory/third-info-sharing.html")
	end
end

return SDKImpFlowNew
