-- chunkname: @IQIGame\\UIExternalApi\\ChallengeWorldBossUIApi.lua

ChallengeWorldBossUIApi = BaseLangApi:Extend()

function ChallengeWorldBossUIApi:Init()
	self:RegisterApi("RewardTag", self.GetRewardTag)
end

function ChallengeWorldBossUIApi:GetRewardTag(tag)
	if tag == 1 then
		return self:GetCfgText(1320001)
	elseif tag == 2 then
		return self:GetCfgText(1015124)
	elseif tag == 3 then
		return self:GetCfgText(1015088)
	elseif tag == 4 then
		return self:GetCfgText(124)
	elseif tag == 5 then
		return self:GetCfgText(1213078)
	elseif tag == 6 then
		return self:GetCfgText(1213044)
	elseif tag == 7 then
		return self:GetCfgText(1106035)
	end

	return ""
end

ChallengeWorldBossUIApi:Init()
