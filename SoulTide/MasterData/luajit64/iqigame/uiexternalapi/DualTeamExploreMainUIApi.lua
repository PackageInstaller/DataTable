-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreMainUIApi.lua

DualTeamExploreMainUIApi = BaseLangApi:Extend()

function DualTeamExploreMainUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("HideTeamBtnText", self.GetHideTeamBtnText)
	self:RegisterApi("ShowTeamBtnText", self.GetShowTeamBtnText)
	self:RegisterApi("TeamToggleTexts", self.GetTeamToggleTexts)
	self:RegisterApi("TeamViewLabel", self.GetTeamViewLabel)
end

function DualTeamExploreMainUIApi:GetTitleText(title)
	return title
end

function DualTeamExploreMainUIApi:GetHideTeamBtnText()
	return self:GetCfgText(3410450)
end

function DualTeamExploreMainUIApi:GetShowTeamBtnText()
	return self:GetCfgText(3410451)
end

function DualTeamExploreMainUIApi:GetTeamToggleTexts()
	return {
		self:GetCfgText(3410454),
		self:GetCfgText(3410454)
	}
end

function DualTeamExploreMainUIApi:GetTeamViewLabel(index)
	return string.format("0%s", index)
end

DualTeamExploreMainUIApi:Init()
