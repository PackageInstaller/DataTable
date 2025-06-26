-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreLevelFormationUIApi.lua

DualTeamExploreLevelFormationUIApi = BaseLangApi:Extend()

function DualTeamExploreLevelFormationUIApi:Init()
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("FormationItem_FormationLabel", self.GetFormationItem_FormationLabel)
	self:RegisterApi("FormationItem_OrderText", self.GetFormationItem_OrderText)
	self:RegisterApi("FormationItem_QuickBtnText", self.GetFormationItem_QuickBtnText)
	self:RegisterApi("SoulHead_RepeatTagText", self.GetSoulHead_RepeatTagText)
end

function DualTeamExploreLevelFormationUIApi:GetTipText()
	return self:GetCfgText(3410181)
end

function DualTeamExploreLevelFormationUIApi:GetTitleText()
	return self:GetCfgText(3410182)
end

function DualTeamExploreLevelFormationUIApi:GetFormationItem_FormationLabel()
	return self:GetCfgText(3410183)
end

function DualTeamExploreLevelFormationUIApi:GetFormationItem_OrderText(index)
	return "0" .. index
end

function DualTeamExploreLevelFormationUIApi:GetFormationItem_QuickBtnText()
	return self:GetCfgText(3410184)
end

function DualTeamExploreLevelFormationUIApi:GetSoulHead_RepeatTagText()
	return self:GetCfgText(3410185)
end

DualTeamExploreLevelFormationUIApi:Init()
