-- chunkname: @IQIGame\\UIExternalApi\\DialogSkipConfirmUIApi.lua

DialogSkipConfirmUIApi = BaseLangApi:Extend()

function DialogSkipConfirmUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("CancelBtnText", self.GetCancelBtnText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
end

function DialogSkipConfirmUIApi:GetTitleText()
	return self:GetCfgText(2610001)
end

function DialogSkipConfirmUIApi:GetCancelBtnText()
	return self:GetCfgText(2610002)
end

function DialogSkipConfirmUIApi:GetConfirmBtnText()
	return self:GetCfgText(2610003)
end

DialogSkipConfirmUIApi:Init()
