-- chunkname: @IQIGame\\UIExternalApi\\EvilErosionDailySupplyUIApi.lua

EvilErosionDailySupplyUIApi = BaseLangApi:Extend()

function EvilErosionDailySupplyUIApi:Init()
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
end

function EvilErosionDailySupplyUIApi:GetTipText()
	return self:GetCfgText(1213110)
end

function EvilErosionDailySupplyUIApi:GetTitleText()
	return self:GetCfgText(1213111)
end

function EvilErosionDailySupplyUIApi:GetConfirmBtnText()
	return self:GetCfgText(1213112)
end

EvilErosionDailySupplyUIApi:Init()
