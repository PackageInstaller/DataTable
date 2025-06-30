-- chunkname: @IQIGame\\UIExternalApi\\SignInUIApi.lua

SignInUIApi = BaseLangApi:Extend()

function SignInUIApi:GetDayImg(day)
	return string.format(self:GetResUrl(1100012), day)
end

function SignInUIApi:GetMonthStr(month)
	month = tonumber(month)

	if month == 1 then
		return self:GetCfgText(220001), "JANUARY"
	elseif month == 2 then
		return self:GetCfgText(220002), "FEBRUARY"
	elseif month == 3 then
		return self:GetCfgText(220003), "MARCH"
	elseif month == 4 then
		return self:GetCfgText(220004), "APRIL"
	elseif month == 5 then
		return self:GetCfgText(220005), "MAY"
	elseif month == 6 then
		return self:GetCfgText(220006), "JUNE"
	elseif month == 7 then
		return self:GetCfgText(220007), "JULY"
	elseif month == 8 then
		return self:GetCfgText(220008), "AUGUST"
	elseif month == 9 then
		return self:GetCfgText(220009), "SEPTEMBER"
	elseif month == 10 then
		return self:GetCfgText(220010), "OCTOBER"
	elseif month == 11 then
		return self:GetCfgText(220011), "NOVEMBER"
	elseif month == 12 then
		return self:GetCfgText(220012), "DECEMBER"
	end
end

function SignInUIApi:GetMonthCartResidualText(daysNum)
	return self:GetCfgText(220013) .. daysNum .. self:GetCfgText(220014)
end

function SignInUIApi:GetMonthCardByLimit()
	return self:GetCfgText(220015)
end

function SignInUIApi:GetContinueText()
	return self:GetCfgText(220016)
end
