-- chunkname: @IQIGame\\UIExternalApi\\LunaBattleLineFormationUIApi.lua

LunaBattleLineFormationUIApi = BaseLangApi:Extend()

function LunaBattleLineFormationUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("SwitchInfoViewBtnText", self.GetSwitchInfoViewBtnText)
end

function LunaBattleLineFormationUIApi:GetTitleText()
	return self:GetCfgText(3600201)
end

function LunaBattleLineFormationUIApi:GetTipText()
	return self:GetCfgText(3600202)
end

function LunaBattleLineFormationUIApi:GetSwitchInfoViewBtnText()
	return self:GetCfgText(3600203)
end

LunaBattleLineFormationUIApi:Init()
