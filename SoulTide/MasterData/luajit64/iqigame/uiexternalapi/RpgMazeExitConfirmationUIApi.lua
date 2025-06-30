-- chunkname: @IQIGame\\UIExternalApi\\RpgMazeExitConfirmationUIApi.lua

RpgMazeExitConfirmationUIApi = BaseLangApi:Extend()

function RpgMazeExitConfirmationUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ContentText", self.GetContentText)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("ExitBtnText", self.GetExitBtnText)
	self:RegisterApi("AFKBtnText", self.GetAFKBtnText)
end

function RpgMazeExitConfirmationUIApi:GetTitleText()
	return self:GetCfgText(2300015), self:GetCfgText(2300016)
end

function RpgMazeExitConfirmationUIApi:GetContentText(winBefore)
	return self:GetCfgText(2300038)
end

function RpgMazeExitConfirmationUIApi:GetTipText(winBefore)
	return self:GetCfgText(2300039)
end

function RpgMazeExitConfirmationUIApi:GetExitBtnText()
	return self:GetCfgText(2300019)
end

function RpgMazeExitConfirmationUIApi:GetAFKBtnText()
	return self:GetCfgText(2300020)
end

RpgMazeExitConfirmationUIApi:Init()
