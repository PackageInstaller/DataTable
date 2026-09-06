-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holidaygift/config/HolidayGiftConfig.lua

module("logic.extensions.holidaygift.config.HolidayGiftConfig", package.seeall)

local HolidayGiftConfig = class("HolidayGiftConfig", BaseConfig)

function HolidayGiftConfig:onInit()
	HolidayGiftConfig.super.onInit(self)

	self._holiday_gift = nil
	self._holiday_gift_prize = nil
end

function HolidayGiftConfig:getNames()
	return {
		"holiday_gift",
		"holiday_gift_prize"
	}
end

function HolidayGiftConfig:handleConfig(name, content)
	if name == "holiday_gift" then
		self._holiday_gift = content
	elseif name == "holiday_gift_prize" then
		self._holiday_gift_prize = content
	end
end

function HolidayGiftConfig:getActConfig(activityId)
	return self._holiday_gift[activityId]
end

function HolidayGiftConfig:getPrizeConfigs(planId)
	return self._holiday_gift_prize[planId]
end

HolidayGiftConfig.instance = HolidayGiftConfig.New()

return HolidayGiftConfig
