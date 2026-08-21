-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\LocalNotification.lua

local LocalNotification = {}
local PluginConfig = require("SDK/Plugin/PluginConfig")
local UserData = require("Helper/UserData")
local LocalNotificationAgent = Framework.Plugin.LocalNotificationAgent
local utils = utils

function LocalNotification.getNotificationInfo()
	local strInfo = LocalNotificationAgent.GetAllNotification()
	local infoDict

	if strInfo ~= nil then
		infoDict = ClientUtils.string2Table(strInfo)
	end

	if infoDict == nil then
		infoDict = {}
	end

	local numberDict = {}

	for i, info in pairs(infoDict) do
		if type(i) == "string" then
			local intI = tonumber(i)

			if intI ~= nil then
				numberDict[intI] = info
			end
		end
	end

	return numberDict
end

function LocalNotification.setStrategy(newStrategyNo)
	LocalNotificationAgent.SetStrategy(newStrategyNo or 0)
end

function LocalNotification.init(strategyNo)
	LocalNotificationAgent.Init()
end

function LocalNotification.isInited()
	return LocalNotificationAgent.IsInited()
end

function LocalNotification.resetStyle()
	LocalNotificationAgent.ResetStyle()
end

function LocalNotification.hideAllNotifications()
	LocalNotificationAgent.HideAllNotifications()
end

function LocalNotification.schedule(title, msg, time, repeating, repeatDelay, userInfo)
	title = title or Const.GAME_NAME_FULL
	msg = msg or Const.GAME_NAME_FULL
	time = tonumber(time) or 8
	repeating = repeating == true
	repeatDelay = repeatDelay or 0

	if VersionUtils.hasAbilityPermissionV2() then
		LocalNotificationAgent.SetIconNames("app_icon", "gn_box_1")
	else
		LocalNotificationAgent.SetIconNames("app_icon", "")
	end

	local id = -1

	if userInfo then
		id = LocalNotificationAgent.ScheduleLocalNotification(title, msg, time, repeating, repeatDelay, userInfo)
	else
		id = LocalNotificationAgent.ScheduleLocalNotification(title, msg, time, repeating, repeatDelay)
	end

	if id > 0 then
		return id
	else
		return nil
	end
end

function LocalNotification.setShowIfAppForeground(isShow)
	LocalNotificationAgent.SetShowIfAppForeground(isShow == true)
end

function LocalNotification.cancelID(id)
	LocalNotificationAgent.CancelLocalNotification(id)
end

function LocalNotification.cancelAll()
	LocalNotificationAgent.CancelAllLocalNotifications()
end

return LocalNotification
