-- chunkname: @IQIGame\\UIExternalApi\\OtherExtendApi.lua

OtherExtendApi = BaseLangApi:Extend()

function OtherExtendApi:GetTextTitle_1()
	return self:GetCfgText(6000035)
end

function OtherExtendApi:GetWorldAreaUIWanFaToggleOpenConditionList()
	return {}
end
