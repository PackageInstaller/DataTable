-- chunkname: @IQIGame\\Module\\Memory\\MemoryStoryInfo.lua

MemoryStoryInfo = {
	arrChapterList = {}
}

function MemoryStoryInfo.New()
	local cloneObj = Clone(MemoryStoryInfo)

	return cloneObj
end

function MemoryStoryInfo:Initialize(cid)
	self.cid = cid
	self.cfgSoulNewStory = CfgSoulNewStoryTable[self.cid]
	self.isUnlocked = false
end

function MemoryStoryInfo:SetData(soulNewStoryPOD)
	self.arrChapterList = soulNewStoryPOD.unlockChapters

	if self.arrChapterList == nil then
		self.arrChapterList = {}
	end

	self.isUnlocked = true
end

function MemoryStoryInfo:StoryState()
	local state = 3
	local isGetReward = self:IsGetReward()

	if isGetReward then
		state = 1
	else
		local isLook = self:IsLook(1)

		if isLook then
			state = 2
		end
	end

	return state
end

function MemoryStoryInfo:IsLook(index)
	if self.isUnlocked and self.arrChapterList[index] == false then
		return true
	end

	return false
end

function MemoryStoryInfo:GetChapterData()
	local num = #self.arrChapterList
	local totalNum = 0

	for i, v in pairs(self.cfgSoulNewStory.ChapterDialog) do
		if v ~= nil and tonumber(v) > 0 then
			totalNum = totalNum + 1
		end
	end

	return num, totalNum
end

function MemoryStoryInfo:IsComplete()
	local len = #self.arrChapterList
	local metaLen = 0

	for i, v in pairs(self.cfgSoulNewStory.ChapterDialog) do
		if v ~= nil and tonumber(v) > 0 then
			metaLen = metaLen + 1
		end
	end

	return len == metaLen
end

function MemoryStoryInfo:IsGetReward()
	local len = #self.arrChapterList
	local metaLen = 0

	for i, v in pairs(self.cfgSoulNewStory.ChapterDialog) do
		if v ~= nil and tonumber(v) > 0 and self.arrChapterList[i] == true then
			metaLen = metaLen + 1
		end
	end

	return len == metaLen
end
