-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/sdk/JiguangNotificationMgr.lua

module("logiccommon.common.sdk.JiguangNotificationMgr", package.seeall)

local JiguangNotificationMgr = class("JiguangNotificationMgr")
local clazz = "com.btgame.sdk.push.jiguang.JiguangPushWrap"
local KEY_GET_CLIENT_ID = "key_sdk_get_client_id"
local KEY_SET_ALIAS = "key_sdk_set_alias"
local KEY_DELETE_ALIAS = "key_sdk_delete_alias"
local KEY_GET_ALL_ALIAS = "key_sdk_get_alias"
local KEY_ADD_TAG = "key_sdk_add_tag"
local KEY_DELETE_TAG = "key_sdk_delete_tag"
local KEY_CLEAN_TAG = "key_sdk_clean_tag"
local KEY_GET_ALL_TAG = "key_sdk_get_all_tag"
local KEY_CHECK_BING_TAG = "key_sdk_check_tag_bind"

function JiguangNotificationMgr.registerGetClientIdListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_GET_CLIENT_ID, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc
		local clientId = result.clientId

		if callObj ~= nil then
			callFunc(callObj, statusCode, statusDesc, clientId)
		else
			callFunc(statusCode, statusDesc, clientId)
		end
	end)
end

function JiguangNotificationMgr.registerBindAliasListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_SET_ALIAS, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		if callObj ~= nil then
			callFunc(callObj, statusCode, statusDesc)
		else
			callFunc(statusCode, statusDesc)
		end
	end)
end

function JiguangNotificationMgr.registerUnBindAliasListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_DELETE_ALIAS, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		if callObj ~= nil then
			callFunc(callObj, statusCode, statusDesc)
		else
			callFunc(statusCode, statusDesc)
		end
	end)
end

function JiguangNotificationMgr.registerGetAliasListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_GET_ALL_ALIAS, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc
		local alias = result.alias

		if callObj ~= nil then
			callFunc(callObj, statusCode, statusDesc, alias)
		else
			callFunc(statusCode, statusDesc, alias)
		end
	end)
end

function JiguangNotificationMgr.registerSetTagListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_ADD_TAG, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		if callObj ~= nil then
			callFunc(callObj, statusCode, statusDesc)
		else
			callFunc(statusCode, statusDesc)
		end
	end)
end

function JiguangNotificationMgr.registerDeleteTagListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_DELETE_TAG, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		if callObj ~= nil then
			callFunc(callObj, statusCode, statusDesc)
		else
			callFunc(statusCode, statusDesc)
		end
	end)
end

function JiguangNotificationMgr.registerCleanTagListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_CLEAN_TAG, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		if callObj ~= nil then
			callFunc(callObj, statusCode, statusDesc)
		else
			callFunc(statusCode, statusDesc)
		end
	end)
end

function JiguangNotificationMgr.registerGetAllTagListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_GET_ALL_TAG, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		if callObj ~= nil then
			callFunc(callObj, statusCode, statusDesc)
		else
			callFunc(statusCode, statusDesc)
		end
	end)
end

function JiguangNotificationMgr.registerCheckBindTagListener(callFunc, callObj)
	NativeBridge.instance:registerListener(KEY_CHECK_BING_TAG, function(result)
		local statusCode = result.statusCode
		local statusDesc = result.statusDesc

		if callObj ~= nil then
			callFunc(callObj, statusCode, statusDesc)
		else
			callFunc(statusCode, statusDesc)
		end
	end)
end

function JiguangNotificationMgr.isNotificationEnabled()
	return NativeBridge.instance:invokeBool(clazz, "isNotificationEnabled")
end

function JiguangNotificationMgr.getClientId()
	NativeBridge.instance:invoke(clazz, "getClientId")
end

function JiguangNotificationMgr.getToken()
	return NativeBridge.instance:invokeString(clazz, "getToken")
end

function JiguangNotificationMgr.goToNotificationSetting()
	local param = {}

	NativeBridge.instance:invoke(clazz, "goToNotificationSetting", param)
end

function JiguangNotificationMgr.clearNotificationBar()
	NativeBridge.instance:invoke(clazz, "clearNotificationBar")
end

function JiguangNotificationMgr.bindAlias(alias)
	local param = {}

	param.alias = alias

	NativeBridge.instance:invoke(clazz, "bindAlias", param)
end

function JiguangNotificationMgr.unBindAlias()
	local param = {}

	NativeBridge.instance:invoke(clazz, "unBindAlias", param)
end

function JiguangNotificationMgr.getAlias()
	NativeBridge.instance:invoke(clazz, "getAlias")
end

function JiguangNotificationMgr.setTag(tag)
	local param = {}

	param.tag = tag

	NativeBridge.instance:invoke(clazz, "setTag", param)
end

function JiguangNotificationMgr.deleteTag(tag)
	local param = {}

	param.tag = tag

	NativeBridge.instance:invoke(clazz, "deleteTag", param)
end

function JiguangNotificationMgr.cleanTag()
	local param = {}

	NativeBridge.instance:invoke(clazz, "cleanTag", param)
end

function JiguangNotificationMgr.getAllTag()
	local param = {}

	NativeBridge.instance:invoke(clazz, "getAllTag", param)
end

function JiguangNotificationMgr.checkTagBindState()
	local param = {}

	param.tag = tag

	NativeBridge.instance:invoke(clazz, "checkTagBindState", param)
end

function JiguangNotificationMgr.init()
	local param = {}

	NativeBridge.instance:invoke(clazz, "init", param)
end

return JiguangNotificationMgr
