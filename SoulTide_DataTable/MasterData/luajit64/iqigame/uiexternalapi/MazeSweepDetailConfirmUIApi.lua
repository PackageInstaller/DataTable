-- chunkname: @IQIGame\\UIExternalApi\\MazeSweepDetailConfirmUIApi.lua

MazeSweepDetailConfirmUIApi = BaseLangApi:Extend()

function MazeSweepDetailConfirmUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("SweepCountLabel", self.GetSweepCountLabel)
	self:RegisterApi("MaxBtnText", self.GetMaxBtnText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("CostNumText", self.GetCostNumText)
end

function MazeSweepDetailConfirmUIApi:GetTitleText()
	return self:GetCfgText(1213023)
end

function MazeSweepDetailConfirmUIApi:GetSweepCountLabel()
	return self:GetCfgText(2300060)
end

function MazeSweepDetailConfirmUIApi:GetMaxBtnText()
	return self:GetCfgText(1140105)
end

function MazeSweepDetailConfirmUIApi:GetConfirmBtnText()
	return self:GetCfgText(1113002)
end

function MazeSweepDetailConfirmUIApi:GetCostNumText(needCost, maxEnergy)
	return needCost .. "/" .. maxEnergy
end

MazeSweepDetailConfirmUIApi:Init()
