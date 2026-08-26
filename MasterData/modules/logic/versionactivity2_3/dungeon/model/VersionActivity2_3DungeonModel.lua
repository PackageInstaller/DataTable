-- chunkname: @modules/logic/versionactivity2_3/dungeon/model/VersionActivity2_3DungeonModel.lua

module("modules.logic.versionactivity2_3.dungeon.model.VersionActivity2_3DungeonModel", package.seeall)

local VersionActivity2_3DungeonModel = class("VersionActivity2_3DungeonModel", BaseModel)

function VersionActivity2_3DungeonModel:onInit()
	return
end

function VersionActivity2_3DungeonModel:reInit()
	self:init()
end

function VersionActivity2_3DungeonModel:init()
	self:setLastEpisodeId()
	self:setShowInteractView()
end

function VersionActivity2_3DungeonModel:setLastEpisodeId(episodeId)
	self.lastEpisodeId = episodeId
end

function VersionActivity2_3DungeonModel:getLastEpisodeId()
	return self.lastEpisodeId
end

function VersionActivity2_3DungeonModel:setShowInteractView(isShow)
	self.isShowInteractView = isShow
end

function VersionActivity2_3DungeonModel:checkIsShowInteractView()
	return self.isShowInteractView
end

function VersionActivity2_3DungeonModel:setIsNotShowNewElement(isNotShow)
	self.notShowNewElement = isNotShow
end

function VersionActivity2_3DungeonModel:isNotShowNewElement()
	return self.notShowNewElement
end

function VersionActivity2_3DungeonModel:setMapNeedTweenState(needState)
	self.isMapNeedTween = needState
end

function VersionActivity2_3DungeonModel:getMapNeedTweenState()
	return self.isMapNeedTween
end

function VersionActivity2_3DungeonModel:isUnlockAct165Btn()
	local act165Id = Activity165Model.instance:getActivityId()
	local actConfig = ActivityConfig.instance:getActivityCo(act165Id)

	if actConfig then
		local openConfig = OpenConfig.instance:getOpenCo(actConfig.openId)

		if openConfig then
			local isUnlock = OpenModel.instance:isFunctionUnlock(actConfig.openId)
			local hasUnlockStory = Activity165Model.instance:hasUnlockStory()

			return isUnlock and hasUnlockStory
		else
			logError("openConfig is not exit: " .. actConfig.openId)
		end
	end

	return false
end

function VersionActivity2_3DungeonModel:getElementCoList(mapId)
	local normalElementCoList = {}
	local allElements = DungeonMapModel.instance:getAllElements()

	for _, elementId in pairs(allElements) do
		local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)
		local mapCo = lua_chapter_map.configDict[elementCo.mapId]

		if mapCo and mapCo.chapterId == VersionActivity2_3DungeonEnum.DungeonChapterId.Story and mapId == elementCo.mapId then
			table.insert(normalElementCoList, elementCo)
		end
	end

	return normalElementCoList
end

function VersionActivity2_3DungeonModel:getElementCoListWithFinish(mapId)
	local finishElementCoList = {}
	local mapAllElementList = self:getAllNormalElementCoList(mapId)

	for _, elementCo in pairs(mapAllElementList) do
		local elementId = elementCo.id
		local mapCo = lua_chapter_map.configDict[elementCo.mapId]

		if mapCo and mapCo.chapterId == VersionActivity2_3DungeonEnum.DungeonChapterId.Story then
			local isFinish = DungeonMapModel.instance:elementIsFinished(elementId)
			local elementData = DungeonMapModel.instance:getElementById(elementId)

			if mapId == elementCo.mapId and isFinish and not elementData then
				table.insert(finishElementCoList, elementCo)
			end
		end
	end

	return finishElementCoList, mapAllElementList
end

function VersionActivity2_3DungeonModel:getAllNormalElementCoList(mapId)
	local elements = {}
	local mapAllElementList = DungeonConfig.instance:getMapElements(mapId)

	if mapAllElementList then
		for _, elementCo in pairs(mapAllElementList) do
			table.insert(elements, elementCo)
		end
	end

	return elements
end

function VersionActivity2_3DungeonModel:setDungeonBaseMo(dungeonMo)
	self.actDungeonBaseMo = dungeonMo
end

function VersionActivity2_3DungeonModel:getDungeonBaseMo()
	return self.actDungeonBaseMo
end

function VersionActivity2_3DungeonModel:getInitEpisodeId()
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity2_3DungeonEnum.DungeonChapterId.Story)
	local minUnlockEpisodeId = 0
	local maxBattleEpisodeId = 0

	for _, epCo in ipairs(episodeList) do
		local isUnlock = DungeonModel.instance:isUnlock(epCo)
		local isBattleEpisode = DungeonModel.instance.isBattleEpisode(epCo)

		if isBattleEpisode then
			maxBattleEpisodeId = maxBattleEpisodeId > epCo.id and maxBattleEpisodeId or epCo.id
		end

		if isUnlock and minUnlockEpisodeId < epCo.id then
			minUnlockEpisodeId = epCo.id
		end
	end

	local isChapterPass = DungeonModel.instance:chapterIsPass(VersionActivity2_3DungeonEnum.DungeonChapterId.Story)

	if isChapterPass then
		minUnlockEpisodeId = maxBattleEpisodeId
	end

	return minUnlockEpisodeId
end

function VersionActivity2_3DungeonModel:checkStoryCanUnlock(elementId)
	local unlockStoryCo
	local actId = Activity165Model.instance:getActivityId()
	local storyList = Activity165Config.instance:getAllStoryCoList(actId)

	for _, storyCo in ipairs(storyList) do
		local elementList = Activity165Config.instance:getStoryElements(actId, storyCo.storyId)
		local finalElement = elementList[#elementList]

		if finalElement == elementId then
			unlockStoryCo = storyCo

			break
		end
	end

	return unlockStoryCo
end

function VersionActivity2_3DungeonModel:getUnFinishStoryElements()
	local unfinishStoryElementList = {}
	local unfinishElements = DungeonMapModel.instance:getAllElements()
	local allStoryElements = Activity165Model.instance:getAllElements()

	for _, elementId in pairs(unfinishElements) do
		if LuaUtil.tableContains(allStoryElements, elementId) then
			table.insert(unfinishStoryElementList, elementId)
		end
	end

	return unfinishStoryElementList
end

function VersionActivity2_3DungeonModel:checkAndGetUnfinishStoryElementCo(mapId)
	local unfinishElementCo
	local mapAllElementCoList = DungeonConfig.instance:getMapElements(mapId) or {}
	local unfinishStoryElementList = self:getUnFinishStoryElements()

	for _, elementCo in ipairs(mapAllElementCoList) do
		if LuaUtil.tableContains(unfinishStoryElementList, elementCo.id) then
			unfinishElementCo = elementCo

			break
		end
	end

	return unfinishElementCo
end

VersionActivity2_3DungeonModel.instance = VersionActivity2_3DungeonModel.New()

return VersionActivity2_3DungeonModel
