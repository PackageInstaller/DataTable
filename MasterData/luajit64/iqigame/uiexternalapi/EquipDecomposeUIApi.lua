-- chunkname: @IQIGame\\UIExternalApi\\EquipDecomposeUIApi.lua

EquipDecomposeUIApi = BaseLangApi:Extend()

function EquipDecomposeUIApi:Init()
	self:RegisterApi("goBtnSure", self.GetBtnSureTxt)
	self:RegisterApi("goBtnCancel", self.GetBtnCancelTxt)
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("goDesc1", self.GetDesc1)
	self:RegisterApi("goDesc3", self.GetDesc3)
end

function EquipDecomposeUIApi:GetBtnSureTxt()
	return self:GetCfgText(1314201)
end

function EquipDecomposeUIApi:GetBtnCancelTxt()
	return self:GetCfgText(1314202)
end

function EquipDecomposeUIApi:GetTitle()
	return self:GetCfgText(1314203)
end

function EquipDecomposeUIApi:GetDesc1()
	return self:GetCfgText(1314204)
end

function EquipDecomposeUIApi:GetDesc3()
	return self:GetCfgText(1314205)
end

EquipDecomposeUIApi:Init()
