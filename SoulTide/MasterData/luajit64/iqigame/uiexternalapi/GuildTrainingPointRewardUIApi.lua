-- chunkname: @IQIGame\\UIExternalApi\\GuildTrainingPointRewardUIApi.lua

GuildTrainingPointRewardUIApi = BaseLangApi:Extend()

function GuildTrainingPointRewardUIApi:Init()
	self:RegisterApi("TextNeedScore", self.GetTextNeedScore)
	self:RegisterApi("TextScoreMax", self.GetTextScoreMax)
end

function GuildTrainingPointRewardUIApi:GetTextScoreMax(score)
	return string.format(self:GetCfgText(9101603), score)
end

function GuildTrainingPointRewardUIApi:GetTextNeedScore(score)
	return string.format(self:GetCfgText(9101603), score)
end

GuildTrainingPointRewardUIApi:Init()
