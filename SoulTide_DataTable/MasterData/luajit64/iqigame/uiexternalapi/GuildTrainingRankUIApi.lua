-- chunkname: @IQIGame\\UIExternalApi\\GuildTrainingRankUIApi.lua

GuildTrainingRankUIApi = BaseLangApi:Extend()

function GuildTrainingRankUIApi:Init()
	self:RegisterApi("TextRank", self.GetTextRank)
	self:RegisterApi("GuildScore", self.GetGuildScore)
end

function GuildTrainingRankUIApi:GetGuildScore(score)
	return string.format(self:GetCfgText(9101602), score)
end

function GuildTrainingRankUIApi:GetTextRank(rank, type)
	local rankStr = rank

	if type == 2 then
		rankStr = string.format("%s%", rank)
	end

	return rankStr
end

GuildTrainingRankUIApi:Init()
