-- chunkname: @IQIGame\\UIExternalApi\\ActiveRookieUIApi.lua

ActiveRookieUIApi = BaseLangApi:Extend()

function ActiveRookieUIApi:Init()
	self:RegisterApi("tabName", self.GetTabName)
	self:RegisterApi("tabIconPath", self.GetTabIconPath)
	self:RegisterApi("btnClose", self.GetBtnCloseTxt)
	self:RegisterApi("taskName", self.GetTaskName)
	self:RegisterApi("taskProgress", self.GetTaskProgress)
	self:RegisterApi("btnGetTxt", self.GetBtnGetTxt)
	self:RegisterApi("btnGoTxt", self.GetBtnGoTxt)
	self:RegisterApi("btnSignGettedTxt", self.GetSignGettedTxt)
	self:RegisterApi("day3Tip1", self.GetDay3Tip1)
	self:RegisterApi("day3Tip2", self.GetDay3Tip2)
	self:RegisterApi("day8Tip1", self.GetDay8Tip1)
	self:RegisterApi("day8Tip2", self.GetDay8Tip2)
	self:RegisterApi("specialDays", self.GetSpecialDays)
	self:RegisterApi("dayDesc", self.GetDayDesc)
	self:RegisterApi("stateDesc", self.GetStateDesc)
	self:RegisterApi("progressList", self.GetProgressList)
end

function ActiveRookieUIApi:GetSpecialDays()
	return {
		3,
		4,
		8
	}
end

function ActiveRookieUIApi:GetProgressList()
	return {
		0.21,
		0.33,
		0.445,
		0.567,
		0.683,
		0.8,
		0.92,
		1
	}
end

function ActiveRookieUIApi:GetStateDesc(state)
	if state == 1 then
		return ""
	elseif state == 2 then
		return "." .. self:GetCfgText(1245001) .. "."
	else
		return self:GetCfgText(1245002)
	end
end

function ActiveRookieUIApi:GetDayDesc(day, state, isSpecialDay)
	if state == 2 then
		return self:GetCfgText(1245003) .. self.TextColor[1000] .. "<size=60>" .. tostring(day) .. "</size>" .. self.TextColor[0] .. self:GetCfgText(1245004)
	elseif isSpecialDay then
		return self.TextColor[1001] .. self:GetCfgText(1245003) .. "<size=60>" .. tostring(day) .. "</size>" .. self:GetCfgText(1245004) .. self.TextColor[0]
	else
		return self:GetCfgText(1245003) .. "<size=60>" .. tostring(day) .. "</size>" .. self:GetCfgText(1245004)
	end
end

function ActiveRookieUIApi:GetDay3Tip1()
	return self:GetCfgText(1245005)
end

function ActiveRookieUIApi:GetDay3Tip2()
	return self:GetCfgText(1245006)
end

function ActiveRookieUIApi:GetDay8Tip1()
	return self:GetCfgText(1245007)
end

function ActiveRookieUIApi:GetDay8Tip2()
	return self:GetCfgText(1245008)
end

function ActiveRookieUIApi:GetBtnGoTxt()
	return self:GetCfgText(1245009)
end

function ActiveRookieUIApi:GetSignGettedTxt()
	return self:GetCfgText(1245010)
end

function ActiveRookieUIApi:GetBtnGetTxt()
	return self:GetCfgText(1245011)
end

function ActiveRookieUIApi:GetTaskName(name)
	return name
end

function ActiveRookieUIApi:GetTaskProgress(cur, total)
	if total <= cur then
		return cur .. "/" .. total
	else
		return cur .. "/" .. total
	end
end

function ActiveRookieUIApi:GetTabName(index)
	if index == 1 then
		return self:GetCfgText(1245012)
	elseif index == 2 then
		return self:GetCfgText(1245013)
	elseif index == 3 then
		return self:GetCfgText(1245014)
	elseif index == 4 then
		return self:GetCfgText(1245015)
	elseif index == 5 then
		return self:GetCfgText(1245016)
	elseif index == 6 then
		return self:GetCfgText(1245017)
	elseif index == 7 then
		return self:GetCfgText(1245019)
	elseif index == 8 then
		return self:GetCfgText(1245020)
	else
		return ""
	end
end

function ActiveRookieUIApi:GetTabIconPath(index)
	if index == 1 then
		return self:GetResUrl(1701001)
	elseif index == 2 then
		return self:GetResUrl(1701002)
	elseif index == 3 then
		return self:GetResUrl(1701003)
	elseif index == 4 then
		return self:GetResUrl(1701004)
	elseif index == 5 then
		return self:GetResUrl(1701005)
	elseif index == 6 then
		return self:GetResUrl(1701006)
	elseif index == 7 then
		return self:GetResUrl(1701007)
	elseif index == 8 then
		return self:GetResUrl(1701008)
	else
		return self:GetResUrl(1701008)
	end
end

function ActiveRookieUIApi:GetBtnCloseTxt()
	return self:GetCfgText(1245018)
end

ActiveRookieUIApi:Init()
