-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/sdk/NotificationMgr.lua

module("logiccommon.common.sdk.NotificationMgr", package.seeall)

local NotificationMgr = {}
local clazz = "com.baitian.wrap.NotificationLocalWrap"

function NotificationMgr.setUserId(userId)
	local param = {}

	param.userId = userId

	NativeBridge.instance:invokeString(clazz, "setUserId", param)
end

function NotificationMgr.registerNotifyIds(notificationType, notifyIds)
	local param = {}

	param.notificationType = notificationType

	local tab = notifyIds or {}

	param.notifyIds = table.concat(tab, "#")

	NativeBridge.instance:invoke(clazz, "initNotificationInfo", param)
end

function NotificationMgr.clearNotifications()
	NativeBridge.instance:invoke(clazz, "clearNotifications")
end

function NotificationMgr.removeNotification(notificationId)
	local param = {}

	param.notificationId = notificationId

	NativeBridge.instance:invoke(clazz, "removeNotification", param)
end

function NotificationMgr.notifyAtTime(notificationModel)
	NativeBridge.instance:invoke(clazz, "notifyAtTime", notificationModel)
end

function NotificationMgr.notifyInterval(notificationModel)
	NativeBridge.instance:invoke(clazz, "notifyInterval", notificationModel)
end

function NotificationMgr.notifyWeekly(notificationModel)
	NativeBridge.instance:invoke(clazz, "notifyWeekly", notificationModel)
end

function NotificationMgr.setNotificationOpen(notificationId, isOpen)
	local param = {}

	param.notificationId = notificationId
	param.isOpen = isOpen

	NativeBridge.instance:invoke(clazz, "setNotificationOpen", param)
end

function NotificationMgr.isNotificationEnabled()
	return NativeBridge.instance:invokeBool(clazz, "isNotificationEnabled")
end

function NotificationMgr.goToNotificationSetting()
	NativeBridge.instance:invoke(clazz, "goToNotificationSetting")
end

function NotificationMgr.clearNotificationBar()
	NativeBridge.instance:invoke(clazz, "clearNotificationBar")
end

function NotificationMgr.getToken()
	return NativeBridge.instance:invokeString(clazz, "getToken")
end

function NotificationMgr.setTag(tag)
	local param = {}

	param.tag = tag

	NativeBridge.instance:invoke(clazz, "setTag", param)
end

function NotificationMgr.setAlias(alias)
	local param = {}

	param.alias = alias

	NativeBridge.instance:invoke(clazz, "setAlias", param)
end

function NotificationMgr:notifyIntervalBatch(modelArray)
	local param = {}

	param.models = modelArray

	NativeBridge.instance:invoke(clazz, "notifyIntervalBatch", param)
end

function NotificationMgr:getIntervalModelArray()
	local modelArray = {}

	for idx = 1, 5 do
		local oneModel = {}

		oneModel.notificationId = idx
		oneModel.contentTitle = "title" .. idx
		oneModel.contentText = "content" .. idx
		oneModel.intervalStr = tostring(idx * 1000)

		table.insert(modelArray, oneModel)
	end

	return modelArray
end

return NotificationMgr
