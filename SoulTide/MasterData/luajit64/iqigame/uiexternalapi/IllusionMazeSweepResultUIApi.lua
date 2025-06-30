-- chunkname: @IQIGame\\UIExternalApi\\IllusionMazeSweepResultUIApi.lua

IllusionMazeSweepResultUIApi = BaseLangApi:Extend()

function IllusionMazeSweepResultUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ResultLabel", self.GetResultLabel)
	self:RegisterApi("CloseBtnText", self.GetCloseBtnText)
end

function IllusionMazeSweepResultUIApi:GetTitleText()
	return self:GetCfgText(2209021)
end

function IllusionMazeSweepResultUIApi:GetResultLabel()
	return self:GetCfgText(2209022)
end

function IllusionMazeSweepResultUIApi:GetCloseBtnText()
	return self:GetCfgText(2209023)
end

IllusionMazeSweepResultUIApi:Init()
