-- chunkname: @IQIGame\\UIExternalApi\\EvilErosionSoulInfoUIApi.lua

EvilErosionSoulInfoUIApi = BaseLangApi:Extend()

function EvilErosionSoulInfoUIApi:Init()
	self:RegisterApi("SkillLabel", self.GetSkillLabel)
	self:RegisterApi("AttrLabel", self.GetAttrLabel)
	self:RegisterApi("LevelText", self.GetLevelText)
end

function EvilErosionSoulInfoUIApi:GetSkillLabel()
	return self:GetCfgText(1227020)
end

function EvilErosionSoulInfoUIApi:GetAttrLabel()
	return self:GetCfgText(1314340)
end

function EvilErosionSoulInfoUIApi:GetLevelText(lv)
	return "Lv." .. lv
end

EvilErosionSoulInfoUIApi:Init()
