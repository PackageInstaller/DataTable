-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreLevelEntryConfirmUIApi.lua

DualTeamExploreLevelEntryConfirmUIApi = BaseLangApi:Extend()

function DualTeamExploreLevelEntryConfirmUIApi:Init()
	self:RegisterApi("ModeDescText2", self.GetModeDescText2)
	self:RegisterApi("ModeDescText1", self.GetModeDescText1)
	self:RegisterApi("ModeNameText2", self.GetModeNameText2)
	self:RegisterApi("ModeNameText1", self.GetModeNameText1)
	self:RegisterApi("SubTitleText", self.GetSubTitleText)
	self:RegisterApi("TitleText", self.GetTitleText)
end

function DualTeamExploreLevelEntryConfirmUIApi:GetModeDescText2()
	return self:GetCfgText(3410201)
end

function DualTeamExploreLevelEntryConfirmUIApi:GetModeDescText1()
	return self:GetCfgText(3410202)
end

function DualTeamExploreLevelEntryConfirmUIApi:GetModeNameText2()
	return self:GetCfgText(3410003)
end

function DualTeamExploreLevelEntryConfirmUIApi:GetModeNameText1()
	return self:GetCfgText(3410002)
end

function DualTeamExploreLevelEntryConfirmUIApi:GetSubTitleText()
	return self:GetCfgText(3410203)
end

function DualTeamExploreLevelEntryConfirmUIApi:GetTitleText()
	return self:GetCfgText(3410204)
end

DualTeamExploreLevelEntryConfirmUIApi:Init()
