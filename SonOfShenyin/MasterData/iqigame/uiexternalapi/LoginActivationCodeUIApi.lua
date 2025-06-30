-- chunkname: @IQIGame\\UIExternalApi\\LoginActivationCodeUIApi.lua

LoginActivationCodeUIApi = BaseLangApi:Extend()

function LoginActivationCodeUIApi:GetTitleText()
	return self:GetCfgText(1111106)
end

function LoginActivationCodeUIApi:GetTipText()
	return self:GetCfgText(1111012)
end

function LoginActivationCodeUIApi:GetConfirmBtnText()
	return self:GetCfgText(1111105)
end

function LoginActivationCodeUIApi:GetCancelBtnText()
	return self:GetCfgText(1111011)
end

function LoginActivationCodeUIApi:GetInputPlaceHolderText()
	return self:GetCfgText(1111014)
end
