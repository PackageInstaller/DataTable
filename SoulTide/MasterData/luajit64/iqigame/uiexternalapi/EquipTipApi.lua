-- chunkname: @IQIGame\\UIExternalApi\\EquipTipApi.lua

EquipTipApi = BaseLangApi:Extend()

function EquipTipApi:Init()
	self:RegisterApi("goViewTitle", self.GetViewTitle)
	self:RegisterApi("goDesc", self.GetDescText)
	self:RegisterApi("goEquipName", self.GetEquipNameText)
	self:RegisterApi("goPartName", self.GetPartText)
	self:RegisterApi("goAttBaseTitle", self.GetAttBaseTitle)
	self:RegisterApi("goAttSecTitle", self.GetAttSecTitle)
	self:RegisterApi("goAtt1", self.GetAtt1)
	self:RegisterApi("goAtt2", self.GetAtt2)
	self:RegisterApi("goSuitTitle", self.GetSuitTitle)
	self:RegisterApi("goSuitEffect", self.GetSuitEffect)
end

function EquipTipApi:GetDescText(desc)
	return desc
end

function EquipTipApi:GetViewTitle()
	return self:GetCfgText(1001011)
end

function EquipTipApi:GetEquipNameText(name, quality)
	return name
end

function EquipTipApi:GetPartText(partType)
	return
end

function EquipTipApi:GetAttBaseTitle()
	return self:GetCfgText(1001005)
end

function EquipTipApi:GetAttSecTitle()
	return self:GetCfgText(1001006)
end

function EquipTipApi:GetAtt1(type, value)
	return AttributeModule.GetAttName(type) .. "+" .. value
end

function EquipTipApi:GetAtt2(type, value)
	return AttributeModule.GetAttName(type) .. "+" .. value
end

function EquipTipApi:GetSuitTitle()
	return self:GetCfgText(1001010)
end

function EquipTipApi:GetSuitEffect(desc)
	return desc
end

EquipTipApi:Init()
