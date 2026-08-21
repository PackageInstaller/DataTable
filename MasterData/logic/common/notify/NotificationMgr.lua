-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/notify/NotificationMgr.lua

module("logic.common.notify.NotificationMgr", package.seeall)

local clazz = "com.baitian.getui.library.NotificationGTPushWrap"
local NotificationMgr = {}
local KEY_GT_BIND_ALIAS = "key_sdk_gt_bind_alias"
local KEY_GT_UNBIND_ALIAS = "key_sdk_gt_unbind_alias"
local KEY_GT_SET_TAG = "key_sdk_gt_set_tag"

function NotificationMgr.registerBindAliasListener(callFunc, callObj)
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

function NotificationMgr.registerUnBindAliasListener(callFunc, callObj)
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

function NotificationMgr.registerSetTagListener(callFunc, callObj)
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

function NotificationMgr.isNotificationEnabled()
	return NativeBridge.instance:invokeBool(clazz, "isNotificationEnabled")
end

function NotificationMgr.getClientId()
	return NativeBridge.instance:invokeString(clazz, "getClientId")
end

function NotificationMgr.getToken()
	return NativeBridge.instance:invokeString(clazz, "getToken")
end

function NotificationMgr.bindAlias(alias)
	local param = {}

	param.alias = alias

	NativeBridge.instance:invoke(clazz, "bindAlias", param)
end

function NotificationMgr.unBindAlias(alias, isSelf)
	local param = {}

	param.alias = alias
	param.isSelf = isSelf

	NativeBridge.instance:invoke(clazz, "unBindAlias", param)
end

function NotificationMgr.setTag(tag)
	local param = {}

	param.tag = tag

	NativeBridge.instance:invoke(clazz, "setTag", param)
end

function NotificationMgr.clearNotificationBar()
	local param = {}

	NativeBridge.instance:invoke(clazz, "clearNotificationBar", param)
end

return NotificationMgr
