-- chunkname: @IQIGame\\UIExternalApi\\ChallengeRewardUIApi.lua

ChallengeRewardUIApi = BaseLangApi:Extend()

function ChallengeRewardUIApi:Init()
	self:RegisterApi("goBtnTxt", self.GetBtnTxt)
	self:RegisterApi("RewardText", self.GetRewardText)
end

function ChallengeRewardUIApi:GetRewardText()
	return self:GetCfgText(2710001)
end

function ChallengeRewardUIApi:GetBtnTxt()
	return self:GetCfgText(2710002)
end

ChallengeRewardUIApi:Init()
