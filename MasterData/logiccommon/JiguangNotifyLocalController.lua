-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/state/notify/JiguangNotifyLocalController.lua

module("logiccommon.common.state.notify.JiguangNotifyLocalController", package.seeall)

local JiguangNotifyLocalController = class("JiguangNotifyLocalController", BaseController)

JiguangNotifyLocalController.ReadFlag = "JiguangNotifyLocalController.ReadFlag"

function JiguangNotifyLocalController:ctor()
	return
end

function JiguangNotifyLocalController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._onStartEnterGame, self)
	JiguangNotificationMgr.registerGetClientIdListener(self._onGetClientId, self)
	JiguangNotificationMgr.registerGetAliasListener(self._onGetAllAlias, self)
	self:onReset()
end

function JiguangNotifyLocalController:onReset()
	return
end

function JiguangNotifyLocalController:_onStartEnterGame()
	if not VersionCrtl.enableJiguangNotificationPush or Framework.OSDef.isEditor then
		return
	end

	if JiguangNotificationMgr.isNotificationEnabled() == true then
		JiguangNotificationMgr.getClientId()
	elseif Framework.OSDef.RunOS == Framework.OSDef.Android and DeviceUtil.getAndroidSdkVersion() >= 33 then
		local hasCheck = GameUtil.getUserData(JiguangNotifyLocalController.ReadFlag)

		if not hasCheck then
			PermissionUtil.registerPermissionListener(function(result)
				if result == true then
					JiguangNotificationMgr.getClientId()
				end

				PermissionUtil.unregisterPermissionListener()
			end)
			PermissionUtil.requestPermission("POST_NOTIFICATIONS", "推送功能需要授予通知权限，请您前往 [设置-权限管理-奥奇传说] 中开启，感谢。")
			GameUtil.saveUserData(JiguangNotifyLocalController.ReadFlag, true)
		end
	end
end

function JiguangNotifyLocalController:_onGetClientId(statusCode, statusDesc, clientId)
	JiguangNotificationMgr.bindAlias(RoleModel.instance:getUserId())
end

function JiguangNotifyLocalController:_onGetAllAlias(statusCode, statusDesc, alias)
	if alias and #alias > 0 then
		local isBind = false

		for i, v in ipairs(alias) do
			if v == RoleModel.instance:getUserId() then
				isBind = true
			end
		end

		if not isBind then
			JiguangNotificationMgr.bindAlias(RoleModel.instance:getUserId())
		end
	end
end

JiguangNotifyLocalController.instance = JiguangNotifyLocalController.New()

return JiguangNotifyLocalController
