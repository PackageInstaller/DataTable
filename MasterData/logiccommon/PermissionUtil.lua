-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/sdk/PermissionUtil.lua

module("logiccommon.common.sdk.PermissionUtil", package.seeall)

local PermissionUtil = class("PermissionUtil")
local clazz = "com.baitian.wrap.PermissionUtilWrap"

function PermissionUtil.checkPermission(permission)
	local param = {}

	param.permission = permission

	return NativeBridge.instance:invokeBool(clazz, "checkPermission", param)
end

function PermissionUtil.requestPermission(permission, rational)
	local param = {}

	param.permission = permission
	param.rational = rational
	param.alwaysShowRationale = true

	NativeBridge.instance:invoke(clazz, "requestPermission", param)
end

function PermissionUtil.openPermissionSettings()
	NativeBridge.instance:invoke(clazz, "openPermissionSettings")
end

function PermissionUtil.registerPermissionListener(callFunc)
	NativeBridge.instance:registerListener("key_permission_result", function(result)
		callFunc(result)
	end)
end

function PermissionUtil.unregisterPermissionListener()
	NativeBridge.instance:unregisterListener("key_permission_result")
end

return PermissionUtil
