-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/mo/RogueStateInfoMO.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueStateInfoMO", package.seeall)

local RogueStateInfoMO = pureTable("RogueStateInfoMO")

function RogueStateInfoMO:init(info)
	self.activityId = info.activityId
	self.start = info.start
	self.weekScore = info.weekScore
	self.totalScore = info.totalScore
	self.scoreLimit = info.scoreLimit
	self.stage = info.stage
	self.nextStageSecond = info.nextStageSecond
	self.difficulty = info.difficulty
	self.layer = info.layer
	self.hasCollections = {}

	for i, v in ipairs(info.hasCollections) do
		table.insert(self.hasCollections, v)
	end

	self.unlockCollections = {}

	for i, v in ipairs(info.unlockCollections) do
		table.insert(self.unlockCollections, v)
	end

	self.getRewards = {}

	for i, v in ipairs(info.getRewards) do
		table.insert(self.getRewards, v)
	end

	self.passDifficulty = {}

	for i, v in ipairs(info.passDifficulty) do
		table.insert(self.passDifficulty, v)
	end

	self:updateUnlockCollectionsNew(info.unlockCollectionsNew)

	self.lastGroup = RogueGroupInfoMO.New()

	self.lastGroup:init(info.lastGroup)

	self.lastBackupGroup = RogueGroupInfoMO.New()

	self.lastBackupGroup:init(info.lastBackupGroup)
end

function RogueStateInfoMO:getLastGroupInfo(backupNum)
	local heroList = {}
	local equips = {}

	backupNum = backupNum or 0

	tabletool.addValues(heroList, self.lastGroup.heroList)
	tabletool.addValues(equips, self.lastGroup.equips)

	for i, v in ipairs(self.lastBackupGroup.heroList) do
		if i <= backupNum then
			table.insert(heroList, v)
		end
	end

	for i, v in ipairs(self.lastBackupGroup.equips) do
		if i <= backupNum then
			table.insert(equips, v)
		end
	end

	local equipsArray = {}

	for i, v in ipairs(equips) do
		equipsArray[i - 1] = v
		v.index = i - 1
	end

	return heroList, equipsArray
end

function RogueStateInfoMO:isStart()
	return self.start
end

function RogueStateInfoMO:updateUnlockCollectionsNew(unlockCollectionsNew)
	self.unlockCollectionsNew = {}

	for _, collectionId in ipairs(unlockCollectionsNew) do
		self.unlockCollectionsNew[collectionId] = true
	end
end

return RogueStateInfoMO
