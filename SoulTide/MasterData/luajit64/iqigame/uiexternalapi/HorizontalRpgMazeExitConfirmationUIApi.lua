-- chunkname: @IQIGame\\UIExternalApi\\HorizontalRpgMazeExitConfirmationUIApi.lua

HorizontalRpgMazeExitConfirmationUIApi = BaseLangApi:Extend()

function HorizontalRpgMazeExitConfirmationUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ContentText", self.GetContentText)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("ExitBtnText", self.GetExitBtnText)
	self:RegisterApi("AFKBtnText", self.GetAFKBtnText)
end

function HorizontalRpgMazeExitConfirmationUIApi:GetTitleText()
	return self:GetCfgText(2300015), self:GetCfgText(2300016)
end

function HorizontalRpgMazeExitConfirmationUIApi:GetContentText(winBefore)
	return self:GetCfgText(2300154)
end

function HorizontalRpgMazeExitConfirmationUIApi:GetTipText(winBefore)
	return self:GetCfgText(2300155)
end

function HorizontalRpgMazeExitConfirmationUIApi:GetExitBtnText()
	return self:GetCfgText(2300019)
end

function HorizontalRpgMazeExitConfirmationUIApi:GetAFKBtnText()
	return self:GetCfgText(2300020)
end

HorizontalRpgMazeExitConfirmationUIApi:Init()
