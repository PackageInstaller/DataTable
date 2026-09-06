-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/sdk/NotificationMgrNew.lua

module("logiccommon.common.sdk.NotificationMgrNew", package.seeall)

local clazz = "com.baitian.getui.library.NotificationGTPushWrap"
local NotificationMgrNew = {}
local KEY_GT_BIND_ALIAS = "key_sdk_gt_bind_alias"
local KEY_GT_UNBIND_ALIAS = "key_sdk_gt_unbind_alias"
local KEY_GT_SET_TAG = "key_sdk_gt_set_tag"

function NotificationMgrNew.registerBindAliasListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_GT_BIND_ALIAS, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		if callObj ~= nil then
			callFunc(callObj, statusCode, statusDesc)
		else
			callFunc(statusCode, statusDesc)
		end
	end)
end

function NotificationMgrNew.registerUnBindAliasListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_GT_UNBIND_ALIAS, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		if callObj ~= nil then
			callFunc(callObj, statusCode, statusDesc)
		else
			callFunc(statusCode, statusDesc)
		end
	end)
end

function NotificationMgrNew.registerSetTagListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_GT_SET_TAG, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		if callObj ~= nil then
			callFunc(callObj, statusCode, statusDesc)
		else
			callFunc(statusCode, statusDesc)
		end
	end)
end

function NotificationMgrNew.isNotificationEnabled()
	return NativeBridge.instance:invokeBool(clazz, "isNotificationEnabled")
end

function NotificationMgrNew.getClientId()
	return NativeBridge.instance:invokeString(clazz, "getClientId")
end

function NotificationMgrNew.getToken()
	return NativeBridge.instance:invokeString(clazz, "getToken")
end

function NotificationMgrNew.bindAlias(alias)
	local param = {}

	param.alias = alias

	NativeBridge.instance:invoke(clazz, "bindAlias", param)
end

function NotificationMgrNew.unBindAlias(alias, isSelf)
	local param = {}

	param.alias = alias
	param.isSelf = isSelf

	NativeBridge.instance:invoke(clazz, "unBindAlias", param)
end

function NotificationMgrNew.setTag(tag)
	local param = {}

	param.tag = tag

	NativeBridge.instance:invoke(clazz, "setTag", param)
end

return NotificationMgrNew
