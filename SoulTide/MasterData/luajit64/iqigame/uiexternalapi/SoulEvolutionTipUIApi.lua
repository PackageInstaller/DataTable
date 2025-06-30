-- chunkname: @IQIGame\\UIExternalApi\\SoulEvolutionTipUIApi.lua

SoulEvolutionTipUIApi = BaseLangApi:Extend()

function SoulEvolutionTipUIApi:Init()
	self:RegisterApi("goAttName", self.GetAttName)
	self:RegisterApi("goAttValuePre", self.GetAttValuePre)
	self:RegisterApi("goAttValueCur", self.GetAttValueCur)
	self:RegisterApi("goTitle", self.GetFeatureTitle)
	self:RegisterApi("goTitleEng", self.GetFeatureTitleEng)
	self:RegisterApi("goTitleEng2", self.GetFeatureTitleEng2)
	self:RegisterApi("goAttTitle", self.GetAttTitle)
	self:RegisterApi("goFeatureName", self.GetFeatureName)
	self:RegisterApi("goFeatureLv", self.GetFeatureLv)
	self:RegisterApi("goFeatureDesc", self.GetFeatureDesc)
	self:RegisterApi("goGrowUpName", self.GetGrowUpName)
	self:RegisterApi("goGrowUpValuePre", self.GetGrowUpValuePre)
	self:RegisterApi("goGrowUpValueNow", self.GetGrowUpValueNow)
end

function SoulEvolutionTipUIApi:GetGrowUpName(name)
	return name
end

function SoulEvolutionTipUIApi:GetGrowUpValuePre(value)
	return value
end

function SoulEvolutionTipUIApi:GetGrowUpValueNow(value)
	return value
end

function SoulEvolutionTipUIApi:GetFeatureLv(index)
	return self:GetCfgText(1229098) .. tostring(index)
end

function SoulEvolutionTipUIApi:GetFeatureDesc(desc)
	return self:SkillValueColor(desc, 29)
end

function SoulEvolutionTipUIApi:GetAttName(name)
	return name
end

function SoulEvolutionTipUIApi:GetAttValuePre(value)
	return value
end

function SoulEvolutionTipUIApi:GetAttValueCur(value)
	return value
end

function SoulEvolutionTipUIApi:GetFeatureTitle()
	return self:GetCfgText(2300505)
end

function SoulEvolutionTipUIApi:GetFeatureTitleEng()
	return "ORIGIN UNLOCK"
end

function SoulEvolutionTipUIApi:GetFeatureTitleEng2()
	return ""
end

function SoulEvolutionTipUIApi:GetAttTitle()
	return self:GetCfgText(2300503)
end

function SoulEvolutionTipUIApi:GetFeatureName(name)
	return name
end

SoulEvolutionTipUIApi:Init()
