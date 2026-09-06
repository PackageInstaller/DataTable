-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timegate/controller/TimeGateController.lua

module("logic.extensions.timegate.controller.TimeGateController", package.seeall)

local TimeGateController = class("TimeGateController", BaseController)

function TimeGateController:ctor()
	return
end

function TimeGateController:onInit()
	return
end

function TimeGateController:getInfo()
	TimeGateAgent.instance:sendPM_TimeGateInfoReq()
end

function TimeGateController:isTimeGateTypeByActivityId(activityId)
	return ActivityDefineController.instance:isTimeGateProcessType(activityId)
end

function TimeGateController:isTimeGateTypeByChallengeId(challengeId)
	local cfg = TimeLimitedConfig.instance:getCfgById(challengeId)

	if cfg and cfg.openTimeType == 4 then
		return true
	end
end

function TimeGateController:isOpenByActivityId(activityId)
	local raceId = TimeGateConfig.instance:getRaceIdByActivityId(activityId)

	return TimeGateModel.instance:isOpenByRaceId(raceId)
end

function TimeGateController:isOpenByChallengeId(challengeId)
	local raceId = TimeGateConfig.instance:getRaceIdByChallengeId(challengeId)

	return TimeGateModel.instance:isOpenByRaceId(raceId)
end

function TimeGateController:getActTimeShow(activityId)
	return ActivityDefineController.instance:getActTimeShow(activityId)
end

function TimeGateController:tryGetPowerTipText(subTabType)
	if subTabType ~= TimeGateModel.SubTabTypeYuanqi and subTabType ~= TimeGateModel.SubTabTypeShenyao then
		return nil
	end

	local power = RoleModel.instance:getMaxPower()

	if subTabType == TimeGateModel.SubTabTypeYuanqi then
		local powerLimit = TimeGateConfig.instance:getPowerLimitYuanqi()

		if power < powerLimit then
			local wan = string.format("%.0f", powerLimit / 10000)

			return langPara("<color=#FF1D1D><size=22>源起精灵挑战难度较高，建议达到{0}万战力再来挑战哦！</size></color>", wan)
		end
	elseif subTabType == TimeGateModel.SubTabTypeShenyao then
		local powerLimit = TimeGateConfig.instance:getPowerLimitShenyao()

		if power < powerLimit then
			local wan = string.format("%.0f", powerLimit / 10000)

			return langPara("<color=#FF1D1D><size=22>神曜精灵挑战难度较高，建议达到{0}万战力再来挑战哦！</size></color>", wan)
		end
	end

	return nil
end

function TimeGateController:getActTimeShowByChallengeId(challengeId)
	local timeShowTxt = ""
	local cfgLimit = TimeLimitedConfig.instance:getCfgById(challengeId)

	if cfgLimit then
		if cfgLimit.openTimeType == 4 then
			local startTimestamp, endTimestamp = GameUtil.getStartAndEndInWeek(ServerTime.now())
			local startDate = GameUtil.time2date(startTimestamp)
			local endDate = GameUtil.time2date(endTimestamp)

			timeShowTxt = string.format("活动时间：%02d.%02d %d:%02d - %02d.%02d %d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
		else
			local startTimestamp, endTimestamp = TLChallengeController.instance:getStartAndEndTime(cfgLimit)

			timeShowTxt = ActivityDefineController.instance:getTimeDescByStamp(startTimestamp, endTimestamp)
		end
	else
		timeShowTxt = "活动时间："
	end

	return timeShowTxt
end

function TimeGateController:getActTimestampByChallengeId(challengeId)
	local startTimestamp = os.time({
		hour = 0,
		month = 1,
		year = 2024,
		min = 0,
		sec = 0,
		day = 1
	})
	local endTimestamp = os.time({
		hour = 0,
		month = 1,
		year = 2024,
		min = 0,
		sec = 0,
		day = 16
	})
	local cfgLimit = TimeLimitedConfig.instance:getCfgById(challengeId)

	if cfgLimit then
		if cfgLimit.openTimeType == 4 then
			startTimestamp, endTimestamp = GameUtil.getStartAndEndInWeek(ServerTime.now())
		else
			local startTime, endTime = TLChallengeController.instance:getStartAndEndTime(cfgLimit)

			startTimestamp = startTime
			endTimestamp = endTime
		end
	end

	return startTimestamp, endTimestamp
end

TimeGateController.instance = TimeGateController.New()

return TimeGateController
