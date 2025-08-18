-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\SDKImp\\SDKImpBiliSea.lua

local SDKImpCommon = require("SDK/SDKImp/SDKImpCommon")
local SDKImpBiliSea = Class("SDKImpBiliSea", SDKImpCommon, true)
local SDKCore = require("SDK/SDKCore")
local UserData = require("Helper/UserData")
local Analytics = require("SDK/Analytics")
local DeviceHelper = require("Helper/DeviceHelper")
local SDKConst = require("SDK/SDKConst")
local AttName = SDKConst.AttName
local ChannelUtil = require("SDK/ChannelUtil")
local OpenServerConst = require("Network/OpenServerConst")
local UrlConfig = require("Network/UrlConfig")
local U3DOceanSDK = Framework.SDK.U3DOceanSDK

function SDKImpBiliSea:init()
	SDKImpBiliSea.super.init(self)

	local url

	url = string.find(UrlConfig.useBy, "iseatest") and "test-flowdata-figurestory-sea.komoejoy-sea.com:29885" or string.find(UrlConfig.useBy, "iseamain_na") and "prod-flowdata-figurestory-sea-na.komoejoy-sea.com:29885" or string.find(UrlConfig.useBy, "iseamain_eu") and "prod-flowdata-figurestory-sea-eu.komoejoy-sea.com:29885" or "prod-flowdata-figurestory-sea.komoejoy-sea.com:29885"

	UserData.saveCommonData("SeaLogUrl", url)
	Framework.SDK.AnalyticUtils.RefreshBiliUrl("SeaLogUrl", url)
end

function SDKImpBiliSea:accountCenter()
	if DeviceHelper.isIOS() then
		ChannelUtil.doAnyFunction("showPersonCenter", {})
	elseif DeviceHelper.isAndroid() then
		U3DOceanSDK.ShowPersonCenter()
	end
end

function SDKImpBiliSea:agreement(protocol)
	if protocol then
		if protocol == "agreement" then
			ChannelUtil.doAnyFunction("showUserAgreement", 3)
		elseif protocol == "privacy" then
			ChannelUtil.doAnyFunction("showPrivacyPolicy", 3)
		end
	end
end

function SDKImpBiliSea:questionnaire(url, callback)
	ChannelUtil.doAnyFunction("questionnaire", {})
end

function SDKImpBiliSea:_onSDKLoginSucc(data)
	local requestData = {}
	local accountChannel = data[AttName.CHANNEL_ID]
	local id, token = data[AttName.USER_ID], data[AttName.USER_TOKEN]
	local appId = tonumber(data[AttName.APP_ID])

	requestData[OpenServerConst.ACCOUNT_TYPE] = self:getAcctype(accountChannel)
	requestData[OpenServerConst.ACCOUNT_ID] = id
	requestData[OpenServerConst.ACCOUNT_SESSION] = token
	requestData[OpenServerConst.APP_ID] = appId

	self:_requestToken(requestData)
	self:sendLog(id)
end

function SDKImpBiliSea:getSDKUserID()
	return SDKCore.getUserValue(AttName.USER_ID) or ""
end

function SDKImpBiliSea:sendLog(uid)
	local isFirstSDKLogin = UserData.loadCommonData("isFirstSDKLogin")

	if isFirstSDKLogin == "false" then
		return
	end

	UserData.saveCommonData("isFirstSDKLogin", "false")

	local userType = SDKCore.getUserValue("userType")
	local data = {
		uid = uid,
		method = self:loginType(userType and tostring(userType) or "")
	}

	ChannelUtil.doAnyFunction("appsflyerTrackEventKey", {
		eventName = "af_complete_registration",
		eventValue = ClientUtils.table2String(data)
	})
	ChannelUtil.doAnyFunction("firebaseTrackEventKey", {
		eventName = "G_complete_registration",
		eventValue = ClientUtils.table2String(data)
	})
end

SDKImpBiliSea.LOGIN_TYPE_TO_STRING_IOS = {
	["0"] = "email",
	["1"] = "google",
	["10"] = "tourist",
	["4"] = "apple"
}
SDKImpBiliSea.LOGIN_TYPE_TO_STRING_ANDROID = {
	["0"] = "email",
	["1"] = "google",
	["6"] = "phone_number",
	["2"] = "facebook",
	["5"] = "apple",
	["3"] = "tourist",
	["4"] = "twitter"
}

function SDKImpBiliSea:loginType(id)
	local tab = DeviceHelper.isAndroid() and SDKImpBiliSea.LOGIN_TYPE_TO_STRING_ANDROID or SDKImpBiliSea.LOGIN_TYPE_TO_STRING_IOS

	return tab[id] or ""
end

return SDKImpBiliSea
