-- chunkname: @modules/logic/teach/model/TeachNoteModel.lua

module("modules.logic.teach.model.TeachNoteModel", package.seeall)

local TeachNoteModel = class("TeachNoteModel", BaseModel)

function TeachNoteModel:onInit()
	self._topicId = 0
	self._topicIndex = 0
	self._teachNoteInfos = {}
	self._isJumpEnter = false
end

function TeachNoteModel:reInit()
	self._topicId = 0
	self._topicIndex = 0
	self._teachNoteInfos = {}
	self._isJumpEnter = false
end

function TeachNoteModel:setTeachNoticeTopicId(id, index)
	self._topicId = id
	self._topicIndex = index
end

function TeachNoteModel:getTeachNoticeTopicId()
	return self._topicId, self._topicIndex
end

function TeachNoteModel:getTopicLevelCos(topicId)
	local cos = {}
	local levelConfig = TeachNoteConfig.instance:getInstructionLevelCos()

	for _, v in pairs(levelConfig) do
		if v.topicId == topicId then
			table.insert(cos, v)
		end
	end

	table.sort(cos, function(a, b)
		local aUnlock = TeachNoteModel.instance:isLevelUnlock(a.id)
		local bUnlock = TeachNoteModel.instance:isLevelUnlock(b.id)

		if aUnlock and not bUnlock then
			return true
		elseif not aUnlock and bUnlock then
			return false
		end

		return a.id < b.id
	end)

	return cos
end

function TeachNoteModel:setTeachNoteInfo(info)
	self._teachNoteInfos = TeachNoteInfoMo.New()

	self._teachNoteInfos:init(info)
end

function TeachNoteModel:isFinalRewardGet()
	return self._teachNoteInfos.getFinalReward
end

