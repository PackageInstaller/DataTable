-- chunkname: @IQIGame\\UIExternalApi\\ActivityPassApi.lua

ActivityPassApi = BaseLangApi:Extend()

function ActivityPassApi:GetTaskDesc(Desc, ScheduleCur, ScheduleMax)
	local str = Desc

	str = str .. "   "
	str = str .. ScheduleCur .. "/" .. ScheduleMax

	return str
end

function ActivityPassApi:GetTaskName(Name)
	return Name
end

function ActivityPassApi:GetTaskExp(num)
	local str = self:GetCfgText(7050026) .. num

	return str
end

function ActivityPassApi:GetPassExp(cur, max)
	local str = cur .. " / " .. max

	return str
end

function ActivityPassApi:GetPassLevel(lv)
	local str = self:GetCfgText(7050027) .. lv

	return str
end

function ActivityPassApi:GetLevel(lv)
	local str = lv .. self:GetCfgText(7050028)

	return str
end

function ActivityPassApi:GetBuyLevelTip(lv)
	local str = self:GetCfgText(7050029) .. lv .. self:GetCfgText(7050030)

	return str
end

function ActivityPassApi:GetWeekenExp(cur, max)
	local str = self:GetCfgText(7050031) .. cur .. " / " .. max

	return str
end

function ActivityPassApi:GetResidueTime(time)
	if time >= 86400 then
		return self:GetTimeDurationText(time, 2)
	elseif time <= 0 then
		return "0分"
	else
		return self:GetTimeDurationText(time, 3)
	end

	return str
end

function ActivityPassApi:GetExtra()
	return self:GetCfgText(7050032)
end

function ActivityPassApi:NotingCanGet()
	return self:GetCfgText(7050033)
end

function ActivityPassApi:ActivityIsOver()
	return self:GetCfgText(7050034)
end

function ActivityPassApi:GetUnlockHighPass()
	return self:GetCfgText(7050035)
end

function ActivityPassApi:GetUpgradeSuperPass()
	return self:GetCfgText(7050036)
end

function ActivityPassApi:SuperPassMoreAward()
	return self:GetCfgText(7050037)
end

function ActivityPassApi:GetActivityPassText(isSelect)
	if isSelect then
		return self.TextColor[4] .. self:GetCfgText(7050038) .. self.TextColor[0]
	else
		return self.TextColor[4] .. self:GetCfgText(7050038) .. self.TextColor[0]
	end
end

function ActivityPassApi:GetActivityTaskText(isSelect)
	if isSelect then
		return self.TextColor[4] .. self:GetCfgText(7050039) .. self.TextColor[0]
	else
		return self.TextColor[4] .. self:GetCfgText(7050039) .. self.TextColor[0]
	end
end

function ActivityPassApi:GetActivationText()
	return self:GetCfgText(7050040)
end
