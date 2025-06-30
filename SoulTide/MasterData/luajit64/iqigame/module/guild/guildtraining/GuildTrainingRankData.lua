-- chunkname: @IQIGame\\Module\\Guild\\GuildTraining\\GuildTrainingRankData.lua

local m = {
	rank = 0,
	rankType = 1,
	guildScore = 0,
	guildName = ""
}

function m.New(guildID, rank, rankType, iconCid, avatarFrameCid, guildName, guildScore)
	local o = Clone(m)

	o:Init(guildID, rank, rankType, iconCid, avatarFrameCid, guildName, guildScore)

	return o
end

function m:Init(guildID, rank, rankType, iconCid, avatarFrameCid, guildName, guildScore)
	self.guildId = guildID
	self.rank = rank
	self.rankType = rankType
	self.iconCid = iconCid
	self.avatarFrameCid = avatarFrameCid
	self.guildName = guildName
	self.guildScore = guildScore
	self.cfgRankRewardData = self:GetCfgTrainingRankRewardData()
end

function m:GetCfgTrainingRankRewardData()
	for i, v in pairsCfg(CfgGuildTrainingRankRewardTable) do
		if v.RankType == self.rankType and v.RankLowerLimit <= self.rank and self.rank <= v.RankUpperLimit then
			return v
		end
	end

	if self.rank > 0 then
		logError("CfgGuildTrainingRankRewardTable 找不到对应配置" .. " 排行类型 rankType = " .. self.rankType .. " 当前排行 rank = " .. self.rank)
	end

	return nil
end

return m
