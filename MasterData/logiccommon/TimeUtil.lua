-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/util/TimeUtil.lua

module("logiccommon.common.math.TimeUtil", package.seeall)

local TimeUtil = {}
local math_floor = math.floor
local string_gsub = string.gsub

function TimeUtil:timeConvert(time, format, addZero)
	time = checknumber(time)

	if format == nil then
		format = "DD:HH:MM"
	end

	local day = 0
	local hour = 0
	local min = 0

	if time >= 86400 then
		day = math_floor(time / 86400)
		time = time % 86400
	end

	if time >= 3600 then
		hour = math_floor(time / 3600)
		time = time % 3600
	end

	if time >= 60 then
		min = math_floor(time / 60)
		time = time % 60
	end

	if time > 0 then
		min = min + 1
	end

	min = math.min(59, min)

	if addZero and min < 10 then
		min = "0" .. min
	end

	if addZero and hour < 10 then
		hour = "0" .. hour
	end

	format = string_gsub(format, "DD", day)
	format = string_gsub(format, "HH", hour)
	format = string_gsub(format, "MM", min)

	return format
end

function TimeUtil:timeConvert2(time, format, addZero)
	time = checknumber(time)

	if format == nil then
		format = "HH:MM:SS"
	end

	local hour = 0
	local min = 0
	local sce = 0

	if time >= 3600 then
		hour = math_floor(time / 3600)
		time = time % 3600
	end

	if time >= 60 then
		min = math_floor(time / 60)
		time = time % 60
	end

	sce = time

	if addZero and min < 10 then
		min = "0" .. min
	end

	if addZero and hour < 10 then
		hour = "0" .. hour
	end

	if addZero and sce < 10 then
		sce = "0" .. sce
	end

	format = string_gsub(format, "HH", hour)
	format = string_gsub(format, "MM", min)
	format = string_gsub(format, "SS", sce)

	return format
end

function TimeUtil.getLeftTime(time, isFriend)
	time = checknumber(time) / 1000

	local leftTime = ServerTime.now() - time

	if leftTime <= 0 then
		return "<1分钟"
	elseif leftTime >= 691200 then
		if isFriend then
			return "7天前"
		else
			return GameUtil.formatTimeStamp("%m月%d日", time)
		end
	elseif leftTime >= 86400 then
		return string.format("%d天前", math.floor(leftTime / 3600 / 24))
	elseif leftTime >= 3600 then
		return string.format("%d小时前", math.floor(leftTime / 3600))
	elseif leftTime >= 60 then
		return string.format("%d分钟前", math.floor(leftTime / 60))
	else
		return "<1分钟"
	end
end

function TimeUtil.getTimeFormat(leftTime)
	if leftTime <= 0 then
		return ""
	elseif leftTime >= 691200 then
		return os.date("%m %d", leftTime)
	elseif leftTime >= 86400 then
		return string.format("%d天", math.floor(leftTime / 3600 / 24))
	elseif leftTime >= 3600 then
		return string.format("%d小时", math.floor(leftTime / 3600))
	elseif leftTime >= 60 then
		return string.format("%d分钟", math.floor(leftTime / 60))
	else
		return math.ceil(leftTime) .. "秒"
	end
end

function TimeUtil.getNextMonday()
	local cur = tonumber(os.date("%w", ServerTime.now()))

	return (7 - (cur ~= 0 and cur or 7) + 1) * 86400 + ServerTime.now()
end

return TimeUtil
