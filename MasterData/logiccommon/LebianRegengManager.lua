-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/sdk/LebianRegengManager.lua

module("logiccommon.common.sdk.LebianRegengManager", package.seeall)

local LebianRegengManager = class("LebianRegengManager")
local clazz = "com.baitian.lebian.library.LebianRegengWrap"
local LebianRegengManager = {}
local KEY_LB_UPDATE_RESULT = "key_sdk_update_result"

function LebianRegengManager.registerQueryUpdateListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_LB_UPDATE_RESULT, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		if callObj ~= nil then
			callFunc(callObj, statusCode, statusDesc)
		else
			callFunc(statusCode, statusDesc)
		end
	end)
end

function LebianRegengManager.queryUpdate(tag)
	local param = {}

	param.tag = tag

	NativeBridge.instance:invoke(clazz, "queryUpdate", param)
end

function LebianRegengManager.getHostPackageInfo()
	NativeBridge.instance:invoke(clazz, "getHostPackageInfo")
end

function LebianRegengManager.afterUpdate()
	return NativeBridge.instance:invokeBool(clazz, "afterUpdate")
end

return LebianRegengManager
