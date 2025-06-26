-- chunkname: @IQIGame\\UIExternalApi\\SurvivalChallengeFormationUIApi.lua

SurvivalChallengeFormationUIApi = BaseLangApi:Extend()

function SurvivalChallengeFormationUIApi:Init()
	self:RegisterApi("SpendValue", self.GetSpendValue)
end

function SurvivalChallengeFormationUIApi:GetSpendValue(value)
	return string.format("x%s", value)
end

SurvivalChallengeFormationUIApi:Init()
