-- chunkname: @IQIGame\\UIExternalApi\\SoulTalentAttributeUIApi.lua

SoulTalentAttributeUIApi = BaseLangApi:Extend()

function SoulTalentAttributeUIApi:Init()
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("goBtnClose", self.GetBtnCloseTxt)
	self:RegisterApi("goAttName", self.GetAttName)
	self:RegisterApi("goAttValue", self.GetAttValue)
end

function SoulTalentAttributeUIApi:GetAttName(name)
	return name
end

function SoulTalentAttributeUIApi:GetAttValue(value)
	return "+" .. tostring(value)
end

function SoulTalentAttributeUIApi:GetBtnCloseTxt()
	return self:GetCfgText(1228005)
end

function SoulTalentAttributeUIApi:GetTitle()
	return self:GetCfgText(1228006)
end

SoulTalentAttributeUIApi:Init()
