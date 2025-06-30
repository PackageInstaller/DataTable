-- chunkname: @IQIGame\\UIExternalApi\\LoginActivationCodeUIApi.lua

LoginActivationCodeUIApi = BaseLangApi:Extend()

function LoginActivationCodeUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("CancelBtnText", self.GetCancelBtnText)
	self:RegisterApi("InputPlaceHolderText", self.GetInputPlaceHolderText)
end

function LoginActivationCodeUIApi:GetTitleText()
	return self:GetCfgText(1314601)
end

function LoginActivationCodeUIApi:GetTipText()
	return self:GetCfgText(1314602)
end

function LoginActivationCodeUIApi:GetConfirmBtnText()
	return self:GetCfgText(1314603)
end

function LoginActivationCodeUIApi:GetCancelBtnText()
	return self:GetCfgText(1314604)
end

function LoginActivationCodeUIApi:GetInputPlaceHolderText()
	return self:GetCfgText(1314605)
end

LoginActivationCodeUIApi:Init()