function TeachNoteModel:getNewOpenIndex()
	local topicIndex = 0
	local newTopics = self:getNewOpenTopics()

	if #newTopics > 0 then
		topicIndex = newTopics[#newTopics]
	end

	local levelIndex = 0
	local newLvs = self:getNewOpenTopicLevels(topicIndex)

	if #newLvs > 0 then
		local id = newLvs[#newLvs]
		local lvIds = self:getTopicLevelCos(topicIndex)

		for k, v in ipairs(lvIds) do
			if v.id == id then
				levelIndex = math.floor(0.5 * (k - 1))
			end
		end
	end

	return topicIndex, levelIndex
end

function TeachNoteModel:isEpisodeOpen(episodeId)
	local lvCos = TeachNoteConfig.instance:getInstructionLevelCos()

	for _, v in pairs(lvCos) do
		if v.episodeId == episodeId then
			for _, id in pairs(self._teachNoteInfos.openIds) do
				if v.id == id then
					return true
				end
			end
		end
	end

	return false
end

function TeachNoteModel:isTopicNew(topicId)
	if not self:isTopicUnlock(topicId) then
		return false
	end

	local openIds = {}

	for _, id in pairs(self._teachNoteInfos.openIds) do
		local openTopic = TeachNoteConfig.instance:getInstructionLevelCO(id).topicId

		if openTopic == topicId then
			table.insert(openIds, id)
		end
	end

	return #openIds < 1
end

function TeachNoteModel:getNewOpenTopics()
	local topicIds = {}
	local cos = TeachNoteConfig.instance:getInstructionTopicCos()

	for _, v in pairs(cos) do
		if self:isTopicNew(v.id) then
			table.insert(topicIds, v.id)
		end
	end

	table.sort(topicIds)

	return topicIds
end

function TeachNoteModel:getNewOpenTopicLevels(topicId)
	local newLvs = self:getNewOpenLevels()
	local lvs = {}

	for _, v in pairs(newLvs) do
		local co = TeachNoteConfig.instance:getInstructionLevelCO(v)

		if co.topicId == topicId then
			table.insert(lvs, v)
		end
	end

	table.sort(lvs)

	return lvs
end

function TeachNoteModel:getNewOpenLevels()
	local levels = {}
	local lvCos = TeachNoteConfig.instance:getInstructionLevelCos()

	if #self._teachNoteInfos.openIds == 0 then
		return self._teachNoteInfos.unlockIds
	else
		for _, id in pairs(self._teachNoteInfos.unlockIds) do
			local exist = false

			for _, co in pairs(self._teachNoteInfos.openIds) do
				if id == co then
					exist = true
				end
			end

			if not exist then
				table.insert(levels, id)
			end
		end
	end

	return levels
end

function TeachNoteModel:isLevelNewUnlock(levelId)
	local newLvs = self:getNewOpenLevels()

	for _, v in pairs(newLvs) do
		if v == levelId then
			return true
		end
	end

	return false
end

function TeachNoteModel:_getUnlockLevelsByTopicId(topicId)
	local ids = {}
	local lvCos = self:getTopicLevelCos(topicId)

	for _, co in pairs(lvCos) do
		if self:isLevelUnlock(co.id) then
			table.insert(ids, co.id)
		end
	end

	return ids
end

function TeachNoteModel:isTopicRewardGet(topicId)
	for _, v in pairs(self._teachNoteInfos.getRewardIds) do
		if v == topicId then
			return true
		end
	end

	return false
end

function TeachNoteModel:isTopicUnlock(topicId)
	local lvCo = TeachNoteConfig.instance:getInstructionLevelCos()

	for _, v in pairs(lvCo) do
		if v.topicId == topicId and self:isLevelUnlock(v.id) then
			return true
		end
	end

	return false
end

function TeachNoteModel:isRewardCouldGet(topicId)
	if not self:isTopicUnlock(topicId) then
		return false
	end

	local total = TeachNoteModel.instance:getTeachNoteTopicLevelCount(topicId)
	local finishCount = TeachNoteModel.instance:getTeachNoteTopicFinishedLevelCount(topicId)

	if finishCount == total and not TeachNoteModel.instance:isTopicRewardGet(topicId) then
		return true
	else
		return false
	end
end

function TeachNoteModel:hasRewardCouldGet()
	local lvCo = TeachNoteConfig.instance:getInstructionTopicCos()

	for _, v in pairs(lvCo) do
		if self:isTopicUnlock(v.id) and self:isRewardCouldGet(v.id) then
			return true
		end
	end

	if self:isTeachNoteFinalRewardCouldGet() then
		return true
	end

	return false
end

function TeachNoteModel:isLevelUnlock(levelId)
	for _, v in pairs(self._teachNoteInfos.unlockIds) do
		if v == levelId then
			return true
		end
	end

	return false
end

function TeachNoteModel:isTeachNoteUnlock()
	return self._teachNoteInfos and self._teachNoteInfos.unlockIds and #self._teachNoteInfos.unlockIds > 0 and not self:isFinalRewardGet()
end

function TeachNoteModel:isTeachNoteLevelPass(levelId)
	local episodeId = TeachNoteConfig.instance:getInstructionLevelCO(levelId).episodeId

	return (DungeonModel.instance:hasPassLevel(episodeId))
end

function TeachNoteModel:getTeachNoteTopicUnlockLevelCount(topicId)
	local unlock = 0
	local lvCos = self:getTopicLevelCos(topicId)

	for _, v in pairs(lvCos) do
		if self:isLevelUnlock(v.id) then
			unlock = unlock + 1
		end
	end

	return unlock
end

function TeachNoteModel:getTeachNoteTopicFinishedLevelCount(topicId)
	local count = 0
	local lvCos = self:getTopicLevelCos(topicId)

	for _, v in pairs(lvCos) do
		if self:isTeachNoteLevelPass(v.id) then
			count = count + 1
		end
	end

	return count
end

function TeachNoteModel:getTeachNoteTopicLevelCount(topicId)
	local lvCos = self:getTopicLevelCos(topicId)

	return #lvCos
end

function TeachNoteModel:isTeachNoteChapter(chapterId)
	local topicCos = TeachNoteConfig.instance:getInstructionTopicCos()

	for _, v in pairs(topicCos) do
		if v.chapterId == chapterId then
			return true
		end
	end

	return false
end

function TeachNoteModel:isTeachNoteEpisode(episodeId)
	local lvCos = TeachNoteConfig.instance:getInstructionLevelCos()

	for _, v in pairs(lvCos) do
		if v.episodeId == episodeId then
			return true
		end
	end

	return false
end

function TeachNoteModel:getTeachNoteInstructionLevelCo(episodeId)
	local lvCos = TeachNoteConfig.instance:getInstructionLevelCos()

	for _, v in pairs(lvCos) do
		if v.episodeId == episodeId then
			return v
		end
	end

	return lvCos[101]
end

function TeachNoteModel:getTeachNoteEpisodeTopicId(episodeId)
	local lvCos = TeachNoteConfig.instance:getInstructionLevelCos()

	for _, v in pairs(lvCos) do
		if v.episodeId == episodeId then
			return v.topicId
		end
	end

	return 1
end

function TeachNoteModel:isTeachNoteFinalRewardCouldGet()
	local topicCos = TeachNoteConfig.instance:getInstructionTopicCos()

	for _, v in pairs(topicCos) do
		if not self:isTopicRewardGet(v.id) then
			return false
		end
	end

	return not self:isFinalRewardGet()
end

function TeachNoteModel:isTeachNoteEnterFight()
	return self._isTeachEnter
end

function TeachNoteModel:setTeachNoteEnterFight(teachenter, isdetail)
	self._isTeachEnter = teachenter
	self._isDetailEnter = isdetail
end

function TeachNoteModel:isFinishLevelEnterFight()
	return self._isFinishedEnter
end

function TeachNoteModel:isDetailEnter()
	return self._isDetailEnter
end

function TeachNoteModel:setLevelEnterFightState(state)
	self._isFinishedEnter = state
end

function TeachNoteModel:isJumpEnter()
	return self._isJumpEnter
end

function TeachNoteModel:setJumpEnter(jump)
	self._isJumpEnter = jump
end

function TeachNoteModel:setJumpEpisodeId(id)
	self._jumpEpisodeId = id
end

function TeachNoteModel:getJumpEpisodeId()
	return self._jumpEpisodeId
end

function TeachNoteModel:getAllUnLockRewardCount()
	local topicCos = TeachNoteConfig.instance:getInstructionTopicCos()
	local getCount = 0
	local totalCount = 0

	for _, v in pairs(topicCos) do
		local bonus = string.splitToNumber(TeachNoteConfig.instance:getInstructionTopicCO(v.id).bonus, "#")

		if tabletool.len(bonus) == 3 then
			if self:isTopicRewardGet(v.id) then
				getCount = getCount + bonus[3]
			end

			totalCount = totalCount + bonus[3]
		end
	end

	return getCount, totalCount
end

TeachNoteModel.instance = TeachNoteModel.New()

return TeachNoteModel
