-- chunkname: @IQIGame\\Module\\CommandChallenge\\CommandChallengeData.lua

local m = {
	pass = false
}

function m.New(cid, pass)
	local o = Clone(m)

	o:Init(cid, pass)

	return o
end

function m:Init(cid, pass)
	self.cid = cid
	self.pass = pass
end

function m:GetConfig()
	return CfgCommandChallengeLayerTable[self.cid]
end

return m
