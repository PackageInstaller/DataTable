-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreLevelExitUIApi.lua

DualTeamExploreLevelExitUIApi = BaseLangApi:Extend()

function DualTeamExploreLevelExitUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ContentText", self.GetContentText)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("GiveUpBtnText", self.GetGiveUpBtnText)
	self:RegisterApi("AFKBtnText", self.GetAFKBtnText)
end

function DualTeamExploreLevelExitUIApi:GetTitleText()
	return self:GetCfgText(3410301)
end

function DualTeamExploreLevelExitUIApi:GetContentText()
	return self:GetCfgText(3410302)
end

function DualTeamExploreLevelExitUIApi:GetTipText()
	return self:GetCfgText(3410303)
end

function DualTeamExploreLevelExitUIApi:GetGiveUpBtnText()
	return self:GetCfgText(3410304)
end

function DualTeamExploreLevelExitUIApi:GetAFKBtnText()
	return self:GetCfgText(2300020)
end

DualTeamExploreLevelExitUIApi:Init()
