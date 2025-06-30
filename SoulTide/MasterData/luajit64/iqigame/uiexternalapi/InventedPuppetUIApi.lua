-- chunkname: @IQIGame\\UIExternalApi\\InventedPuppetUIApi.lua

InventedPuppetUIApi = BaseLangApi:Extend()

function InventedPuppetUIApi:Init()
	self:RegisterApi("toggleAtt", self.GetBtnAttTxt)
	self:RegisterApi("toggleSkill", self.GetBtnSkillTxt)
	self:RegisterApi("goName_centerView", self.GetSoulName)
	self:RegisterApi("goTitle_centerView", self.GetPuppetTitle)
	self:RegisterApi("goPower_centerView", self.GetPower)
	self:RegisterApi("goSan", self.GetSan)
	self:RegisterApi("goExp", self.GetExp)
	self:RegisterApi("goGettingExp", self.GetGettingExp)
	self:RegisterApi("goSanDesc", self.GetSanDesc)
	self:RegisterApi("goExpDesc", self.GetExpDesc)
	self:RegisterApi("goGettingExpDesc", self.GetGettingExpDesc)
	self:RegisterApi("attName", self.GetAttName)
	self:RegisterApi("attValue", self.GetAttValue)
	self:RegisterApi("goTitle1", self.GetTitle1Txt)
	self:RegisterApi("goTitle2", self.GetTitle2Txt)
	self:RegisterApi("goSkillGroupName", self.GetSkillGroupName)
end

function InventedPuppetUIApi:GetSan(curValue, maxValue)
	return curValue .. "/" .. maxValue
end

function InventedPuppetUIApi:GetExp(exp)
	return exp
end

function InventedPuppetUIApi:GetGettingExp(exp)
	return exp
end

function InventedPuppetUIApi:GetSanDesc()
	return self:GetCfgText(3000001)
end

function InventedPuppetUIApi:GetExpDesc()
	return self:GetCfgText(3000002)
end

function InventedPuppetUIApi:GetGettingExpDesc()
	return self:GetCfgText(3000003)
end

function InventedPuppetUIApi:GetBtnAttTxt()
	return self:GetCfgText(1120001)
end

function InventedPuppetUIApi:GetBtnSkillTxt()
	return self:GetCfgText(1120002)
end

function InventedPuppetUIApi:GetSoulName(name)
	return name
end

function InventedPuppetUIApi:GetPuppetTitle(title)
	return title
end

function InventedPuppetUIApi:GetPower(value)
	return value
end

function InventedPuppetUIApi:GetAttName(id, sourceType)
	return self:GetCfgText(id + 100)
end

function InventedPuppetUIApi:GetAttValue(value)
	return value
end

function InventedPuppetUIApi:GetTitle1Txt()
	return self:GetCfgText(1120003)
end

function InventedPuppetUIApi:GetTitle2Txt()
	return self:GetCfgText(1120004)
end

function InventedPuppetUIApi:GetSkillGroupName(type)
	local names = {
		self:GetCfgText(1120011),
		self:GetCfgText(1120009),
		self:GetCfgText(1120010)
	}

	return names[type + 1]
end

InventedPuppetUIApi:Init()
