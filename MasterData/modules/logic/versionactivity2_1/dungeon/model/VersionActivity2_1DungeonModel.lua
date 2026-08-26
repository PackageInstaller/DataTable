-- chunkname: @modules/logic/versionactivity2_1/dungeon/model/VersionActivity2_1DungeonModel.lua

module("modules.logic.versionactivity2_1.dungeon.model.VersionActivity2_1DungeonModel", package.seeall)

local VersionActivity2_1DungeonModel = class("VersionActivity2_1DungeonModel", BaseModel)

function VersionActivity2_1DungeonModel:onInit()
	return
end

function VersionActivity2_1DungeonModel:reInit()
	self:init()
end

function VersionActivity2_1DungeonModel:init()
	self:setLastEpisodeId()
	self:setShowInteractView()
end

function VersionActivity2_1DungeonModel:setLastEpisodeId(episodeId)
	self.lastEpisodeId = episodeId
end

function VersionActivity2_1DungeonModel:getLastEpisodeId()
	return self.lastEpisodeId
end

function VersionActivity2_1DungeonModel:setShowInteractView(isShow)
	self.isShowInteractView = isShow
end

function VersionActivity2_1DungeonModel:checkIsShowInteractView()
	return self.isShowInteractView
end

function VersionActivity2_1DungeonModel:setIsNotShowNewElement(isNotShow)
	self.notShowNewElement = isNotShow
end

function VersionActivity2_1DungeonModel:isNotShowNewElement()
	return self.notShowNewElement
end

function VersionActivity2_1DungeonModel:setMapNeedTweenState(needState)
	self.isMapNeedTween = needState
end

function VersionActivity2_1DungeonModel:getMapNeedTweenState()
	return self.isMapNeedTween
end

function VersionActivity2_1DungeonModel:isUnlockAct165Btn()
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

function VersionActivity2_1DungeonModel:getElementCoList(mapId)
	local normalElementCoList = {}
	local allElements = DungeonMapModel.instance:getAllElements()

	for _, elementId in pairs(allElements) do
		local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)
		local mapCo = lua_chapter_map.configDict[elementCo.mapId]

		if mapCo and mapCo.chapterId == VersionActivity2_1DungeonEnum.DungeonChapterId.Story and mapId == elementCo.mapId then
			table.insert(normalElementCoList, elementCo)
		end
	end

	return normalElementCoList
end

function VersionActivity2_1DungeonModel:getElementCoListWithFinish(mapId)
	local finishElementCoList = {}
	local mapAllElementList = self:getAllNormalElementCoList(mapId)

	for _, elementCo in pairs(mapAllElementList) do
		local elementId = elementCo.id
		local mapCo = lua_chapter_map.configDict[elementCo.mapId]

		if mapCo and mapCo.chapterId == VersionActivity2_1DungeonEnum.DungeonChapterId.Story then
			local isFinish = DungeonMapModel.instance:elementIsFinished(elementId)
			local elementData = DungeonMapModel.instance:getElementById(elementId)

			if mapId == elementCo.mapId and isFinish and not elementData then
				table.insert(finishElementCoList, elementCo)
			end
		end
	end

	return finishElementCoList, mapAllElementList
end

function VersionActivity2_1DungeonModel:getAllNormalElementCoList(mapId)
	local elements = {}
	local mapAllElementList = DungeonConfig.instance:getMapElements(mapId)
	local act165Elements = Activity165Model.instance:getAllElements()

	if act165Elements and mapAllElementList then
		for _, elementCo in pairs(mapAllElementList) do
			if not LuaUtil.tableContains(act165Elements, elementCo.id) then
				table.insert(elements, elementCo)
			end
		end
	end

	return elements
end

function VersionActivity2_1DungeonModel:setDungeonBaseMo(dungeonMo)
	self.actDungeonBaseMo = dungeonMo
end

function VersionActivity2_1DungeonModel:getDungeonBaseMo()
	return self.actDungeonBaseMo
end

function VersionActivity2_1DungeonModel:getUnFinishElementEpisodeId()
	local MinUnFinishEpisodeId = 0
	local unFinishElementList = DungeonMapModel.instance:getAllElements()

	for _, elementId in pairs(unFinishElementList) do
		local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)
		local mapCo = lua_chapter_map.configDict[elementCo.mapId]

		if mapCo and mapCo.chapterId == VersionActivity2_1DungeonEnum.DungeonChapterId.Story then
			local episodeId = DungeonConfig.instance:getEpisodeIdByMapCo(mapCo)

			if episodeId < MinUnFinishEpisodeId or MinUnFinishEpisodeId == 0 then
				MinUnFinishEpisodeId = episodeId
			end
		end
	end

	return MinUnFinishEpisodeId
end

function VersionActivity2_1DungeonModel:getFinishWithFragmentElementList(mapCo)
	local finishWithFragmentElementList = {}
	local mapElementList = DungeonConfig.instance:getMapElements(mapCo.id) or {}

	for _, elementCo in ipairs(mapElementList) do
		local isFinish = DungeonMapModel.instance:elementIsFinished(elementCo.id)

		if isFinish and elementCo.fragment > 0 then
			table.insert(finishWithFragmentElementList, elementCo)
		end
	end

	return finishWithFragmentElementList
end

function VersionActivity2_1DungeonModel:checkStoryCanUnlock(elementId)
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

function VersionActivity2_1DungeonModel:getUnFinishStoryElements()
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

function VersionActivity2_1DungeonModel:checkAndGetUnfinishStoryElementCo(mapId)
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

VersionActivity2_1DungeonModel.instance = VersionActivity2_1DungeonModel.New()

return VersionActivity2_1DungeonModel
