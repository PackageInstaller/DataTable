-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\SDKAppUtils.lua

local ChannelUtil = require("SDK/ChannelUtil")
local WebView = require("SDK/Plugin/WebView")
local DeviceHelper = require("Helper/DeviceHelper")
local SDKConst = require("SDK/SDKConst")
local SDKCore = require("SDK/SDKCore")
local AttName = SDKConst.AttName
local U3DOceanSDK = Framework.SDK.U3DOceanSDK
local NativeUtils = Framework.Plugin.NativeUtils
local EventType = SDKConst.EventType
local SDKAppUtils = {}
local USER_EVENT = {
	PICK_IMAGE = 1,
	GET_LOCATION = 2
}

SDKAppUtils._userCallbackDict = {}
SDKAppUtils._PKG_NAME_FLOW_ANDROID = "com.xgjoy.zhanguoji"
SDKAppUtils._APPLE_ID_PW = "1435148107"
SDKAppUtils._APPLE_ID_FLOW = "1470369093"

local eventCallback = {
	[EventType.EVENT_PICK_IMAGE] = "_onPickImage",
	[EventType.EVENT_GET_LOCATION] = "_onGetLocation",
	[EventType.EVENT_EXIT_ATTEMPT] = "_onExitAttempt",
	[EventType.EVENT_EXIT_GAME] = "_onExitConfirm"
}

SDKAppUtils._cachedNativeDeviceID = nil

function SDKAppUtils.init()
	for eventType, callbackName in pairs(eventCallback) do
		SDKCore.setEventCallback(eventType, SDKAppUtils[callbackName])
	end

	SDKAppUtils.PluginManager = require("SDK/Plugin/PluginManager")
end

function SDKAppUtils.exitApp(showConfirm)
	NativeUtils.ExitApp(showConfirm == true)
end

function SDKAppUtils.restartApp()
	NativeUtils.RestartApp()
end

function SDKAppUtils.pickImage(aspectX, aspectY, outputWidth, outputHeight, format, callback)
	local data = {
		[AttName.IMAGE_ASPECT_RATIO_X] = aspectX,
		[AttName.IMAGE_ASPECT_RATIO_Y] = aspectY,
		[AttName.IMAGE_RES_WIDTH] = outputWidth,
		[AttName.IMAGE_RES_HEIGHT] = outputHeight,
		[AttName.IMAGE_FILE_FORMAT] = format
	}

	SDKAppUtils._setUserCallback(USER_EVENT.PICK_IMAGE, callback)
	U3DOceanSDK.PickImage(ClientUtils.table2String(data))
end

function SDKAppUtils.getLocation(callback)
	return
end

function SDKAppUtils.rateApp()
	return
end

function SDKAppUtils.getAppleId()
	return nil
end

function SDKAppUtils.getPackageName()
	return UnityEngine.Application.identifier
end

function SDKAppUtils.viewAppInStore()
	if DeviceHelper.isAndroid() then
		local packageName = SDKAppUtils.getPackageName()

		if packageName then
			local url = string.format("market://details?id=%s", packageName)

			WebView.unityOpenUrl(url)
		end
	elseif DeviceHelper.isIOS() then
		local appId = SDKAppUtils.getAppleId()

		if appId then
			local url = string.format("itms-apps://itunes.apple.com/app/id%s", appId)

			WebView.unityOpenUrl(url)
		end
	end
end

function SDKAppUtils.getNativeDeviceID()
	if SDKAppUtils._cachedNativeDeviceID == nil then
		local platformData = SDKCore.getPlatformData()

		SDKAppUtils._cachedNativeDeviceID = platformData and platformData[AttName.NATIVE_DEVICE_ID]

		if SDKAppUtils._cachedNativeDeviceID == nil then
			SDKAppUtils._cachedNativeDeviceID = "UNITY-" .. UnityEngine.SystemInfo.deviceUniqueIdentifier
		end
	end

	return SDKAppUtils._cachedNativeDeviceID
end

function SDKAppUtils.isUnityPackage()
	return U3DOceanSDK.IsUnityPackage()
end

function SDKAppUtils._setUserCallback(event, callback)
	SDKAppUtils._userCallbackDict[event] = callback
end

function SDKAppUtils._callUserCallback(event, ...)
	local callback = SDKAppUtils._userCallbackDict[event]

	if callback ~= nil then
		callback(...)

		SDKAppUtils._userCallbackDict[event] = nil
	end
end

function SDKAppUtils._onPickImage(data)
	if data == nil then
		return
	end

	local isSucc = data[AttName.RESULT] ~= "0"
	local path = data and data[AttName.IMAGE_FILE_PATH]

	SDKAppUtils._callUserCallback(USER_EVENT.PICK_IMAGE, isSucc, path)
end

function SDKAppUtils._onGetLocation(data)
	if data == nil then
		return
	end

	local isSucc = data[AttName.RESULT] ~= "0"
	local reason = data[AttName.REASON]
	local city = data[AttName.CITY_NAME]
	local lat = tonumber(data[AttName.LATITUDE])
	local lon = tonumber(data[AttName.LONGITUDE])

	SDKAppUtils._callUserCallback(USER_EVENT.GET_LOCATION, isSucc, reason, city, lat, lon)
end

function SDKAppUtils._onExitAttempt()
	U3DOceanSDK.ExitGame()
end

function SDKAppUtils.onPause()
	SDKAppUtils.PluginManager.onPause()
end

function SDKAppUtils.onResume()
	SDKAppUtils.PluginManager.onResume()
end

function SDKAppUtils.onGameStop()
	SDKAppUtils.PluginManager.onExit()
	SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.EXIT_GAME)
end

return SDKAppUtils
