-- chunkname: @IQIGame\\UIExternalApi\\MazeExitConfirmationUIApi.lua

MazeExitConfirmationUIApi = BaseLangApi:Extend()

function MazeExitConfirmationUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ContentText", self.GetContentText)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("ExitBtnText", self.GetExitBtnText)
	self:RegisterApi("AFKBtnText", self.GetAFKBtnText)
end

function MazeExitConfirmationUIApi:GetTitleText()
	return self:GetCfgText(2300015), self:GetCfgText(2300016)
end

function MazeExitConfirmationUIApi:GetContentText()
	return self:GetCfgText(2300017)
end

function MazeExitConfirmationUIApi:GetTipText()
	return self:GetCfgText(2300018)
end

function MazeExitConfirmationUIApi:GetExitBtnText()
	return self:GetCfgText(2300019)
end

function MazeExitConfirmationUIApi:GetAFKBtnText()
	return self:GetCfgText(2300020)
end

MazeExitConfirmationUIApi:Init()
