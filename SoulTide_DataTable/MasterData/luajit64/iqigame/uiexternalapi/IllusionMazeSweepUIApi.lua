-- chunkname: @IQIGame\\UIExternalApi\\IllusionMazeSweepUIApi.lua

IllusionMazeSweepUIApi = BaseLangApi:Extend()

function IllusionMazeSweepUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ContentText", self.GetContentText)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("CancelBtnText", self.GetCancelBtnText)
	self:RegisterApi("IgnoreToggleText", self.GetIgnoreToggleText)
end

function IllusionMazeSweepUIApi:GetTitleText()
	return self:GetCfgText(2209003)
end

function IllusionMazeSweepUIApi:GetContentText()
	return self:GetCfgText(2209004)
end

function IllusionMazeSweepUIApi:GetTipText()
	return self:GetCfgText(2209005)
end

function IllusionMazeSweepUIApi:GetConfirmBtnText()
	return self:GetCfgText(2209006)
end

function IllusionMazeSweepUIApi:GetCancelBtnText()
	return self:GetCfgText(2209007)
end

function IllusionMazeSweepUIApi:GetIgnoreToggleText()
	return self:GetCfgText(2209008)
end

IllusionMazeSweepUIApi:Init()
