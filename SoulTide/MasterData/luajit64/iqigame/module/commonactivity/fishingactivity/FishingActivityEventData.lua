-- chunkname: @IQIGame\\Module\\CommonActivity\\FishingActivity\\FishingActivityEventData.lua

local m = {
	isUnlock = false,
	isGetReward = false
}

function m.New(cid, isUnlock, isGetReward)
	local o = Clone(m)

	o:Init(cid, isUnlock, isGetReward)

	return o
end

function m:Init(cid, isUnlock, isGetReward)
	self.cid = cid
	self.isUnlock = isUnlock
	self.isGetReward = isGetReward
end

function m:GetCfgData()
	return CfgFishActiveEventControlTable[self.cid]
end

function m:CanGetReward()
	if self.isUnlock and not self.isGetReward then
		return true
	end

	return false
end

return m
