-- chunkname: @IQIGame\\UIExternalApi\\SurvivalChallengeUpgradeUIApi.lua

SurvivalChallengeUpgradeUIApi = BaseLangApi:Extend()

function SurvivalChallengeUpgradeUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("UpgradeSpend", self.GetUpgradeSpend)
end

function SurvivalChallengeUpgradeUIApi:GetUpgradeSpend(num)
	return string.format("x%s", num)
end

function SurvivalChallengeUpgradeUIApi:GetTitleText()
	return self:GetCfgText(3300521)
end

SurvivalChallengeUpgradeUIApi:Init()
