-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/sdk/LebianFenbaoManager.lua

module("logiccommon.common.sdk.LebianFenbaoManager", package.seeall)

local LebianFenbaoManager = class("LebianFenbaoManager")
local clazz = "com.baitian.lebian.library.LebianFenbaoWrap"
local LebianFenbaoManager = {}
local KEY_LB_DOWNLOAD_FULL_RES = "key_sdk_download_full_res"
local KEY_LB_DOWNLOAD_PROPORTION = "key_sdk_download_proportion"

function LebianFenbaoManager.registerDownloadFullResListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_LB_DOWNLOAD_FULL_RES, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		if callObj ~= nil then
			callFunc(callObj, statusCode, statusDesc)
		else
			callFunc(statusCode, statusDesc)
		end
	end)
end

function LebianFenbaoManager.registerGetDownloadProportionListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_LB_DOWNLOAD_PROPORTION, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc
		local progress = result.progress

		if callObj ~= nil then
			callFunc(callObj, statusCode, statusDesc, progress)
		else
			callFunc(statusCode, statusDesc, progress)
		end
	end)
end

function LebianFenbaoManager.twiceLoad()
	NativeBridge.instance:invoke(clazz, "twiceLoad")
end

function LebianFenbaoManager.setResExtracting(isExtracting)
	local param = {}

	param.isExtracting = isExtracting

	return NativeBridge.instance:invokeBool(clazz, "setResExtracting", param)
end

function LebianFenbaoManager.downloadFullRes(noPrompt)
	local param = {}

	param.noPrompt = noPrompt

	NativeBridge.instance:invoke(clazz, "downloadFullRes", param)
end

function LebianFenbaoManager.getResCachePath()
	return NativeBridge.instance:invokeString(clazz, "getResCachePath")
end

function LebianFenbaoManager.isDownloadFinished()
	return NativeBridge.instance:invokeBool(clazz, "isDownloadFinished")
end

function LebianFenbaoManager.getTotalSize(compress)
	local param = {}

	param.compress = compress

	return NativeBridge.instance:invokeLong(clazz, "getTotalSize", param)
end

function LebianFenbaoManager.getTotalSize()
	return NativeBridge.instance:invokeLong(clazz, "getCurrentDlSize")
end

function LebianFenbaoManager.openDownload()
	NativeBridge.instance:invoke(clazz, "openDownload")
end

function LebianFenbaoManager.closeDownload()
	NativeBridge.instance:invoke(clazz, "closeDownload")
end

function LebianFenbaoManager.singleFileDownload(filename)
	local param = {}

	param.filename = filename

	return NativeBridge.instance:invokeInt(clazz, "singleFileDownload", param)
end

function LebianFenbaoManager.getDownloadProportion()
	NativeBridge.instance:invoke(clazz, "getDownloadProportion")
end

function LebianFenbaoManager.isSmallPkg()
	return NativeBridge.instance:invokeBool(clazz, "isSmallPkg")
end

return LebianFenbaoManager
