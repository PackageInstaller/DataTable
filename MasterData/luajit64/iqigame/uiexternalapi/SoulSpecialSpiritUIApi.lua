-- chunkname: @IQIGame\\UIExternalApi\\SoulSpecialSpiritUIApi.lua

SoulSpecialSpiritUIApi = BaseLangApi:Extend()

function SoulSpecialSpiritUIApi:Init()
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("goSpDesc", self.GetSpDesc)
	self:RegisterApi("goSpName", self.GetSpName)
	self:RegisterApi("goSpName2", self.GetSpName2)
	self:RegisterApi("goSoulName", self.GetSoulName)
	self:RegisterApi("goAttBlockTitle", self.GetAttBlockTitle)
	self:RegisterApi("goSkillBlockTitle", self.GetSkillBlockTitle)
	self:RegisterApi("goBtnEnterTxt", self.GetBtnEnterTxt)
	self:RegisterApi("goBtnEnterTxtEng", self.GetBtnEnterTxtEng)
	self:RegisterApi("attName", self.GetAttName)
	self:RegisterApi("attValue", self.GetAttValue)
	self:RegisterApi("cellSkillName", self.GetCellSkillName)
end

function SoulSpecialSpiritUIApi:GetAttName(name)
	return name
end

function SoulSpecialSpiritUIApi:GetAttValue(value)
	if value == 0 then
		return "--"
	else
		return "+" .. tostring(value)
	end
end

function SoulSpecialSpiritUIApi:GetBtnEnterTxt()
	return self:GetCfgText(1229950)
end

function SoulSpecialSpiritUIApi:GetBtnEnterTxtEng()
	return self:GetCfgText(1229951)
end

function SoulSpecialSpiritUIApi:GetCellSkillName(name)
	return name
end

function SoulSpecialSpiritUIApi:GetSkillBlockTitle()
	return self:GetCfgText(1229952)
end

function SoulSpecialSpiritUIApi:GetAttBlockTitle()
	return self:GetCfgText(1229953)
end

function SoulSpecialSpiritUIApi:GetTitle()
	return self:GetCfgText(1229954)
end

function SoulSpecialSpiritUIApi:GetSpDesc(desc)
	return desc
end

function SoulSpecialSpiritUIApi:GetSpName(name)
	return name
end

function SoulSpecialSpiritUIApi:GetSoulName(name)
	return name
end

SoulSpecialSpiritUIApi:Init()
