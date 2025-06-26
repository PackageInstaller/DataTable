-- chunkname: @IQIGame\\Module\\TownLibrary\\TownLibraryMonsterResData.lua

TownLibraryMonsterResData = {}

function TownLibraryMonsterResData.New(cfgID, isLock, libraryMonsterPOD)
	local o = Clone(TownLibraryMonsterResData)

	o:Init(cfgID, isLock, libraryMonsterPOD)

	return o
end

function TownLibraryMonsterResData:Init(cfgID, isLock, libraryMonsterPOD)
	self.cfgID = cfgID
	self.cfgInfo = CfgTownMonsterBookResTable[cfgID]
	self.isLock = isLock

	if libraryMonsterPOD then
		self.count = libraryMonsterPOD.count
		self.rewards = libraryMonsterPOD.rewards
	end
end

function TownLibraryMonsterResData:GetRewardState(index)
	local state = 0
	local maxCount = self.cfgInfo.KillTime[index]

	state = maxCount > self.count and 1 or self.rewards[index - 1] == true and 3 or 2

	return state
end

function TownLibraryMonsterResData:IsGetReward()
	for i = 1, #self.cfgInfo.Reward do
		if self:GetRewardState(i) == 2 then
			return true
		end
	end

	return false
end

return TownLibraryMonsterResData
