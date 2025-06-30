-- chunkname: @IQIGame\\UIExternalApi\\MiscApi.lua

MiscApi = BaseLangApi:Extend()

function MiscApi:Init()
	self:RegisterApi("FadeDuration", self.GetComExcessiveFadeDuration)
	self:RegisterApi("DateTimeFormat", self.GetDateTimeFormat)
	self:RegisterApi("DateTimeFormatM", self.GetDateTimeFormatM)
	self:RegisterApi("DateFormat", self.GetDateFormat)
	self:RegisterApi("DateFormat_CN", self.GetDateFormat_CN)
	self:RegisterApi("TimeFormat", self.GetTimeFormat)
	self:RegisterApi("MonthFormat", self.GetMonthFormat)
	self:RegisterApi("YearFormat", self.GetYearFormat)
	self:RegisterApi("WeekFormat", self.GetWeekFormat)
	self:RegisterApi("OnlyDateFormat", self.GetOnlyDateFormat)
	self:RegisterApi("HourFormat", self.GetHourFormat)
	self:RegisterApi("HourMinuteFormat", self.GetHourMinuteFormat)
	self:RegisterApi("MonthToMinuteFormat", self.GetMonthToMinuteFormat)
	self:RegisterApi("DateFormat2", self.GetDateFormat2)
	self:RegisterApi("MonthAndDayFormat", self.GetMonthAndDayFormat)
end

function MiscApi:GetComExcessiveFadeDuration()
	return 0.17
end

function MiscApi:GetDateTimeFormat()
	return "!%Y-%m-%d %H:%M:%S"
end

function MiscApi:GetDateTimeFormatM()
	return "!%Y-%m-%d %H:%M"
end

function MiscApi:GetDateFormat()
	return "!%Y-%m-%d"
end

function MiscApi:GetDateFormat2()
	return "!%Y/%m/%d"
end

function MiscApi:GetDateFormat_CN()
	return "!%Y年%m月%d日"
end

function MiscApi:GetTimeFormat()
	return "!%H:%M:%S"
end

function MiscApi:GetYearFormat()
	return "!%Y"
end

function MiscApi:GetMonthFormat()
	return "!%m"
end

function MiscApi:GetWeekFormat()
	return "!%w"
end

function MiscApi:GetOnlyDateFormat()
	return "!%d"
end

function MiscApi:GetHourFormat()
	return "!%H"
end

function MiscApi:GetHourMinuteFormat()
	return "!%H:%M"
end

function MiscApi:GetMonthToMinuteFormat()
	return "!%m-%d %H:%M"
end

function MiscApi:GetMonthAndDayFormat()
	return "!%m-%d"
end

MiscApi:Init()
