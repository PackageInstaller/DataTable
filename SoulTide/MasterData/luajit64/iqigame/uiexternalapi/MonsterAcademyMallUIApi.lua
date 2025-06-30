-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyMallUIApi.lua

MonsterAcademyMallUIApi = BaseLangApi:Extend()

function MonsterAcademyMallUIApi:Init()
	self:RegisterApi("goItemName", self.GetItemName)
	self:RegisterApi("goBuyTimes", self.GetBuyTimes)
	self:RegisterApi("ConditionText", self.GetConditionText)
end

function MonsterAcademyMallUIApi:GetConditionText(type, number)
	if type == 0 then
		return self:GetCfgText(3420171)
	elseif type == 1 then
		return string.format(self:GetCfgText(3420172), number)
	elseif type == 2 then
		return string.format(self:GetCfgText(3420173), number)
	elseif type == 3 then
		return string.format(self:GetCfgText(3420174), number)
	elseif type == 4 then
		return string.format(self:GetCfgText(3420175), number)
	end

	return string.format(self:GetCfgText(3420175), number)
end

function MonsterAcademyMallUIApi:GetBuyTimes(type, value)
	if type == 0 then
		return string.format(self:GetCfgText(3420176), value)
	elseif type == 1 then
		return string.format(self:GetCfgText(3420177), value)
	elseif type == 2 then
		return string.format(self:GetCfgText(3420178), value)
	elseif type == 3 then
		return string.format(self:GetCfgText(3420179), value)
	elseif type == 4 then
		return string.format(self:GetCfgText(3420180), value)
	end

	return string.format(self:GetCfgText(3420181), value)
end

function MonsterAcademyMallUIApi:GetItemName(name)
	return name
end

MonsterAcademyMallUIApi:Init()
