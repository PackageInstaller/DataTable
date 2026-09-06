-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/state/notify/NotifyLocalController.lua

module("logiccommon.common.state.notify.NotifyLocalController", package.seeall)

local NotifyLocalController = class("NotifyLocalController", BaseController)

function NotifyLocalController:ctor()
	return
end

function NotifyLocalController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.SetPushOpen, self._setPushOpen, self)
	GlobalDispatcher:addListener(GlobalNotify.SetPushClose, self._setPushClose, self)
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._onStartEnterGame, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationResume, self._clearNotificationBar, self)
	self:onReset()
end

function NotifyLocalController:onReset()
	return
end

function NotifyLocalController:_onStartEnterGame()
	if not VersionCrtl.enableNotificationPush then
		return
	end

	self:_registerAllLocalPush()
	self:_registerNotify()

	local supplyList = SupplyConfig.instance:getDailyCfgs()

	for i, cfg in ipairs(supplyList) do
		local HHMM = string.split(cfg.startTime, ":")
		local startHour, startMin = tonumber(HHMM[1]), tonumber(HHMM[2])

		self:_setPushOpen({
			cfg.pushId
		}, startHour, startMin)
	end
end

function NotifyLocalController:_setPushOpen(pushIds, ...)
	if not VersionCrtl.enableNotificationPush then
		return
	end

	local params = {
		...
	}
	local pushCfg = NotificationConfig.instance:getPushCfg()

	for i = 1, #pushIds do
		local pushId = pushIds[i]
		local data = pushCfg[pushId]

		if data and data.isServerPush == 0 then
			if data.day == NotificationConfig.TYPE_INTERVAL then
				self:_setInterval(data, params[1])
			elseif data.day == NotificationConfig.TYPE_DAILY then
				self:_setAtTime(data, params[1], params[2])
			elseif data.day == NotificationConfig.TYPE_WEEKLY then
				-- block empty
			end
		end
	end
end

function NotifyLocalController:_setPushClose(pushIds)
	if not VersionCrtl.enableNotificationPush then
		return
	end

	for i = 1, #pushIds do
		print("removepush id   ", pushIds[i])
		NotificationMgr.removeNotification(pushIds[i])
	end
end

function NotifyLocalController:_registerAllLocalPush()
	if not VersionCrtl.enableNotificationPush then
		return
	end

	NotificationMgr.clearNotifications()

	local dataList = NotificationConfig.instance:getPushCfg().dataList
	local dailyIds = {}
	local intervalIds = {}
	local weekIds = {}

	for i = 1, #dataList do
		local data = dataList[i]
		local flag = GameUtil.getUserData(NotificationConfig.SaveFlag .. data.id)

		if flag == nil then
			flag = true

			GameUtil.saveUserData(NotificationConfig.SaveFlag .. data.id, true)
		end

		if data.isServerPush == 0 then
			if data.day == NotificationConfig.TYPE_DAILY then
				table.insert(dailyIds, data.id)
			elseif data.day == NotificationConfig.TYPE_WEEKLY then
				table.insert(weekIds, data.id)
			elseif data.type == NotificationConfig.TYPE_INTERVAL then
				table.insert(intervalIds, data.id)
			end
		end
	end

	NotificationMgr.registerNotifyIds(NotificationConfig.TYPE_DAILY, dailyIds)
	NotificationMgr.registerNotifyIds(NotificationConfig.TYPE_INTERVAL, intervalIds)
	NotificationMgr.registerNotifyIds(NotificationConfig.TYPE_WEEKLY, weekIds)
end

function NotifyLocalController:_setAtTime(co, hour, minute)
	if not VersionCrtl.enableNotificationPush then
		return
	end

	if RoleModel.instance:getMyLevel() > co.playerlv and not GameUtil.getUserData(NotificationConfig.SaveFlag .. co.id) then
		return
	end

	local intervalModel = NotificationModel.getDailyModel(co.id, co.title, co.content, hour, minute)

	NotificationMgr.notifyAtTime(intervalModel)
end

function NotifyLocalController:_setInterval(co, time)
	if not VersionCrtl.enableNotificationPush then
		return
	end

	NotificationMgr.removeNotification(co.id)

	if RoleModel.instance:getMyLevel() >= co.playerlv and not GameUtil.getUserData(NotificationConfig.SaveFlag .. co.id) and time <= 0 then
		return
	end

	local intervalModel = NotificationModel.getIntervalModel(co.id, co.title, co.content, math.ceil(tonumber(time) * 1000), false)

	NotificationMgr.registerNotifyIds(NotificationConfig.TYPE_DAILY, {
		co.id
	})
	NotificationMgr.notifyInterval(intervalModel)
end

function NotifyLocalController:_clearNotificationBar()
	NotificationMgr.clearNotificationBar()
end

function NotifyLocalController:_registerNotify()
	return
end

NotifyLocalController.instance = NotifyLocalController.New()

return NotifyLocalController
