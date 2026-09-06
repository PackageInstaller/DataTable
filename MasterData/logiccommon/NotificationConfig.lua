-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/notify/config/NotificationConfig.lua

module("logiccommon.common.notify.config.NotificationConfig", package.seeall)

local NotificationConfig = class("NotificationConfig", BaseConfig)

NotificationConfig.TYPE_DAILY = 1
NotificationConfig.TYPE_INTERVAL = 2
NotificationConfig.TYPE_WEEKLY = 3
NotificationConfig.EPowerFull = 1
NotificationConfig.EFixedTime = 2
NotificationConfig.SaveFlag = "NotificationSaveFlag"

function NotificationConfig:onInit()
	NotificationConfig.super.onInit(self)
end

function NotificationConfig:getNames()
	return {
		"notify"
	}
end

function NotificationConfig:handleConfig(name, content)
	if name == "notify" then
		self._notify = content
	end
end

function NotificationConfig:getPushCfg()
	return self._notify
end

function NotificationConfig:getPushCfgById(id)
	return self._notify[id]
end

NotificationConfig.instance = NotificationConfig.New()

return NotificationConfig
