-- chunkname: @IQIGame\\Module\\TownLibrary\\TownLibraryMonsterData.lua

TownLibraryMonsterData = {
	unlockMonster = {}
}

function TownLibraryMonsterData.New(cfgID, isLock, unlockMonster)
	local o = Clone(TownLibraryMonsterData)

	o:Init(cfgID, isLock, unlockMonster)

	return o
end

function TownLibraryMonsterData:Init(cfgID, isLock, unlockMonster)
	self.cfgID = cfgID
	self.cfgInfo = CfgTownMonsterBookTable[cfgID]
	self.isLock = isLock
	self.unlockMonster = unlockMonster
end

function TownLibraryMonsterData:GetLockMonsterResData(resID)
	for i, v in pairs(self.unlockMonster) do
		if v.cfgID == resID then
			return v
		end
	end

	return nil
end

function TownLibraryMonsterData:GetEntryAndMax()
	local maxNum = 0

	for i, v in pairsCfg(CfgTownMonsterBookResTable) do
		if v.TownMonsterID == self.cfgID then
			maxNum = maxNum + 1
		end
	end

	return maxNum
end

function TownLibraryMonsterData:GetUnlockEntryNum()
	return #self.unlockMonster
end

function TownLibraryMonsterData:UpdateReward(resCid, num, top)
	for i, v in pairs(self.unlockMonster) do
		if v.cfgID == resCid then
			v.rewards[num] = top
		end
	end
end

function TownLibraryMonsterData:IsGetReward()
	for i, v in pairs(self.unlockMonster) do
		if v:IsGetReward() == true then
			return true
		end
	end

	return false
end

return TownLibraryMonsterData
