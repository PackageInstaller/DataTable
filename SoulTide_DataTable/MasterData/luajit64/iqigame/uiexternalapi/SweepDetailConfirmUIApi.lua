-- chunkname: @IQIGame\\UIExternalApi\\SweepDetailConfirmUIApi.lua

SweepDetailConfirmUIApi = BaseLangApi:Extend()

function SweepDetailConfirmUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("SweepCountLabel", self.GetSweepCountLabel)
	self:RegisterApi("MaxBtnText", self.GetMaxBtnText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("CostNumText", self.GetCostNumText)
end

function SweepDetailConfirmUIApi:GetTitleText()
	return self:GetCfgText(1213023)
end

function SweepDetailConfirmUIApi:GetSweepCountLabel()
	return self:GetCfgText(2300060)
end

function SweepDetailConfirmUIApi:GetMaxBtnText()
	return self:GetCfgText(1140105)
end

function SweepDetailConfirmUIApi:GetConfirmBtnText()
	return self:GetCfgText(1113002)
end

function SweepDetailConfirmUIApi:GetCostNumText(needCost, maxEnergy)
	return needCost .. "/" .. maxEnergy
end

SweepDetailConfirmUIApi:Init()
