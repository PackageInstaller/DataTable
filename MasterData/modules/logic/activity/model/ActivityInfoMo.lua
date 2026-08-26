-- chunkname: @modules/logic/activity/model/ActivityInfoMo.lua

module("modules.logic.activity.model.ActivityInfoMo", package.seeall)

local ActivityInfoMo = pureTable("ActivityInfoMo")

function ActivityInfoMo:ctor()
	self.id = 0
	self.actType = 0
	self.centerId = 0
	self.startTime = 0
	self.endTime = 0
	self.online = false
	self.isNewStage = false
	self.permanentUnlock = false
	self.isReceiveAllBonus = false
end

function ActivityInfoMo:init(info)
	self.id = info.id
	self.actType = ActivityConfig.instance:getActivityCo(info.id).typeId
	self.centerId = ActivityConfig.instance:getActivityCo(info.id).showCenter
	self.startTime = tonumber(info.startTime)
	self.endTime = tonumber(info.endTime)
	self.online = info.online
	self.isNewStage = info.isNewStage
	self.currentStage = info.currentStage
	self.permanentUnlock = info.isUnlock
	self.isReceiveAllBonus = info.isReceiveAllBonus
	self.config = ActivityConfig.instance:getActivityCo(self.id)
end

function ActivityInfoMo:getRealStartTimeStamp()
	return self.startTime / 1000
end

function ActivityInfoMo:getRealEndTimeStamp()
	return self.endTime / 1000
end

function ActivityInfoMo:isUnlock()
	if self.config then
		if self.config and self.config ~= 0 and not OpenModel.instance:isFunctionUnlock(self.config) then
			return false
		end

		return true
	end
end

function ActivityInfoMo:isOnline()
	return self.online
end

function ActivityInfoMo:isNewStageOpen()
	return self.isNewStage
end

function ActivityInfoMo:getCurrentStage()
	return self.currentStage
end

function ActivityInfoMo:isOpen()
	return ServerTime.now() - self:getRealStartTimeStamp() >= 0
end

function ActivityInfoMo:isExpired()
	return self:getRealEndTimeStamp() - ServerTime.now() <= 0
end

function ActivityInfoMo:getStartTimeStr()
	return os.date("%m/%d", self:getRealStartTimeStamp())
end

function ActivityInfoMo:getStartTimeStr1()
	return os.date("%m/%d       %H:%M", self:getRealStartTimeStamp())
end

function ActivityInfoMo:getEndTimeStr()
	return os.date("%m/%d", self:getRealEndTimeStamp())
end

function ActivityInfoMo:getEndTimeStr1()
	return os.date("%m/%d       %H:%M", self:getRealEndTimeStamp())
end

function ActivityInfoMo:getRemainTimeStr(useEn)
	local offsetSecond = self:getRealEndTimeStamp() - ServerTime.now()
	local date, dateFormat = TimeUtil.secondToRoughTime(offsetSecond, useEn)

	return date .. dateFormat
end

function ActivityInfoMo:getRemainTimeStr2(offsetSecond, useEn)
	if useEn then
		if not TimeUtil.DateEnFormat.Day then
			local daySuffix = luaLang("time_day")

			if useEn then
				if not TimeUtil.DateEnFormat.Hour then
					local hourSuffix = luaLang("time_hour2")

					if useEn then
						if not TimeUtil.DateEnFormat.Minute then
							local minuteSuffix = luaLang("time_minute2")

							if not offsetSecond or offsetSecond <= 0 then
								return 0 .. minuteSuffix
							end

							offsetSecond = math.floor(offsetSecond)

							local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)

							if day > 0 then
								return day .. daySuffix
							end

							local hourSecond = offsetSecond % TimeUtil.OneDaySecond
							local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)

							if hour > 0 then
								return hour .. hourSuffix
							end

							local minuteSecond = hourSecond % TimeUtil.OneHourSecond
							local minute = Mathf.Floor(minuteSecond / TimeUtil.OneMinuteSecond)

							if minute <= 0 then
								minute = "<1"
							end

							return minute .. minuteSuffix
						end
					end
				end
			end
		end
	end
