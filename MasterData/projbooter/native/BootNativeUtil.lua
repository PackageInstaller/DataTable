-- chunkname: @projbooter/native/BootNativeUtil.lua

module("projbooter.native.BootNativeUtil", package.seeall)

local BootNativeUtil = {}

BootNativeUtil.nativeClsName = "com.shenlan.AppUtil"
BootNativeUtil.SUCCESS = 0
BootNativeUtil.FAILED = -1

function BootNativeUtil.setNativeClassName(className)
	BootNativeUtil.nativeClsName = className
end

function BootNativeUtil.getAppVersion()
	return SLFramework.NativeUtil.GetAppVersion()
end

function BootNativeUtil.getPackageName()
	if SLFramework.FrameworkSettings.IsEditor then
		return GameChannelConfig.getPackageName()
	end

	if BootNativeUtil.isWindows() then
		return SDKMgr.instance:getWinPackageName()
	end

	return SLFramework.NativeUtil.GetPackageName()
end

function BootNativeUtil.getMetaData(keyName)
	if SLFramework.FrameworkSettings.IsAndroidPlayer() then
		return SLFramework.NativeUtil.StringCallNative(BootNativeUtil.nativeClsName, "getMetaData", keyName, "")
	elseif SLFramework.FrameworkSettings.IsIOSPlayer() then
		return SLFramework.NativeUtil.GetInfoPlistValue(keyName)
	end

	return ""
end

function BootNativeUtil.getCpuName()
	if SLFramework.FrameworkSettings.IsAndroidPlayer() then
		return SLFramework.NativeUtil.StringCallNative(BootNativeUtil.nativeClsName, "getCpuName", "", "")
	end

	return UnityEngine.SystemInfo.processorType
end

function BootNativeUtil.isAndroid()
	return SLFramework.FrameworkSettings.CurPlatform == SLFramework.FrameworkSettings.AndroidPlayer
end

function BootNativeUtil.isIOS()
	return SLFramework.FrameworkSettings.CurPlatform == SLFramework.FrameworkSettings.IOSPlayer
end

function BootNativeUtil.isWindows()
	return SLFramework.FrameworkSettings.CurPlatform == SLFramework.FrameworkSettings.WindowsPlayer
end

function BootNativeUtil.isMacOS()
	return SLFramework.FrameworkSettings.CurPlatform == SLFramework.FrameworkSettings.OSXPlayer
end

function BootNativeUtil.isStandalonePlayer()
	return BootNativeUtil.isMacOS() or BootNativeUtil.isWindows()
end

function BootNativeUtil.isMobilePlayer()
	return BootNativeUtil.isAndroid() or BootNativeUtil.isIOS()
end

function BootNativeUtil.isMuMu()
	return SLFramework.GameConfig.Instance.IsMuMu
end

function BootNativeUtil.getDisplayResolution()
	return SLFramework.NativeUtil.GetDisplayWidth(), SLFramework.NativeUtil.GetDisplayHeight()
end

return BootNativeUtil
