-- chunkname: @modules/logic/necrologiststory/model/NecrologistV3A7MO.lua

module("modules.logic.necrologiststory.model.NecrologistV3A7MO", package.seeall)

local NecrologistV3A7MO = class("NecrologistV3A7MO", NecrologistStoryGameBaseMO)

function NecrologistV3A7MO:getLevelState(levelId)
	local levelConfig = NecrologistStoryV3A7Config.instance:getBaseConfig(levelId)

	return self:getStoryState(levelConfig.storyId)
end

function NecrologistV3A7MO:allLevelIsFinish()
	local baseList = NecrologistStoryV3A7Config.instance:getBaseList()

	for i = 1, #baseList do
		local levelConfig = baseList[i]
		local state = self:getStoryState(levelConfig.storyId)

		if state ~= NecrologistStoryEnum.StoryState.Finish then
			return false
		end
	end

	return true
end

function NecrologistV3A7MO:levelIsFinish(levelId)
	local state = self:getLevelState(levelId)

	return state == NecrologistStoryEnum.StoryState.Finish
end

function NecrologistV3A7MO:isFirstSpLevel(levelId)
	return levelId == NecrologistStoryEnum.V3A7SpLevelId.Sp1
end

function NecrologistV3A7MO:isLastSpLevel(levelId)
	return levelId == NecrologistStoryEnum.V3A7SpLevelId.Sp2
end

function NecrologistV3A7MO:getLastUnLockLevel()
	local baseList = NecrologistStoryV3A7Config.instance:getBaseList()
	local lastUnLockLevelId = baseList[1].id

	for i = 1, #baseList do
		local levelConfig = baseList[i]
		local state = self:getStoryState(levelConfig.storyId)

		if state == NecrologistStoryEnum.StoryState.Lock then
			return lastUnLockLevelId
		else
			lastUnLockLevelId = levelConfig.id
		end
	end

	return lastUnLockLevelId
end

function NecrologistV3A7MO:getLastFinishLevel()
	local baseList = NecrologistStoryV3A7Config.instance:getBaseList()
	local lastFinishLevelId

	for i = 1, #baseList do
		local levelConfig = baseList[i]
		local state = self:getStoryState(levelConfig.storyId)

		if state == NecrologistStoryEnum.StoryState.Finish then
			return lastFinishLevelId
		else
			lastFinishLevelId = levelConfig.id
		end
	end

	return lastFinishLevelId
end

function NecrologistV3A7MO:getNextLockLevel(levelId)
	local baseList = NecrologistStoryV3A7Config.instance:getBaseList()

	for i = 1, #baseList do
		local levelConfig = baseList[i]

		if levelConfig.id == levelId and baseList[i + 1] ~= nil then
			return baseList[i + 1].id
		end
	end

	return nil
end

return NecrologistV3A7MO