end

function ActivityInfoMo:getRemainTimeStr3(useEn, hourMinute)
	if useEn then
		if not TimeUtil.DateEnFormat.Day then
			local daySuffix = luaLang("time_day")

			if useEn then
				if not TimeUtil.DateEnFormat.Hour then
					local hourSuffix = luaLang("time_hour2")

					if useEn then
						if not TimeUtil.DateEnFormat.Minute then
							local minuteSuffix = luaLang("time_minute2")
							local offsetSecond = self:getRealEndTimeStamp() - ServerTime.now()

							if not offsetSecond or offsetSecond <= 0 then
								local endDateStr = hourMinute and string.format("%s%s%s%s", 0, hourSuffix, 0, minuteSuffix) or string.format("%s%s", 0, minuteSuffix)

								return endDateStr, true
							end

							local resultDateStr = ""
							local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
							local hourSecond = offsetSecond % TimeUtil.OneDaySecond
							local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)
							local minuteSecond = hourSecond % TimeUtil.OneHourSecond
							local minute = Mathf.Floor(minuteSecond / TimeUtil.OneMinuteSecond)

							if day > 0 then
								resultDateStr = string.format("%s%s%s%s", day, daySuffix, hour, hourSuffix)
							elseif hourMinute then
								resultDateStr = string.format("%s%s%s%s", hour, hourSuffix, minute, minuteSuffix)
							elseif hour > 0 then
								resultDateStr = string.format("%s%s", hour, hourSuffix)
							else
								if minute <= 0 then
									minute = "<1"
								end

								resultDateStr = string.format("%s%s", minute, minuteSuffix)
							end

							return resultDateStr, false
						end
					end
				end
			end
		end
	end
end

function ActivityInfoMo:getRemainTimeStr4(offsetSecond)
	if not offsetSecond or offsetSecond <= 0 then
		return
	end

	offsetSecond = math.floor(offsetSecond)

	local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
	local hourSecond = offsetSecond % TimeUtil.OneDaySecond
	local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)

	if day > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			day,
			hour
		})
	end

	if hour > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("hour_num"), {
			hour
		})
	end

	local minuteSecond = hourSecond % TimeUtil.OneHourSecond
	local minute = Mathf.Ceil(minuteSecond / TimeUtil.OneMinuteSecond)

	if minute == 59 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("hour_num"), {
			1
		})
	else
		return GameUtil.getSubPlaceholderLuaLang(luaLang("minute_num"), {
			minute
		})
	end
end

function ActivityInfoMo:getRemainTimeStr2ByOpenTime()
	return self:getRemainTimeStr2(self:getRealStartTimeStamp() - ServerTime.now())
end

function ActivityInfoMo:getRemainTimeStr2ByEndTime(useEn)
	return self:getRemainTimeStr2(self:getRealEndTimeStamp() - ServerTime.now(), useEn)
end

function ActivityInfoMo:getRemainTime(useEnDateFormat)
	local offsetSecond = self:getRealEndTimeStamp() - ServerTime.now()
	local date, dateFormat = TimeUtil.secondToRoughTime(offsetSecond, useEnDateFormat)

	return date, dateFormat
end

function ActivityInfoMo:getRemainDay()
	local offsetSecond = self:getRealEndTimeStamp() - ServerTime.now()

	return TimeUtil.secondsToDDHHMMSS(offsetSecond)
end

function ActivityInfoMo:getRemainOpeningDay()
	local offsetSecond = self:getRealStartTimeStamp() - ServerTime.now()

	return TimeUtil.secondsToDDHHMMSS(offsetSecond)
end

function ActivityInfoMo:getOpeningDay()
	local offsetSecond = ServerTime.now() - self:getRealStartTimeStamp()

	return TimeUtil.secondsToDDHHMMSS(offsetSecond)
end

function ActivityInfoMo:isPermanentUnlock()
	return self.permanentUnlock
end

function ActivityInfoMo:setPermanentUnlock()
	self.permanentUnlock = true
end

return ActivityInfoMo
