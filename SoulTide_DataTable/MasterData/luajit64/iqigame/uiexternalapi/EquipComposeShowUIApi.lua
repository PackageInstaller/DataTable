-- chunkname: @IQIGame\\UIExternalApi\\EquipComposeShowUIApi.lua

EquipComposeShowUIApi = BaseLangApi:Extend()

function EquipComposeShowUIApi:Init()
	self:RegisterApi("goBtnClose", self.GetBtnCloseTxt)
	self:RegisterApi("goClipNum", self.GetClipNum)
	self:RegisterApi("goClipDesc", self.GetClipDesc)
	self:RegisterApi("duration", self.GetDuration)
end

function EquipComposeShowUIApi:GetBtnCloseTxt()
	return self:GetCfgText(1314101)
end

function EquipComposeShowUIApi:GetClipNum(value)
	return "x" .. value
end

function EquipComposeShowUIApi:GetClipDesc()
	return self:GetCfgText(1314102)
end

function EquipComposeShowUIApi:GetDuration()
	return 2
end

EquipComposeShowUIApi:Init()
