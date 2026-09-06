-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holiday/config/HolidayConfig.lua

module("logic.extensions.holiday.config.HolidayConfig", package.seeall)

local HolidayConfig = class("HolidayConfig", BaseConfig)

function HolidayConfig:onInit()
	HolidayConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function HolidayConfig:getNames()
	return {
		"holiday_and_workday"
	}
end

function HolidayConfig:handleConfig(name, content)
	if name == "holiday_and_workday" then
		self._cofignameCfg = content
	end
end

function HolidayConfig:getCfgById(id)
	return self._cofignameCfg[id]
end

function HolidayConfig:isHoliday()
	local nowTime = ServerTime.now()
	local nowDate = GameUtil.time2date(nowTime)

	if nowDate.wday == 6 or nowDate.wday == 7 or nowDate.wday == 1 then
		return true
	end

	for i, v in ipairs(self._cofignameCfg) do
		local startTime = os.time()
		local endTime = xxx

		if startTime <= now and endTime >= now then
			return true
		end
	end

	return false
end

HolidayConfig.instance = HolidayConfig.New()

return HolidayConfig
