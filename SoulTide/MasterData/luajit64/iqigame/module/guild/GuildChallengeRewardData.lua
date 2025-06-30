-- chunkname: @IQIGame\\Module\\Guild\\GuildChallengeRewardData.lua

local m = {
	score = 0,
	maxScore = 0,
	state = 0
}

function m.New(cid, state, score, maxScore)
	local o = Clone(m)

	o:Init(cid, state, score, maxScore)

	return o
end

function m:Init(cid, state, score, maxScore)
	self.cid = cid
	self.state = state
	self.score = score
	self.maxScore = maxScore
	self.cfgInfo = CfgGuildChallengeChestRewardTable[cid]
end

return m
