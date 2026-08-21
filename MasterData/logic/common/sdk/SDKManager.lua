-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/SDKManager.lua

module("logic.common.sdk.SDKManager", package.seeall)

local SDKManager = {}
local json = require("cjson")
local manifestWrapClazz = "com.baitian.unity.ManifestUtilWrap"
local oneSdkClazz = "com.baitian.wrap.OneSDKWrap"

SDKManager.STATUS_OK = 0
SDKManager.SHARE_WEB = 0
SDKManager.SHARE_TEXT = 1
SDKManager.SHARE_PICTURE = 2
SDKManager.SHARE_STATUS_CODE_SUCCESS = 0
SDKManager.SHARE_STATUS_CODE_FAIL = -1
SDKManager.SHARE_STATUS_CODE_CANCEL = -2
SDKManager.STATUS_GUEST_UPGRADE_SUCCESS = 0
SDKManager.STATUS_GUEST_UPGRADE_CANCEL = -2
SDKManager.STATUS_REAL_NAME_AUTH_SUCCESS = 0
SDKManager.STATUS_REAL_NAME_AUTH_CANCEL = -2
SDKManager.SDKType = {
	Default = 0,
	Zh = 1,
	Xm = 2
}

function SDKManager.getSDKType()
	if Astral.OSDef.isEditor or Astral.OSDef.RunOS == Astral.OSDef.Win32 or not Astral.GameConstParser.Instance.enableSDKLogin then
		local areaName = Astral.GameConstParser.Instance.gameConfigAreaName

		if string.find(areaName, "xm") then
			return SDKManager.SDKType.Xm
		elseif Astral.GameConstParser.Instance.gameConfigSupportLanguageType == "zh" then
			return SDKManager.SDKType.Zh
		end

		return SDKManager.SDKType.Zh
	end

	if Astral.OSDef.RunOS == Astral.OSDef.IOS then
		return SDKManager.SDKType.Zh
	end

	local param = {}

	param.key = "sdkType"

	local result = NativeBridge.instance:invokeInt(manifestWrapClazz, "getIntMetaData", param)

	return result
end

function SDKManager.isXmSdk()
	local curSDKType = SDKManager.getSDKType()

	return curSDKType == SDKManager.SDKType.Xm
end

function SDKManager.isZhSdk()
	local curSDKType = SDKManager.getSDKType()

	return curSDKType == SDKManager.SDKType.zh
end

local sdkObj = false

function SDKManager.getSDKInstacne()
	if not sdkObj then
		local curSDKType = SDKManager.getSDKType()
		local impl = SDKOneSDKImpl

		if curSDKType == SDKManager.SDKType.Zh then
			impl = SDKOneSDKImpl
		elseif curSDKType == SDKManager.SDKType.Xm then
			impl = SDKUbeejoyImpl
		end

		sdkObj = impl.New()
	end

	return sdkObj
end

function SDKManager.loganLogUnity(log)
	if Astral.OSDef.RunOS == Astral.OSDef.Android or Astral.OSDef.RunOS == Astral.OSDef.IOS then
		local param = {}

		param.log = log

		NativeBridge.instance:invoke(oneSdkClazz, "loganLogUnity", param)
	end
end

function SDKManager.loganUpload()
	local curTime = os.time()

	if SDKManager._lastUploadTime ~= nil and curTime - SDKManager._lastUploadTime < 300 then
		return
	end

	if Astral.OSDef.RunOS == Astral.OSDef.Android or Astral.OSDef.RunOS == Astral.OSDef.IOS then
		NativeBridge.instance:invoke(oneSdkClazz, "loganUpload")

		SDKManager._lastUploadTime = os.time()
	end
end

return SDKManager
