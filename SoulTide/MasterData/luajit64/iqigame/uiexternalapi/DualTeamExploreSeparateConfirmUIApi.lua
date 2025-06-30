-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreSeparateConfirmUIApi.lua

DualTeamExploreSeparateConfirmUIApi = BaseLangApi:Extend()

function DualTeamExploreSeparateConfirmUIApi:Init()
	self:RegisterApi("SelectTeamLabel", self.GetSelectTeamLabel)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("TitleText", self.GetTitleText)
end

function DualTeamExploreSeparateConfirmUIApi:GetSelectTeamLabel()
	return self:GetCfgText(3410260)
end

function DualTeamExploreSeparateConfirmUIApi:GetTipText()
	return self:GetCfgText(3410261)
end

function DualTeamExploreSeparateConfirmUIApi:GetTitleText()
	return self:GetCfgText(3410262)
end

DualTeamExploreSeparateConfirmUIApi:Init()
