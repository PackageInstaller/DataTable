-- chunkname: @IQIGame\\UIExternalApi\\TurntableGameUIApi.lua

TurntableGameUIApi = BaseLangApi:Extend()

function TurntableGameUIApi:Init()
	self:RegisterApi("StartBtnText", self.GetStartBtnText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("CloseBtnText", self.GetCloseBtnText)
	self:RegisterApi("DefaultSpeed", self.GetDefaultSpeed)
	self:RegisterApi("DefaultAcceleration", self.GetDefaultAcceleration)
end

function TurntableGameUIApi:GetStartBtnText()
	return self:GetCfgText(1150101)
end

function TurntableGameUIApi:GetConfirmBtnText()
	return self:GetCfgText(1150103)
end

function TurntableGameUIApi:GetCloseBtnText()
	return self:GetCfgText(1150104)
end

function TurntableGameUIApi:GetDefaultSpeed()
	return 40
end

function TurntableGameUIApi:GetDefaultAcceleration()
	return -360
end

TurntableGameUIApi:Init()
