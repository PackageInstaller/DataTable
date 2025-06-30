-- chunkname: @IQIGame\\Module\\TownLibrary\\TownLibraryEventData.lua

TownLibraryEventData = {
	unlockEvents = {}
}

function TownLibraryEventData.New(cfgID, isLock, unlockEvent, alienRewards)
	local o = Clone(TownLibraryEventData)

	o:Init(cfgID, isLock, unlockEvent, alienRewards)

	return o
end

function TownLibraryEventData:Init(cfgID, isLock, unlockEvent, alienRewards)
	self.cfgID = cfgID
	self.cfgInfo = CfgTownAlienEventBookTable[cfgID]
	self.isLock = isLock
	self.unlockEvents = unlockEvent
	self.alienRewards = alienRewards
end

function TownLibraryEventData:GetEntryAndMax()
	local maxNum = 0

	for i, v in pairsCfg(CfgTownAlienEventBookResTable) do
		if v.TownAlienEventID == self.cfgID then
			maxNum = maxNum + 1
		end
	end

	return maxNum
end

function TownLibraryEventData:GetUnlockEntryNum()
	return #self.unlockEvents
end

function TownLibraryEventData:UpdateReward(index, top)
	self.alienRewards[index] = top
end

function TownLibraryEventData:IsGetReward()
	local unlockNum = self:GetUnlockEntryNum()

	for i, v in pairs(self.cfgInfo.CollectTime) do
		if v <= unlockNum and (self.alienRewards[i - 1] == nil or self.alienRewards[i - 1] == false) then
			return true
		end
	end

	return false
end

function TownLibraryEventData:GetRewardState(index)
	local state = 0
	local have = self:GetUnlockEntryNum()
	local count = self.cfgInfo.CollectTime[index]

	state = have < count and 1 or self.alienRewards[index - 1] == true and 3 or 2

	return state
end

function TownLibraryEventData:IsUnlockRes(resCid)
	for i, v in pairs(self.unlockEvents) do
		if v.isLock and v.cfgID == resCid then
			return true
		end
	end

	return false
end

return TownLibraryEventData
