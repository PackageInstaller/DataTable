-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\SDKCore.lua

local SDKConst = require("SDK/SDKConst")
local SDKUtils = require("SDK/SDKUtils")
local ChannelUtil = require("SDK/ChannelUtil")
local EventType = SDKConst.EventType
local AttName = SDKConst.AttName
local ResponseCode = SDKConst.ResponseCode
local HttpUtils = Framework.Network.HttpUtils
local U3DOceanSDK = Framework.SDK.U3DOceanSDK
local SDKCore = {}

SDKCore._EventCallback = {}

local eventCache = {}

function SDKCore.postInit()
	local timer = Timer.New(SDKCore.doPostInit, 0.1, 1)

	timer:Start()
end

function SDKCore.doPostInit()
	U3DOceanSDK.SetLuaEventCallback(SDKCore.onGetSDKEvent)
end

function SDKCore.setEventCallback(eventType, callback)
	SDKCore._EventCallback[eventType] = callback

	if callback and eventCache[eventType] ~= nil then
		callback(eventCache[eventType])

		eventCache[eventType] = nil
	end
end

function SDKCore.onGetSDKEvent(eventType, data)
	if eventType == nil then
		-- block empty
	end

	local tableData = ClientUtils.string2Table(data)

	if RegionUtils.isCN() and next(tableData) == nil and eventType == SDKConst.EventType.EVENT_LOGIN_FAIL then
		tableData = data
	end

	local callback = SDKCore._EventCallback[eventType]

	if callback then
		callback(tableData)
	else
		eventCache[eventType] = data
	end
end

function SDKCore.doAnyFunction(funcName, data)
	return ChannelUtil.doAnyFunction(funcName, data)
end

function SDKCore.addUserData(paramUserData)
	local userData = SDKUtils.stringify(paramUserData)
	local stringData = ClientUtils.table2String(userData)

	U3DOceanSDK.AddUserData(stringData)
end

function SDKCore.getUserData()
	local userData = ClientUtils.string2Table(U3DOceanSDK.GetUserData())

	return userData
end

function SDKCore.getUserValue(attName)
	return U3DOceanSDK.GetUserValue(attName)
end

function SDKCore.getPlatformData()
	local platformData = ClientUtils.string2Table(U3DOceanSDK.GetPlatformData())

	return platformData
end

return SDKCore
