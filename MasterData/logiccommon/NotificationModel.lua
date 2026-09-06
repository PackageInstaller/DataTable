-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/notify/model/NotificationModel.lua

module("logiccommon.common.notify.model.NotificationModel", package.seeall)

local NotificationModel = {}

NotificationModel.notificationId = nil
NotificationModel.contentTitle = nil
NotificationModel.contentText = nil
NotificationModel.sound = nil
NotificationModel.autoCancel = nil
NotificationModel.number = nil
NotificationModel.hour = nil
NotificationModel.minute = nil
NotificationModel.isDaily = nil
NotificationModel.interval = nil
NotificationModel.isRepeat = nil
NotificationModel.dayOfWeek = nil
NotificationModel.isWeekly = nil

local function getBaseModel(notificationId, contentTitle, contentText, sound, autoCancel, number)
	local baseModel = {}

	baseModel.notificationId = notificationId
	baseModel.contentTitle = contentTitle
	baseModel.contentText = contentText
	baseModel.sound = sound or "1"
	baseModel.autoCancel = autoCancel
	baseModel.number = number or 1

	if baseModel.autoCancel == nil then
		baseModel.autoCancel = true
	end

	return baseModel
end

function NotificationModel.getDailyModel(notificationId, contentTitle, contentText, hour, minute, isDaily)
	local dailyModel = getBaseModel(notificationId, contentTitle, contentText)

	dailyModel.hour = hour
	dailyModel.minute = minute or 0
	dailyModel.isDaily = isDaily

	if dailyModel.isDaily == nil then
		dailyModel.isDaily = true
	end

	return dailyModel
end

function NotificationModel.getIntervalModel(notificationId, contentTitle, contentText, interval, isRepeat)
	local intervalModel = getBaseModel(notificationId, contentTitle, contentText)

	if Framework.OSDef.RunOS == Framework.OSDef.Android then
		intervalModel.intervalStr = tostring(interval)
	else
		intervalModel.interval = interval
	end

	intervalModel.isRepeat = isRepeat or false

	return intervalModel
end

function NotificationModel.getWeeklyModel(notificationId, contentTitle, contentText, dayOfWeek, hour, minute, isWeekly)
	local weeklyModel = getBaseModel(notificationId, contentTitle, contentText)

	weeklyModel.dayOfWeek = dayOfWeek
	weeklyModel.hour = hour
	weeklyModel.minute = minute or 0
	weeklyModel.isWeekly = isWeekly

	if weeklyModel.isWeekly == nil then
		weeklyModel.isWeekly = true
	end

	return weeklyModel
end

function NotificationModel.CopyFrom(dst, src)
	if not dst or not src then
		printWarn("NotificationModel.CopyFrom dst or src is nil!")

		return nil
	end

	dst.notificationId = src.notificationId
	dst.contentTitle = src.contentTitle
	dst.contentText = src.contentText
	dst.sound = src.sound
	dst.autoCancel = src.autoCancel
	dst.number = src.number
	dst.hour = src.hour
	dst.minute = src.minute
	dst.isDaily = src.isDaily
	dst.interval = src.interval
	dst.intervalStr = src.intervalStr
	dst.isRepeat = src.isRepeat
	dst.dayOfWeek = src.dayOfWeek
	dst.isWeekly = src.isWeekly

	return dst
end

function NotificationModel.CloneFrom(src)
	if not src then
		printWarn("NotificationModel.CloneFrom src is nil!")

		return nil
	end

	local clone = {}

	return NotificationModel.CopyFrom(clone, src)
end

return NotificationModel
