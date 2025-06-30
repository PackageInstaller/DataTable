-- chunkname: @IQIGame\\Module\\TownLibrary\\TownLibraryStoryData.lua

TownLibraryStoryData = {}

function TownLibraryStoryData.New(storyType, cfgID, storyRes)
	local o = Clone(TownLibraryStoryData)

	o:Init(storyType, cfgID, storyRes)

	return o
end

function TownLibraryStoryData:Init(storyType, cfgID, storyRes)
	self.storyType = storyType
	self.cfgID = cfgID
	self.storyResTab = storyRes
end

function TownLibraryStoryData:IsLock()
	if self.storyType == Constant.LibraryStoryType.TownStory then
		for k, v in pairs(self.storyResTab) do
			if k == Constant.LibraryStoryResType.TownResMainType or k == Constant.LibraryStoryResType.TownResBranchType then
				for i, resValue in pairs(v) do
					if resValue.isLock then
						return true
					end
				end
			end
		end
	elseif self.storyType == Constant.LibraryStoryType.SoulStory then
		for k, v in pairs(self.storyResTab) do
			if k == Constant.LibraryStoryResType.SoulShopResType or k == Constant.LibraryStoryResType.SoulNewStoryResType or k == Constant.LibraryStoryResType.SoulDatingResType then
				for i, resValue in pairs(v) do
					if resValue.isLock then
						return true
					end
				end
			end
		end
	elseif self.storyType == Constant.LibraryStoryType.NPCStory then
		for k, v in pairs(self.storyResTab) do
			if k == Constant.LibraryStoryResType.NpcShopResType or k == Constant.LibraryStoryResType.NpcResBranchType then
				for i, resValue in pairs(v) do
					if resValue.isLock then
						return true
					end
				end
			end
		end
	elseif self.storyType == Constant.LibraryStoryType.MazeStory then
		for k, v in pairs(self.storyResTab) do
			if k == Constant.LibraryStoryResType.MazeResType then
				for i, resValue in pairs(v) do
					if resValue.isLock then
						return true
					end
				end
			end
		end
	elseif self.storyType == Constant.LibraryStoryType.ActionStory then
		for k, v in pairs(self.storyResTab) do
			if k == Constant.LibraryStoryResType.ActionStoryMainType or k == Constant.LibraryStoryResType.ActionStoryBranchType then
				for i, resValue in pairs(v) do
					if resValue.isLock then
						return true
					end
				end
			end
		end
	end

	return false
end

function TownLibraryStoryData:GetUnlockEntryNum()
	local num = 0

	if self.storyType then
		for i, resDataTab in pairs(self.storyResTab) do
			for j, v in pairs(resDataTab) do
				if v.isLock then
					num = num + 1
				end
			end
		end
	end

	return num
end

function TownLibraryStoryData:GetEntryAndMax()
	local maxNum = 0

	if self.storyType then
		for i, resDataTab in pairs(self.storyResTab) do
			for j, v in pairs(resDataTab) do
				maxNum = maxNum + 1
			end
		end
	end

	return maxNum
end

function TownLibraryStoryData:GetStoryResTab(storyResType)
	local tab = self.storyResTab[storyResType]

	if tab == nil then
		tab = {}
	end

	table.sort(tab, function(a, b)
		return a.cfgID < b.cfgID
	end)

	return tab
end

function TownLibraryStoryData:GetResNumByResType(resType)
	local resTab = self:GetStoryResTab(resType)
	local num = 0
	local maxNum = #resTab

	for i, v in pairs(resTab) do
		if v.isLock then
			num = num + 1
		end
	end

	return num, maxNum
end

return TownLibraryStoryData
