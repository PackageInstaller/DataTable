-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\NotificationManager.lua

local LocalNotification = require("SDK/Plugin/LocalNotification")
local UserData = require("Helper/UserData")
local ResInfoNotice = require("ClientData/ResInfoNotice")
local SDKConst = require("SDK/SDKConst")
local AttName = SDKConst.AttName
local NotificationManager = {}
local self = NotificationManager
local Const = Const
local SEC_IN_HOUR = 3600
local SEC_IN_DAY = 24 * SEC_IN_HOUR

self.POLL_INTERVAL = 900
self.HOUR_DELAY = 12
self.HOUR_TOO_EARLY = 8
self.HOUR_TOO_LATE = 21

function NotificationManager.init()
	if self._timerRefresh == nil then
		self._timerRefresh = Timer.New(Slot(self._refreshNotification, true), self.POLL_INTERVAL, -1)
	end
end

function NotificationManager.destroy()
	NotificationManager._refreshNotification()
end

function NotificationManager.setStyle(style)
	if style == 0 then
		LocalNotification.resetStyle()
	end
end

function NotificationManager._refreshNotification()
	self.cancelAll()

	if RegionUtils.isKR() then
		local PushSettingPanel = require("UI/MainMenu/PushSettingPanel")

		if PushSettingPanel:getPushEnable(3) then
			if PushSettingPanel:getPushEnable(4) then
				self.scheduleNewMsg(self.HOUR_DELAY, self.HOUR_TOO_EARLY)
			else
				self.scheduleNewMsg(self.HOUR_DELAY, self.HOUR_TOO_EARLY, self.HOUR_TOO_LATE)
			end
		else
			NotificationManager.cancelAll()
		end
	else
		self.scheduleNewMsg(self.HOUR_DELAY, self.HOUR_TOO_EARLY)
	end
end

function NotificationManager.cancelAll()
	LocalNotification.cancelAll()
end

function NotificationManager.scheduleNewMsg(delayHour, tooEarlyHour, tooLaterHour)
	local info = ResInfoNotice[69]
	local title = info and info.title or Lang.get(29995)
	local msg = info and info.content or Lang.get(29996)
	local delay = delayHour * SEC_IN_HOUR
	local localDate = os.date("*t")
	local ringHour = (localDate.hour + delayHour) % 24

	tooLaterHour = tooLaterHour or self.HOUR_TOO_LATE

	if ringHour < tooEarlyHour then
		delay = delay + (tooEarlyHour - ringHour - 1) * SEC_IN_HOUR + (60 - localDate.min) * 60 + (60 - localDate.sec)
	end

	if tooLaterHour < ringHour then
		delay = delay + (32 - ringHour - 1) * SEC_IN_HOUR + (60 - localDate.min) * 60 + (60 - localDate.sec)
	end

	delay = math.floor(delay)

	LocalNotification.schedule(title, msg, delay)
end

function NotificationManager.onAccountLogin()
	self._tryEnableNotification()
	self._timerRefresh:Restart()
	self._refreshNotification()
end

function NotificationManager.onRoleCreate()
	return
end

function NotificationManager.onRoleLogin()
	return
end

function NotificationManager.onRoleLevelUp(newLv)
	return
end

function NotificationManager.onPause()
	return
end

function NotificationManager.onResume()
	return
end

function NotificationManager._tryEnableNotification()
	if UserData.loadCommonData(Const.UD_KEY_NOTI_PERMISSION_REQUESTED) ~= "1" then
		UserData.saveCommonData(Const.UD_KEY_NOTI_PERMISSION_REQUESTED, "1")
		Framework.Plugin.PermissionManager.CheckNotificationEnabled()
	end
end

return NotificationManager
