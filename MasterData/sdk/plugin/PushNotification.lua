-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\PushNotification.lua

local PlayerPrefs = UnityEngine.PlayerPrefs
local PluginConfig = require("SDK/Plugin/PluginConfig")
local DeviceHelper = require("Helper/DeviceHelper")
local PushNotificationAgent = Framework.Plugin.PushNotificationAgent
local PluginData = PluginConfig.DATA_PUSH_NOTIFICATION_ID_KEY
local PushNotification = {}
local INVALID_PARAM = "Unknown"

PushNotification._defaultEnabled = true
PushNotification._isInited = false

function PushNotification.setStrategy(newStrategyNo)
	PushNotificationAgent.SetStrategy(newStrategyNo or 0)
end

function PushNotification.init(newStrategyNo)
	local strategyNo = newStrategyNo or 0
	local appID, appKey
	local curPluginData = PluginData[strategyNo]

	if strategyNo == PluginConfig.PUSH_NOTIFICATION_STRAT_XG then
		local platform = DeviceHelper.runtimePlatform
		local appInfo = curPluginData[platform]

		appInfo = appInfo and appInfo[IS_PUBLISH_VERSION]

		if appInfo then
			appID, appKey = appInfo[1], appInfo[2]
		end
	elseif strategyNo == PluginConfig.PUSH_NOTIFICATION_STRAT_DUMMY then
		appID, appKey = curPluginData[1], curPluginData[2]
	end

	if not appID or not appKey then
		appID, appKey = 100, "NoValidAppKeyForPushNotification"
	end

	PushNotificationAgent.Init(appID, appKey)
	PushNotification._loadSetting()

	PushNotification._isInited = true
end

function PushNotification.unbindAccount(accountId)
	PushNotificationAgent.UnbindAccount(tostring(accountId))
end

function PushNotification.bindTag(tag)
	PushNotificationAgent.BindTag(tostring(tag))
end

function PushNotification.unbindTag(tag)
	PushNotificationAgent.UnbindTag(tostring(tag))
end

function PushNotification.bindCurAccount()
	if not PushNotification._isInited then
		return
	end

	local ca = CurAvatar
	local uid = ca and ca.uid

	if uid then
		PushNotificationAgent.BindAccount(tostring(uid))
		PushNotification._setEnableSetting(true)
	end
end

function PushNotification.stopNotification()
	PushNotificationAgent.StopNotification()
	PushNotification._setEnableSetting(false)
end

function PushNotification.onRoleLogin()
	if PushNotification.isEnabled() then
		PushNotification.bindCurAccount()
	else
		PushNotification.stopNotification()
	end
end

function PushNotification._loadSetting()
	if PlayerPrefs.HasKey(Const.PUSH_NOTIFICATION_ENABLED) then
		PushNotification._enabled = PlayerPrefs.GetInt(Const.PUSH_NOTIFICATION_ENABLED) ~= 0 and true or false
	else
		PushNotification._enabled = PushNotification._defaultEnabled
	end
end

function PushNotification._saveSetting()
	PlayerPrefs.SetInt(Const.PUSH_NOTIFICATION_ENABLED, PushNotification._enabled and 1 or 0)
end

function PushNotification.setEnabled(enabled)
	if PushNotification.isEnabled() ~= enabled then
		if enabled then
			PushNotification.bindCurAccount()
		else
			PushNotification.stopNotification()
		end
	end
end

function PushNotification._setEnableSetting(enabled)
	if PushNotification.isEnabled() ~= enabled then
		PushNotification._enabled = enabled

		PushNotification._saveSetting()
	end
end

function PushNotification.isEnabled()
	if PushNotification._enabled == nil then
		PushNotification._loadSetting()
	end

	return PushNotification._enabled
end

return PushNotification
