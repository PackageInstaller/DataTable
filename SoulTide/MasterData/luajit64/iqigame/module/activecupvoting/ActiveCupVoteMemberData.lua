-- chunkname: @IQIGame\\Module\\ActiveCupVoting\\ActiveCupVoteMemberData.lua

local m = {
	lastVoteTime = 0,
	groupName = ""
}

function m.New(cid, voteNum, groupNum, groupName, lastVoteTime)
	local o = Clone(m)

	o:Init(cid, voteNum, groupNum, groupName, lastVoteTime)

	return o
end

function m:Init(cid, voteNum, groupNum, groupName, lastVoteTime)
	self.cid = cid
	self.voteNum = voteNum
	self.groupNum = groupNum
	self.groupName = groupName
	self.lastVoteTime = lastVoteTime
end

return m
