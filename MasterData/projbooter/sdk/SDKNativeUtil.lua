-- chunkname: @projbooter/sdk/SDKNativeUtil.lua

module("projbooter.sdk.SDKNativeUtil", package.seeall)

local SDKNativeUtil = {}

SDKNativeUtil.nativeClsName = "com.ssgame.mobile.gamesdk.unity.UnityStaticSdk"
SDKNativeUtil.toolClsName = "com.ssgame.mobile.commonbase.unity.GameSdkTool"
SDKNativeUtil.Permissions = {
	Internet = "android.permission.INTERNET"
}

function SDKNativeUtil.isLogin()
	if not SLFramework.FrameworkSettings.IsEditor and BootNativeUtil.isAndroid() then
		return SLFramework.NativeUtil.BoolCallNative(SDKNativeUtil.nativeClsName, "isLogin", "")
	end

	return true
end

function SDKNativeUtil.isShowShareButton()
	if BootNativeUtil.isIOS() then
		return SDKMgr.instance:isShowShareButton()
	end

	return SLFramework.NativeUtil.BoolCallNative(SDKNativeUtil.nativeClsName, "isShowShareButton", "")
end

function SDKNativeUtil.isGamePad()
	if BootNativeUtil.isAndroid() and GameChannelConfig.isXfsdk() then
		if SDKNativeUtil._isGamePad == nil then
			SDKNativeUtil._isGamePad = SLFramework.NativeUtil.BoolCallNative(SDKNativeUtil.nativeClsName, "isGamePad", "")
		end

		return SDKNativeUtil._isGamePad
	end

	return false
end

function SDKNativeUtil.updateGame(appUrl)
	if BootNativeUtil.isAndroid() then
		if VersionUtil.isVersionLargeEqual("2.7.0") then
			SLFramework.NativeUtil.VoidCallNative(SDKNativeUtil.nativeClsName, "updateGame", appUrl)
		else
			SLFramework.NativeUtil.BoolCallNative(SDKNativeUtil.nativeClsName, "updateGame", "")
		end
	end
end

function SDKNativeUtil.openCostumerService()
	if BootNativeUtil.isAndroid() or BootNativeUtil.isMuMu() then
		SLFramework.NativeUtil.VoidCallNative(SDKNativeUtil.nativeClsName, "openCostumerService", "深蓝互动")

		return true
	end

	if BootNativeUtil.isWindows() and not GameChannelConfig.isSlsdk() then
		UnityEngine.Application.OpenURL("https://bluepoch.soboten.com/chat/pc/v6/index.html?sysnum=b049a5df3dff49ae9c4ad54beb088015&channelid=3")

		return true
	end

	if BootNativeUtil.isIOS() then
		SDKMgr.instance:openCostumerService()

		return true
	end

	return false
end

function SDKNativeUtil.checkPermissions(permission)
	if BootNativeUtil.isAndroid() then
		return SLFramework.NativeUtil.BoolCallNative(SDKNativeUtil.toolClsName, "checkPermissions", permission, true)
	end

	return true
end

return SDKNativeUtil
