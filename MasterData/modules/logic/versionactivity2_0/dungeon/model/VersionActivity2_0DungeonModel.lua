-- chunkname: @modules/logic/versionactivity2_0/dungeon/model/VersionActivity2_0DungeonModel.lua

module("modules.logic.versionactivity2_0.dungeon.model.VersionActivity2_0DungeonModel", package.seeall)

local VersionActivity2_0DungeonModel = class("VersionActivity2_0DungeonModel", BaseModel)

function VersionActivity2_0DungeonModel:onInit()
	return
end

function VersionActivity2_0DungeonModel:reInit()
	self:init()
end

function VersionActivity2_0DungeonModel:init()
	self:setLastEpisodeId()
	self:setShowInteractView()
end

function VersionActivity2_0DungeonModel:setLastEpisodeId(episodeId)
	self.lastEpisodeId = episodeId
end

function VersionActivity2_0DungeonModel:getLastEpisodeId()
	return self.lastEpisodeId
end

function VersionActivity2_0DungeonModel:setShowInteractView(isShow)
	self.isShowInteractView = isShow
end

function VersionActivity2_0DungeonModel:checkIsShowInteractView()
	return self.isShowInteractView
end

function VersionActivity2_0DungeonModel:setIsNotShowNewElement(isNotShow)
	self.notShowNewElement = isNotShow
end

function VersionActivity2_0DungeonModel:isNotShowNewElement()
	return self.notShowNewElement
end

function VersionActivity2_0DungeonModel:setOpenGraffitiEntrance(isOpen)
	self.isOpenGraffitiEntrance = isOpen
end

function VersionActivity2_0DungeonModel:getOpenGraffitiEntranceState()
	return self.isOpenGraffitiEntrance
end

function VersionActivity2_0DungeonModel:setMapNeedTweenState(needState)
	self.isMapNeedTween = needState
end

function VersionActivity2_0DungeonModel:getMapNeedTweenState()
	return self.isMapNeedTween
end

function VersionActivity2_0DungeonModel:setOpeningGraffitiEntrance(isOpening)
	self.isOpeningGraffitiEntrance = isOpening
end

function VersionActivity2_0DungeonModel:getOpeningGraffitiEntranceState()
	return self.isOpeningGraffitiEntrance
end

function VersionActivity2_0DungeonModel:setDraggingMapState(isDraggin)
	self.isDragginMap = isDraggin
end

function VersionActivity2_0DungeonModel:isDraggingMapState()
	return self.isDragginMap
end

function VersionActivity2_0DungeonModel:getGraffitiEntranceUnlockState()
	local graffitiActId = Activity161Model.instance:getActId()
	local actConfig = ActivityConfig.instance:getActivityCo(graffitiActId)

	if actConfig then
		local openConfig = OpenConfig.instance:getOpenCo(actConfig.openId)

		if openConfig then
			return OpenModel.instance:isFunctionUnlock(actConfig.openId)
		else
			logError("openConfig is not exit: " .. actConfig.openId)
		end
	end

	return false
end

function VersionActivity2_0DungeonModel:getElementCoList(mapId)
	local normalElementCoList = {}
	local allElements = DungeonMapModel.instance:getAllElements()

	for _, elementId in pairs(allElements) do
		local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)
		local mapCo = lua_chapter_map.configDict[elementCo.mapId]

		if mapCo and mapCo.chapterId == VersionActivity2_0DungeonEnum.DungeonChapterId.Story and mapId == elementCo.mapId then
			table.insert(normalElementCoList, elementCo)
		end
	end

	return normalElementCoList
end

function VersionActivity2_0DungeonModel:getElementCoListWithFinish(mapId)
	local finishElementCoList = {}
	local mapAllElementList = self:getAllNormalElementCoList(mapId)

	for _, elementCo in pairs(mapAllElementList) do
		local elementId = elementCo.id
		local mapCo = lua_chapter_map.configDict[elementCo.mapId]

		if mapCo and mapCo.chapterId == VersionActivity2_0DungeonEnum.DungeonChapterId.Story then
			local isFinish = DungeonMapModel.instance:elementIsFinished(elementId)
			local elementData = DungeonMapModel.instance:getElementById(elementId)

			if mapId == elementCo.mapId and isFinish and not elementData then
				table.insert(finishElementCoList, elementCo)
			end
		end
	end

	return finishElementCoList, mapAllElementList
end

function VersionActivity2_0DungeonModel:getAllNormalElementCoList(mapId)
	local allNormalElementCoList = {}
	local mapAllElementList = DungeonConfig.instance:getMapElements(mapId)

	if not mapAllElementList or #mapAllElementList < 0 then
		return allNormalElementCoList
	end

	local graffitiActId = Activity161Model.instance:getActId()

	for _, elementCo in pairs(mapAllElementList) do
		local graffitiCo = Activity161Config.instance:getGraffitiCo(graffitiActId, elementCo.id)
		local relevantElementMap, mainElementMap = Activity161Config.instance:getGraffitiRelevantElementMap(graffitiActId)

		if not graffitiCo and elementCo.type ~= DungeonEnum.ElementType.Graffiti and not relevantElementMap[elementCo.id] and not mainElementMap[elementCo.id] then
			table.insert(allNormalElementCoList, elementCo)
		end
	end

	return allNormalElementCoList
end

function VersionActivity2_0DungeonModel:setDungeonBaseMo(dungeonMo)
	self.actDungeonBaseMo = dungeonMo
end

function VersionActivity2_0DungeonModel:getDungeonBaseMo()
	return self.actDungeonBaseMo
end

function VersionActivity2_0DungeonModel:getCurNeedUnlockGraffitiElement()
	local graffitiActId = Activity161Model.instance:getActId()
	local graffitiCoMap = Activity161Config.instance:getAllGraffitiCo(graffitiActId)

	for _, graffitiCo in pairs(graffitiCoMap) do
		local isMainElementFinish = DungeonMapModel.instance:elementIsFinished(graffitiCo.mainElementId)
		local isPreMainElementFinish = Activity161Config.instance:isPreMainElementFinish(graffitiCo)
		local relevantElementList = Activity161Config.instance:getGraffitiRelevantElement(graffitiActId, graffitiCo.elementId)
		local isMainElementUnlock = DungeonMapModel.instance:getElementById(graffitiCo.mainElementId)

		if isPreMainElementFinish and isMainElementUnlock and not isMainElementFinish then
			return graffitiCo.mainElementId
		elseif isMainElementFinish and #relevantElementList > 0 then
			for index, subElementId in pairs(relevantElementList) do
				local isFinish = DungeonMapModel.instance:elementIsFinished(subElementId)
				local isUnlock = DungeonMapModel.instance:getElementById(subElementId)

				if not isFinish and isUnlock then
					return subElementId
				end
			end
		end
	end

	return nil
end

VersionActivity2_0DungeonModel.instance = VersionActivity2_0DungeonModel.New()

return VersionActivity2_0DungeonModel
