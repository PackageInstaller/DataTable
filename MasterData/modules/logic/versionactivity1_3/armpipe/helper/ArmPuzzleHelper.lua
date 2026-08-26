-- chunkname: @modules/logic/versionactivity1_3/armpipe/helper/ArmPuzzleHelper.lua

module("modules.logic.versionactivity1_3.armpipe.helper.ArmPuzzleHelper", package.seeall)

local ArmPuzzleHelper = {}

function ArmPuzzleHelper.getLimitTimeStr()
	local actMO = ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act305)

	if actMO then
		return string.format(luaLang("activity_warmup_remain_time"), actMO:getRemainTimeStr())
	end

	return string.format(luaLang("activity_warmup_remain_time"), "0")
end

function ArmPuzzleHelper.isOpenDay(episodeId)
	local actMO = ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act305)
	local cfg = Activity124Config.instance:getEpisodeCo(VersionActivity1_3Enum.ActivityId.Act305, episodeId)
	local cdtime = 0

	if actMO and cfg then
		local openTime = actMO:getRealStartTimeStamp() + (cfg.openDay - 1) * 24 * 60 * 60
		local preIsClear = cfg.preEpisode == 0 or Activity124Model.instance:isEpisodeClear(VersionActivity1_3Enum.ActivityId.Act305, cfg.preEpisode)
		local serverTimeStamp = ServerTime.now()

		cdtime = math.max(openTime - serverTimeStamp, 0)

		if not preIsClear or cdtime > 0 then
			return false, cdtime
		end
	else
		return false, -1
	end

	return true, cdtime
end

function ArmPuzzleHelper.formatCdTime(cdTime)
	local day = Mathf.Floor(cdTime / TimeUtil.OneDaySecond)

	if day > 0 then
		return string.format("%s%s", day, luaLang("time_day"))
	end

	local hourSecond = cdTime % TimeUtil.OneDaySecond
	local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)

	if hour > 0 then
		return string.format("%s%s", hour, luaLang("time_hour"))
	end

	local minuteSecond = cdTime % TimeUtil.OneHourSecond
	local minute = Mathf.Ceil(minuteSecond / TimeUtil.OneMinuteSecond)

	return string.format("%s%s", minute, luaLang("time_minute"))
end

function ArmPuzzleHelper.formatCdLock(cdTime)
	local day = Mathf.Ceil(cdTime / TimeUtil.OneDaySecond)

	return formatLuaLang("versionactivity_1_2_119_unlock", math.max(0, day))
end

function ArmPuzzleHelper.getRotation(typeId, value)
	local dict = ArmPuzzlePipeEnum.rotate[typeId]

	return (dict and dict[value] or nil) and (dict[value][1] or 0)
end

function ArmPuzzleHelper._getRes(typeId, index, argsRes)
	local result

	if argsRes then
		local dict = argsRes[typeId]

		result = dict and dict[index]

		if not string.nilorempty(result) then
			return result, true
		end
	end

	local dict = ArmPuzzlePipeEnum.res[typeId]

	return dict and dict[index]
end

function ArmPuzzleHelper.getBackgroundRes(typeId, argsRes)
	return ArmPuzzleHelper._getRes(typeId, 1, argsRes)
end

function ArmPuzzleHelper.getConnectRes(typeId, argsRes)
	return ArmPuzzleHelper._getRes(typeId, 2, argsRes)
end

return ArmPuzzleHelper
