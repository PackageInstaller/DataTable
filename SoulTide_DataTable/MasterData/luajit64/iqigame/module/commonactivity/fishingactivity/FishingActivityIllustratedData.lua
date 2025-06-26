-- chunkname: @IQIGame\\Module\\CommonActivity\\FishingActivity\\FishingActivityIllustratedData.lua

local m = {
	captureTimes = 0,
	maxWeight = 0,
	isUnlock = false
}

function m.New(cid, pod)
	local o = Clone(m)

	o:Init(cid, pod)

	return o
end

function m:Init(cid, pod)
	self.cid = cid

	self:Update(pod)
end

function m:Update(fishPOD)
	if fishPOD then
		self.captureTimes = fishPOD.num
		self.maxWeight = fishPOD.weight
	end
end

function m:RefreshUnlock(playerLv)
	local index = playerLv > #self:GetCfgData().FishPower and #self:GetCfgData().FishPower or playerLv

	self.isUnlock = self:GetCfgData().FishPower[index] > 0
end

function m:GetCfgData()
	return CfgFishActiveFishListTable[self.cid]
end

return m
