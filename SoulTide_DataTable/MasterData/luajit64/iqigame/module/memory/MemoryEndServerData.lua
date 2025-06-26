-- chunkname: @IQIGame\\Module\\Memory\\MemoryEndServerData.lua

MemoryEndServerData = {
	bigTitle = ""
}

function MemoryEndServerData.New()
	local o = Clone(MemoryEndServerData)

	return o
end

function MemoryEndServerData:Init(soulNewStory, getItems, beginFavor, endFavor, beginFavorLv, endFavorLv)
	self.soulNewStoryPOD = soulNewStory
	self.soulID = CfgSoulNewStoryTable[soulNewStory.cid].SoulId

	self:__Init(getItems, beginFavor, endFavor, beginFavorLv, endFavorLv)
end

function MemoryEndServerData:InitDating(bigTitle, littleTitle, soulId, getItems, beginFavor, endFavor, beginFavorLv, endFavorLv)
	self.soulID = soulId
	self.littleTitle = littleTitle
	self.bigTitle = bigTitle

	self:__Init(getItems, beginFavor, endFavor, beginFavorLv, endFavorLv)
end

function MemoryEndServerData:__Init(getItems, beginFavor, endFavor, beginFavorLv, endFavorLv)
	local newReward = {}
	local z = 1

	for i, v in pairs(getItems) do
		if CfgItemTable[v.cid].IsRewardShow then
			newReward[z] = v
			z = z + 1
		end
	end

	self.getItems = newReward
	self.beginFavor = beginFavor
	self.beginFavorLevel = beginFavorLv
	self.endFavor = endFavor
	self.endFavorLevel = endFavorLv
	self.soulData = SoulModule.GetSoulData(self.soulID)

	local maxLv = self.soulData.favorMaxLv

	if maxLv < self.beginFavorLevel then
		self.beginFavorLevel = maxLv
	end

	if maxLv < self.endFavorLevel then
		self.endFavorLevel = maxLv
	end

	if self.endFavorLevel == maxLv and self.beginFavorLevel == maxLv and beginFavor == endFavor then
		self.beginPer = 1
		self.endExp = beginFavor
		self.endExpMax = endFavor
		self.endPer = 1
	else
		self.beginPer = self.beginFavor / self.soulData:GetSoulFavor(self.beginFavorLevel)
		self.endExp = self.endFavor
		self.endExpMax = self.soulData:GetSoulFavor(self.endFavorLevel)
		self.endPer = self.endExp / self.endExpMax
	end

	if self.beginFavorLevel == self.endFavorLevel then
		self.addExp = self.endFavor - self.beginFavor
	else
		local exp = 0

		for i = self.beginFavorLevel, self.endFavorLevel - 1 do
			exp = exp + self.soulData:GetSoulFavor(i)
		end

		self.addExp = exp - self.beginFavor + self.endFavor
	end
end
