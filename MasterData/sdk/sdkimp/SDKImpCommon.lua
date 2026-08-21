-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\SDKImp\\SDKImpCommon.lua

local SDKImpBase = require("SDK/SDKImp/SDKImpBase")
local SDKImpCommon = Class("SDKImpCommon", SDKImpBase, true)
local SDKConst = require("SDK/SDKConst")
local SDKCore = require("SDK/SDKCore")
local DeviceHelper = require("Helper/DeviceHelper")
local ChannelUtil = require("SDK/ChannelUtil")
local WebView = require("SDK/Plugin/WebView")
local U3DOceanSDK = Framework.SDK.U3DOceanSDK
local AttName = SDKConst.AttName

function SDKImpCommon:init()
	SDKImpCommon.super.init(self)
end

function SDKImpCommon:_doLogin()
	U3DOceanSDK.Login()
end

function SDKImpCommon:_doLogout()
	U3DOceanSDK.Logout()
end

function SDKImpCommon:_doSwitchAccount()
	if VersionUtils.getEngineVersion() == 99686 and DeviceHelper.isIOS() then
		U3DOceanSDK.ShowPersonCenter()
	else
		U3DOceanSDK.SwitchAccount(SvrListManager.getAccountSeverAndRoleInfo())
	end
end

function SDKImpCommon:_doAccountCenter()
	if VersionUtils.getEngineVersion() == 99686 and DeviceHelper.isIOS() then
		U3DOceanSDK.ShowPersonCenter()
	else
		U3DOceanSDK.SwitchAccount(SvrListManager.getAccountSeverAndRoleInfo())
	end
end

function SDKImpCommon:_doBindGuest()
	U3DOceanSDK.ShowUpgradeGuest()
end

function SDKImpCommon:_doSDKPay(content)
	U3DOceanSDK.SdkPay(content)
end

function SDKImpCommon:isGuest()
	return SDKCore.getUserValue(AttName.IS_GUEST) == "1"
end

function SDKImpCommon:customerService()
	ChannelUtil.doAnyFunction("customerService", {})
end

function SDKImpCommon:agreement(protocol)
	if protocol then
		if protocol == "agreement" then
			WebView.openWebView("https://resource.xgjoy.com/agreement/figurestory/User-Protocol.html")
		elseif protocol == "privacy" then
			if ChannelUtil.getSubChannelID() == "xxgame" then
				WebView.openWebView("https://s-cdn.xxbox.cn/cdn/txt/privacy_2.html")
			else
				WebView.openWebView("https://resource.xgjoy.com/agreement/figurestory/Privacy-Protocol.html")
			end
		elseif protocol == "privacyChildren" then
			WebView.openWebView("https://resource.xgjoy.com/agreement/figurestory/Children-Privacy.html")
		elseif protocol == "thirdParty" then
			WebView.openWebView("http://resource.xgjoy.com/agreement/figurestory/third-info-sharing.html")
		end
	else
		UIManager.getUI("agreementPop", true)
	end
end

function SDKImpCommon:questionnaire(url, callback)
	WebView.openWebView(url, callback)
end

function SDKImpCommon:showNotice()
	local notice = UIManager.getUI("loginNotice")

	if notice then
		notice:show()
	end
end

function SDKImpCommon:isSupportAccountSwitch()
	return U3DOceanSDK.IsSupportAccountSwitch()
end

function SDKImpCommon:_onGetToken(eventType, succ, data, reqTokenData)
	SDKImpCommon.super._onGetToken(self, eventType, succ, data, reqTokenData)
end

return SDKImpCommon
