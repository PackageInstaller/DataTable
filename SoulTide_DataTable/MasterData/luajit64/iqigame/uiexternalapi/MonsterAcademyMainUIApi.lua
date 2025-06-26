-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyMainUIApi.lua

MonsterAcademyMainUIApi = BaseLangApi:Extend()

function MonsterAcademyMainUIApi:Init()
	self:RegisterApi("TextData", self.GetTextData)
	self:RegisterApi("DateBtnLabel", self.GetDateBtnLabel)
	self:RegisterApi("TaskBtnLabel", self.GetTaskBtnLabel)
	self:RegisterApi("BagBtnLabel", self.GetBagBtnLabel)
	self:RegisterApi("MobileBtnLabel", self.GetMobileBtnLabel)
	self:RegisterApi("ReadProgressBtnLabel", self.GetReadProgressBtnLabel)
	self:RegisterApi("SaveProgressBtnLabel", self.GetSaveProgressBtnLabel)
	self:RegisterApi("TextTimeInterval", self.GetTextTimeInterval)
	self:RegisterApi("TextWeeks", self.GetTextWeeks)
	self:RegisterApi("TextGameBaseAttr", self.GetTextGameBaseAttr)
end

function MonsterAcademyMainUIApi:GetTextGameBaseAttr(attrName, num)
	if num > 0 then
		return string.format("%s + %s", attrName, num)
	end

	return string.format("%s - %s", attrName, num)
end

function MonsterAcademyMainUIApi:GetTextWeeks(week)
	local str = ""

	if week == 1 then
		str = self:GetCfgText(3420025)
	elseif week == 2 then
		str = self:GetCfgText(3420026)
	elseif week == 3 then
		str = self:GetCfgText(3420027)
	elseif week == 4 then
		str = self:GetCfgText(3420028)
	elseif week == 5 then
		str = self:GetCfgText(3420029)
	elseif week == 6 then
		str = self:GetCfgText(3420030)
	elseif week == 7 then
		str = self:GetCfgText(3420031)
	end

	return str
end

function MonsterAcademyMainUIApi:GetTextTimeInterval(num)
	if num == 1 then
		return self:GetCfgText(3420002)
	elseif num == 2 then
		return self:GetCfgText(3420003)
	elseif num == 3 then
		return self:GetCfgText(3420004)
	elseif num == 4 then
		return self:GetCfgText(3420007)
	end

	return self:GetCfgText(3420003)
end

function MonsterAcademyMainUIApi:GetSaveProgressBtnLabel()
	return self:GetCfgText(3420008)
end

function MonsterAcademyMainUIApi:GetReadProgressBtnLabel()
	return self:GetCfgText(3420009)
end

function MonsterAcademyMainUIApi:GetMobileBtnLabel()
	return self:GetCfgText(3420010)
end

function MonsterAcademyMainUIApi:GetBagBtnLabel()
	return self:GetCfgText(3420011)
end

function MonsterAcademyMainUIApi:GetTaskBtnLabel()
	return self:GetCfgText(3420012)
end

function MonsterAcademyMainUIApi:GetDateBtnLabel()
	return self:GetCfgText(3420013)
end

function MonsterAcademyMainUIApi:GetTextData(Y, M, D, Week)
	local str = ""

	if Week >= 1 and Week <= 3 then
		str = "(学)"
	elseif Week == 4 or Week == 5 then
		str = "(休)"
	end

	return string.format(self:GetCfgText(3420014) .. "%s", Y, M, D, str)
end

MonsterAcademyMainUIApi:Init()
