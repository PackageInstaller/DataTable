-- chunkname: @IQIGame\\UIExternalApi\\ChallengeTowerLastRewardUIApi.lua

ChallengeTowerLastRewardUIApi = BaseLangApi:Extend()

function ChallengeTowerLastRewardUIApi:Init()
	self:RegisterApi("TextFlag", self.GetTextFlag)
end

function ChallengeTowerLastRewardUIApi:GetTextFlag()
	return self:GetCfgText(1213044)
end

ChallengeTowerLastRewardUIApi:Init()
