-- chunkname: @IQIGame\\Module\\TownLibrary\\TownLibraryNPCData.lua

TownLibraryNPCData = {
	entry = {},
	rewards = {}
}

function TownLibraryNPCData.New(cfgID, isLock, LibraryNpcPOD)
	local o = Clone(TownLibraryNPCData)

	o:Init(cfgID, isLock, LibraryNpcPOD)

	return o
end

function TownLibraryNPCData:Init(cfgID, isLock, LibraryNpcPOD)
	self.cfgID = cfgID
	self.cfgInfo = CfgTownNpcBookTable[cfgID]
	self.isLock = isLock

	if LibraryNpcPOD then
		self.entry = LibraryNpcPOD.entrys
		self.rewards = LibraryNpcPOD.rewards
	end
end

function TownLibraryNPCData:GetResByType(type)
	local tab = {}

	for i, v in pairsCfg(CfgTownNpcBookResTable) do
		if v.NpcID == self.cfgID and v.EntryId == type then
			v.isLock = table.indexOf(self.entry, v.Id) ~= -1

			table.insert(tab, v)
		end
	end

	return tab
end

function TownLibraryNPCData:GetEntryAndMax()
	local maxNum = 0

	for i, v in pairsCfg(CfgTownNpcBookResTable) do
		if v.NpcID == self.cfgID then
			maxNum = maxNum + 1
		end
	end

	return maxNum
end

function TownLibraryNPCData:GetUnlockEntryNum()
	local unLockNum = 0

	for i, v in pairsCfg(CfgTownNpcBookResTable) do
		if v.NpcID == self.cfgID and table.indexOf(self.entry, v.Id) ~= -1 then
			unLockNum = unLockNum + 1
		end
	end

	return unLockNum
end

function TownLibraryNPCData:GetRewardState(index)
	local state = 0
	local have = self:GetUnlockEntryNum()
	local count = self.cfgInfo.CollectTime[index]

	state = have < count and 1 or self.rewards[index - 1] == true and 3 or 2

	return state
end

function TownLibraryNPCData:IsGetReward()
	for k, v in pairs(self.rewards) do
		if v == false then
			return true
		end
	end

	return false
end

return TownLibraryNPCData
