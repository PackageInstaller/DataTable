-- chunkname: @IQIGame\\UIExternalApi\\EquipAdvancedShowUIApi.lua

EquipAdvancedShowUIApi = BaseLangApi:Extend()

function EquipAdvancedShowUIApi:Init()
	self:RegisterApi("goBtnClose", self.GetBtnCloseTxt)
	self:RegisterApi("curMainAttValue", self.GetCurMainAttValue)
	self:RegisterApi("preMainAttValue", self.GetPreMainAttValue)
	self:RegisterApi("goAttName", self.GetAttName)
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("startMoveTime", self.GetStartMoveTime)
	self:RegisterApi("showTime", self.GetShowTime)
	self:RegisterApi("attBlockTitle", self.GetAttBlockTitle)
	self:RegisterApi("pabBlockTitle", self.GetPabBlockTitle)
	self:RegisterApi("goName", self.GetName)
	self:RegisterApi("goLv", self.GetLv)
	self:RegisterApi("goPabilityDeltaValue", self.GetPalityDeltaValue)
	self:RegisterApi("pabilityDesc", self.GetPabilityDesc)
	self:RegisterApi("pabilityName", self.GetPabilityName)
end

function EquipAdvancedShowUIApi:GetPabilityDesc(desc)
	return self:SkillValueColor(desc, 29)
end

function EquipAdvancedShowUIApi:GetPabilityName(name)
	return name
end

function EquipAdvancedShowUIApi:GetPalityDeltaValue(value)
	return value
end

function EquipAdvancedShowUIApi:GetLv(lv, isNow)
	return "Lv." .. tostring(lv)
end

function EquipAdvancedShowUIApi:GetName(name)
	return name
end

function EquipAdvancedShowUIApi:GetAttBlockTitle()
	return self:GetCfgText(1314500)
end

function EquipAdvancedShowUIApi:GetPabBlockTitle()
	return self:GetCfgText(1314501)
end

function EquipAdvancedShowUIApi:GetStartMoveTime()
	return 0.8
end

function EquipAdvancedShowUIApi:GetShowTime()
	return 1.5
end

function EquipAdvancedShowUIApi:GetBtnCloseTxt()
	return self:GetCfgText(1314001)
end

function EquipAdvancedShowUIApi:GetCurMainAttValue(value)
	return value
end

function EquipAdvancedShowUIApi:GetPreMainAttValue(value)
	return value
end

function EquipAdvancedShowUIApi:GetAttName(type)
	return AttributeModule.GetAttName(type)
end

function EquipAdvancedShowUIApi:GetTitle()
	return self:GetCfgText(1314002)
end

EquipAdvancedShowUIApi:Init()
