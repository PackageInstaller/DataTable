-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreMazeConfirmUIApi.lua

DualTeamExploreMazeConfirmUIApi = BaseLangApi:Extend()

function DualTeamExploreMazeConfirmUIApi:Init()
	self:RegisterApi("ExploreProgressText", self.GetExploreProgressText)
	self:RegisterApi("ExploreLabel", self.GetExploreLabel)
	self:RegisterApi("SubTitleText", self.GetSubTitleText)
	self:RegisterApi("TitleText", self.GetTitleText)
end

function DualTeamExploreMazeConfirmUIApi:GetExploreProgressText(progress)
	return progress .. "%"
end

function DualTeamExploreMazeConfirmUIApi:GetExploreLabel()
	return self:GetCfgText(3410240)
end

function DualTeamExploreMazeConfirmUIApi:GetSubTitleText()
	return self:GetCfgText(3410241)
end

function DualTeamExploreMazeConfirmUIApi:GetTitleText()
	return self:GetCfgText(3410242)
end

DualTeamExploreMazeConfirmUIApi:Init()
