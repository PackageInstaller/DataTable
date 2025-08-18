-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\SDKImp\\SDKImpBilibili.lua

local SDKImpCommon = require("SDK/SDKImp/SDKImpCommon")
local SDKImpBilibili = Class("SDKImpBilibili", SDKImpCommon, true)
local SDKConst = require("SDK/SDKConst")
local OpenServerConst = require("Network/OpenServerConst")
local SDKCore = require("SDK/SDKCore")
local DeviceHelper = require("Helper/DeviceHelper")
local U3DOceanSDK = Framework.SDK.U3DOceanSDK
local AttName = SDKConst.AttName
local LoginState = SDKConst.LoginState

function SDKImpBilibili:accountCenter()
	if DeviceHelper.isIOS() then
		ChannelUtil.doAnyFunction("showPersonCenter", {})
	elseif DeviceHelper.isAndroid() then
		U3DOceanSDK.ShowPersonCenter()
	end
end

function SDKImpBilibili:agreement(protocol)
	if protocol == "agreement" then
		ChannelUtil.doAnyFunction("showUserAgreement", 1)
	elseif protocol == "privacy" then
		ChannelUtil.doAnyFunction("showPrivacyPolicy", 1)
	end
end

function SDKImpBilibili:questionnaire(url, callback)
	ChannelUtil.doAnyFunction("questionnaire", {})
end

function SDKImpBilibili:_onSDKLoginSucc(data)
	local requestData = {}
	local accountChannel = data[AttName.CHANNEL_ID]
	local id, token = data[AttName.USER_ID], data[AttName.USER_TOKEN]
	local appId = tonumber(data[AttName.APP_ID])

	requestData[OpenServerConst.ACCOUNT_TYPE] = self:getAcctype(accountChannel)
	requestData[OpenServerConst.ACCOUNT_ID] = id
	requestData[OpenServerConst.ACCOUNT_SESSION] = token
	requestData[OpenServerConst.APP_ID] = appId

	self:_requestToken(requestData)

	local userData = SDKCore.getUserData()

	if userData then
		for i, v in pairs(userData) do
			if v == "sdk_device_id" then
				local udid = {}

				udid.sdk_device_id = i

				SDKCore.addUserData(udid)

				break
			end
		end
	end
end

return SDKImpBilibili
