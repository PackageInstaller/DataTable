-- chunkname: @IQIGame\\UIExternalApi\\LunaBattleLineEnhanceFormationUIApi.lua

LunaBattleLineEnhanceFormationUIApi = BaseLangApi:Extend()

function LunaBattleLineEnhanceFormationUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("FormationTitleText", self.GetFormationTitleText)
	self:RegisterApi("SoulPrefabStrengthLevelLabel", self.GetSoulPrefabStrengthLevelLabel)
	self:RegisterApi("LevelText", self.GetLevelText)
	self:RegisterApi("EnterBtnText", self.GetEnterBtnText)
	self:RegisterApi("WeakLabel", self.GetWeakLabel)
	self:RegisterApi("RewardLabel", self.GetRewardLabel)
	self:RegisterApi("SoulCellPositionToggleTexts", self.GetSoulCellPositionToggleTexts)
end

function LunaBattleLineEnhanceFormationUIApi:GetTitleText()
	return self:GetCfgText(3600081)
end

function LunaBattleLineEnhanceFormationUIApi:GetFormationTitleText()
	return self:GetCfgText(3600082)
end

function LunaBattleLineEnhanceFormationUIApi:GetSoulPrefabStrengthLevelLabel()
	return self:GetCfgText(3600083)
end

function LunaBattleLineEnhanceFormationUIApi:GetLevelText(level)
	return string.format("Lv.<size=%s>%s</size>", 30, level)
end

function LunaBattleLineEnhanceFormationUIApi:GetEnterBtnText()
	return self:GetCfgText(3600084)
end

function LunaBattleLineEnhanceFormationUIApi:GetWeakLabel()
	return self:GetCfgText(3600085)
end

function LunaBattleLineEnhanceFormationUIApi:GetRewardLabel()
	return self:GetCfgText(3600086)
end

function LunaBattleLineEnhanceFormationUIApi:GetSoulCellPositionToggleTexts()
	return {
		self:GetCfgText(3600087),
		self:GetCfgText(3600088)
	}
end

LunaBattleLineEnhanceFormationUIApi:Init()
