-- chunkname: @IQIGame\\Module\\TownLibrary\\TownLibraryNewsData.lua

TownLibraryNewsData = {}

function TownLibraryNewsData.New(cfgID, isLock, isRead, isGetReward)
	local o = Clone(TownLibraryNewsData)

	o:Init(cfgID, isLock, isRead, isGetReward)

	return o
end

function TownLibraryNewsData:Init(cfgID, isLock, isRead, isGetReward)
	self.cfgID = cfgID
	self.cfgInfo = CfgTownNewsBookTable[cfgID]
	self.isLock = isLock
	self.isRead = isRead
	self.isGetReward = isGetReward
end

function TownLibraryNewsData:GetRewardState()
	local state = 0

	state = self.isLock == false and 1 or self.isGetReward == true and 3 or 2

	return state
end

function TownLibraryNewsData:IsGetReward()
	if self:GetRewardState() == 2 then
		return true
	end

	return false
end

return TownLibraryNewsData
