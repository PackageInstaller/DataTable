-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\SDKImp\\SDKImpBiliKorea.lua

local SDKImpCommon = require("SDK/SDKImp/SDKImpCommon")
local SDKImpBiliKorea = Class("SDKImpBiliKorea", SDKImpCommon, true)
local UserData = require("Helper/UserData")
local SDKConst = require("SDK/SDKConst")
local AttName = SDKConst.AttName
local OpenServerConst = require("Network/OpenServerConst")
local U3DOceanSDK = Framework.SDK.U3DOceanSDK
local SDKConst = require("SDK/SDKConst")
local LoginState = SDKConst.LoginState

function SDKImpBiliKorea:init()
	SDKImpBiliKorea.super.init(self)
end

function SDKImpBiliKorea:accountCenter()
	if AccountManager.getLoginState() == LoginState.UNLOGIN then
		U3DOceanSDK.Login()
	else
		U3DOceanSDK.SwitchAccount(SvrListManager.getAccountSeverAndRoleInfo())
	end
end

function SDKImpBiliKorea:agreement(protocol)
	if protocol then
		if protocol == "agreement" then
			WebView.openWebView("https://resource.xgjoy.com/agreement/figurestory/User-Protocol.html")
		elseif protocol == "privacy" then
			WebView.openWebView("https://resource.xgjoy.com/agreement/figurestory/Privacy-Protocol.html")
		elseif protocol == "privacyChildren" then
			WebView.openWebView("https://resource.xgjoy.com/agreement/figurestory/Children-Privacy.html")
		elseif protocol == "thirdParty" then
			WebView.openWebView("http://resource.xgjoy.com/agreement/figurestory/third-info-sharing.html")
		end
	else
		UIManager.getUI("agreementPop", true)
	end
end

function SDKImpBiliKorea:questionnaire(url, callback)
	ChannelUtil.doAnyFunction("questionnaire", {})
end

function SDKImpBiliKorea:_onSDKLoginSucc(data)
	local requestData = {}
	local accountChannel = data[AttName.CHANNEL_ID]
	local id, token = data[AttName.USER_ID], data[AttName.USER_TOKEN]

	requestData[OpenServerConst.ACCOUNT_TYPE] = "flow"
	requestData[OpenServerConst.ACCOUNT_ID] = id
	requestData[OpenServerConst.ACCOUNT_SESSION] = token

	self:_requestToken(requestData)
end

return SDKImpBiliKorea
