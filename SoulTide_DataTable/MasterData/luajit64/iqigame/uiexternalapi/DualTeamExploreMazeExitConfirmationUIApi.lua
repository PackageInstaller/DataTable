-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreMazeExitConfirmationUIApi.lua

DualTeamExploreMazeExitConfirmationUIApi = BaseLangApi:Extend()

function DualTeamExploreMazeExitConfirmationUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ContentText", self.GetContentText)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("AFKBtnText", self.GetAFKBtnText)
	self:RegisterApi("GiveUpBtn", self.GetGiveUpBtn)
end

function DualTeamExploreMazeExitConfirmationUIApi:GetTitleText()
	return self:GetCfgText(3410310), self:GetCfgText(3410311)
end

function DualTeamExploreMazeExitConfirmationUIApi:GetContentText()
	return self:GetCfgText(3410312)
end

function DualTeamExploreMazeExitConfirmationUIApi:GetTipText()
	return self:GetCfgText(3410313)
end

function DualTeamExploreMazeExitConfirmationUIApi:GetAFKBtnText()
	return self:GetCfgText(3410314)
end

function DualTeamExploreMazeExitConfirmationUIApi:GetGiveUpBtn()
	return self:GetCfgText(3410315)
end

DualTeamExploreMazeExitConfirmationUIApi:Init()
