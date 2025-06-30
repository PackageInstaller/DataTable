-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyCalendarUIApi.lua

MonsterAcademyCalendarUIApi = BaseLangApi:Extend()

function MonsterAcademyCalendarUIApi:Init()
	self:RegisterApi("LeftTitle1", self.GetLeftTitle1)
	self:RegisterApi("LeftTitle2", self.GetLeftTitle2)
	self:RegisterApi("LeftTitle3", self.GetLeftTitle3)
	self:RegisterApi("LeftTitle4", self.GetLeftTitle4)
	self:RegisterApi("WeekTxt", self.GetWeekTxt)
	self:RegisterApi("TextMsg", self.GetTextMsg)
	self:RegisterApi("DetailTitle", self.GetDetailTitle)
	self:RegisterApi("TextTripRecord", self.GetTextTripRecord)
	self:RegisterApi("AreaDatingState", self.GetAreaDatingState)
	self:RegisterApi("DayStateStr", self.GetDayStateStr)
	self:RegisterApi("DatingIconPath", self.GetDatingIconPath)
	self:RegisterApi("TextTip1", self.GetTextTip1)
	self:RegisterApi("TextTip2", self.GetTextTip2)
end

function MonsterAcademyCalendarUIApi:GetTextTip2()
	return self:GetCfgText(3420035)
end

function MonsterAcademyCalendarUIApi:GetTextTip1()
	return self:GetCfgText(3420036)
end

function MonsterAcademyCalendarUIApi:GetDatingIconPath()
	return "/Activity/MonsterAcademy/Batch1/MonsterAcademyCalendarUI/MonsterAcademyCalendar_Image_01.png"
end

function MonsterAcademyCalendarUIApi:GetDayStateStr(str, status)
	local strState = ""

	if status == 0 then
		strState = self:GetCfgText(3420021)
	elseif status == 1 then
		strState = self:GetCfgText(3420022)
	elseif status == 2 then
		strState = self:GetCfgText(3420023)
	end

	return string.format("%s\n%s", str, strState)
end

function MonsterAcademyCalendarUIApi:GetAreaDatingState(status)
	if status == 0 then
		return self:GetCfgText(3420021)
	elseif status == 1 then
		return self:GetCfgText(3420022)
	elseif status == 2 then
		return self:GetCfgText(3420023)
	end

	return ""
end

function MonsterAcademyCalendarUIApi:GetTextTripRecord()
	return self:GetCfgText(3420024)
end

function MonsterAcademyCalendarUIApi:GetDetailTitle()
	return self:GetCfgText(3420024)
end

function MonsterAcademyCalendarUIApi:GetTextMsg(timeStr, timeState, name, something, areaStr, state)
	local timeStateStr = self:GetLeftTitle4(timeState)
	local stateStr = self:GetAreaDatingState(state)

	return string.format(self:GetCfgText(3420034), timeStr, name, areaStr, stateStr)
end

function MonsterAcademyCalendarUIApi:GetWeekTxt(week)
	if week == 1 then
		return self:GetCfgText(3420025)
	elseif week == 2 then
		return self:GetCfgText(3420026)
	elseif week == 3 then
		return self:GetCfgText(3420027)
	elseif week == 4 then
		return self:GetCfgText(3420028)
	elseif week == 5 then
		return self:GetCfgText(3420029)
	elseif week == 6 then
		return self:GetCfgText(3420030)
	elseif week == 7 then
		return self:GetCfgText(3420031)
	end

	return ""
end

function MonsterAcademyCalendarUIApi:GetLeftTitle4(state)
	if state == 1 then
		return self:GetCfgText(3420002)
	elseif state == 2 then
		return self:GetCfgText(3420003)
	elseif state == 3 then
		return self:GetCfgText(3420004)
	elseif state == 4 then
		return self:GetCfgText(3420007)
	end

	return ""
end

function MonsterAcademyCalendarUIApi:GetLeftTitle3(index)
	if index == 1 then
		return self:GetCfgText(3420025)
	elseif index == 2 then
		return self:GetCfgText(3420026)
	elseif index == 3 then
		return self:GetCfgText(3420027)
	elseif index == 4 then
		return self:GetCfgText(3420028)
	elseif index == 5 then
		return self:GetCfgText(3420029)
	elseif index == 6 then
		return self:GetCfgText(3420030)
	end

	return self:GetCfgText(3420031)
end

function MonsterAcademyCalendarUIApi:GetLeftTitle2(top)
	if top then
		return self:GetCfgText(3420032)
	end

	return self:GetCfgText(3420033)
end

function MonsterAcademyCalendarUIApi:GetLeftTitle1(year, month, day)
	return string.format(self:GetCfgText(3420014), year, month, day)
end

MonsterAcademyCalendarUIApi:Init()
