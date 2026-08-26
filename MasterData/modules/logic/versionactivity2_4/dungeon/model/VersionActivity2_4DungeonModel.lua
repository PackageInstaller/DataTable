-- chunkname: @modules/logic/versionactivity2_4/dungeon/model/VersionActivity2_4DungeonModel.lua

module("modules.logic.versionactivity2_4.dungeon.model.VersionActivity2_4DungeonModel", package.seeall)

local VersionActivity2_4DungeonModel = class("VersionActivity2_4DungeonModel", BaseModel)

function VersionActivity2_4DungeonModel:onInit()
	return
end

function VersionActivity2_4DungeonModel:reInit()
	self:init()
end

function VersionActivity2_4DungeonModel:init()
	self:setLastEpisodeId()
	self:setShowInteractView()
end

function VersionActivity2_4DungeonModel:setLastEpisodeId(episodeId)
	self.lastEpisodeId = episodeId
end

function VersionActivity2_4DungeonModel:getLastEpisodeId()
	return self.lastEpisodeId
end

function VersionActivity2_4DungeonModel:setShowInteractView(isShow)
	self.isShowInteractView = isShow
end

function VersionActivity2_4DungeonModel:checkIsShowInteractView()
	return self.isShowInteractView
end

function VersionActivity2_4DungeonModel:setIsNotShowNewElement(isNotShow)
	self.notShowNewElement = isNotShow
end

function VersionActivity2_4DungeonModel:isNotShowNewElement()
	return self.notShowNewElement
end

function VersionActivity2_4DungeonModel:setMapNeedTweenState(needState)
	self.isMapNeedTween = needState
end

function VersionActivity2_4DungeonModel:getMapNeedTweenState()
	return self.isMapNeedTween
end

function VersionActivity2_4DungeonModel:getElementCoList(mapId)
	local normalElementCoList = {}
	local allElements = DungeonMapModel.instance:getAllElements()

	for _, elementId in pairs(allElements) do
		local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)
		local mapCo = lua_chapter_map.configDict[elementCo.mapId]

		if mapCo and mapCo.chapterId == VersionActivity2_4DungeonEnum.DungeonChapterId.Story and mapId == elementCo.mapId then
			table.insert(normalElementCoList, elementCo)
		end
	end

	return normalElementCoList
end

function VersionActivity2_4DungeonModel:getElementCoListWithFinish(mapId)
	local finishElementCoList = {}
	local mapAllElementList = self:getAllNormalElementCoList(mapId)

	for _, elementCo in pairs(mapAllElementList) do
		local elementId = elementCo.id
		local mapCo = lua_chapter_map.configDict[elementCo.mapId]

		if mapCo and mapCo.chapterId == VersionActivity2_4DungeonEnum.DungeonChapterId.Story then
			local isFinish = DungeonMapModel.instance:elementIsFinished(elementId)
			local elementData = DungeonMapModel.instance:getElementById(elementId)

			if mapId == elementCo.mapId and isFinish and not elementData then
				table.insert(finishElementCoList, elementCo)
			end
		end
	end

	return finishElementCoList, mapAllElementList
end

function VersionActivity2_4DungeonModel:getAllNormalElementCoList(mapId)
	local elements = {}
	local mapAllElementList = DungeonConfig.instance:getMapElements(mapId)

	if mapAllElementList then
		for _, elementCo in pairs(mapAllElementList) do
			table.insert(elements, elementCo)
		end
	end

	return elements
end

function VersionActivity2_4DungeonModel:setDungeonBaseMo(dungeonMo)
	self.actDungeonBaseMo = dungeonMo
end

function VersionActivity2_4DungeonModel:getDungeonBaseMo()
	return self.actDungeonBaseMo
end

function VersionActivity2_4DungeonModel:getUnFinishElementEpisodeId()
	local MinUnFinishEpisodeId = 0
	local unFinishElementList = DungeonMapModel.instance:getAllElements()

	for _, elementId in pairs(unFinishElementList) do
		local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)
		local mapCo = lua_chapter_map.configDict[elementCo.mapId]

		if mapCo and mapCo.chapterId == VersionActivity2_4DungeonEnum.DungeonChapterId.Story then
			local episodeId = DungeonConfig.instance:getEpisodeIdByMapCo(mapCo)

			if episodeId < MinUnFinishEpisodeId or MinUnFinishEpisodeId == 0 then
				MinUnFinishEpisodeId = episodeId
			end
		end
	end

	return MinUnFinishEpisodeId
end

function VersionActivity2_4DungeonModel:getFinishWithFragmentElementList(mapCo)
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

function VersionActivity2_4DungeonModel:getUnFinishStoryElements()
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

function VersionActivity2_4DungeonModel:checkAndGetUnfinishStoryElementCo(mapId)
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

VersionActivity2_4DungeonModel.instance = VersionActivity2_4DungeonModel.New()

return VersionActivity2_4DungeonModel
