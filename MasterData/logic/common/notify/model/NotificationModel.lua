-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/notify/model/NotificationModel.lua

module("logic.common.notify.model.NotificationModel", package.seeall)

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

	intervalModel.interval = interval
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

return NotificationModel
