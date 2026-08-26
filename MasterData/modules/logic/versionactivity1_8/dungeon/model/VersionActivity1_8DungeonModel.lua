-- chunkname: @modules/logic/versionactivity1_8/dungeon/model/VersionActivity1_8DungeonModel.lua

module("modules.logic.versionactivity1_8.dungeon.model.VersionActivity1_8DungeonModel", package.seeall)

local VersionActivity1_8DungeonModel = class("VersionActivity1_8DungeonModel", BaseModel)

function VersionActivity1_8DungeonModel:onInit()
	return
end

function VersionActivity1_8DungeonModel:reInit()
	self:init()
end

function VersionActivity1_8DungeonModel:init()
	self:setLastEpisodeId()
	self:setShowInteractView()
end

function VersionActivity1_8DungeonModel:setLastEpisodeId(episodeId)
	self.lastEpisodeId = episodeId
end

function VersionActivity1_8DungeonModel:setShowInteractView(isShow)
	self.isShowInteractView = isShow
end

function VersionActivity1_8DungeonModel:setIsNotShowNewElement(isNotShow)
	self.notShowNewElement = isNotShow
end

function VersionActivity1_8DungeonModel:isNotShowNewElement()
	return self.notShowNewElement
end

function VersionActivity1_8DungeonModel:getLastEpisodeId()
	return self.lastEpisodeId
end

function VersionActivity1_8DungeonModel:checkIsShowInteractView()
	return self.isShowInteractView
end

function VersionActivity1_8DungeonModel:getElementCoList(mapId)
	local elementCoList = {}
	local allElements = DungeonMapModel.instance:getAllElements()

	for _, elementId in pairs(allElements) do
		local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)
		local mapCo = lua_chapter_map.configDict[elementCo.mapId]

		if mapCo and mapCo.chapterId == VersionActivity1_8DungeonEnum.DungeonChapterId.Story and mapId == elementCo.mapId then
			table.insert(elementCoList, elementCo)
		end
	end

	return elementCoList
end

function VersionActivity1_8DungeonModel:getElementCoListWithFinish(mapId, isJudgeInProgress)
	local elementCoList = {}
	local mapAllElementList = DungeonConfig.instance:getMapElements(mapId)

	if not mapAllElementList or #mapAllElementList < 0 then
		return elementCoList
	end

	for _, elementCo in pairs(mapAllElementList) do
		local elementId = elementCo.id
		local mapCo = lua_chapter_map.configDict[elementCo.mapId]

		if mapCo and mapCo.chapterId == VersionActivity1_8DungeonEnum.DungeonChapterId.Story then
			local isFinish = DungeonMapModel.instance:elementIsFinished(elementId)
			local elementData = DungeonMapModel.instance:getElementById(elementId)
			local isCanProgress = true
			local actId = Activity157Model.instance:getActId()
			local missionId = Activity157Config.instance:getMissionIdByElementId(actId, elementId)

			if (missionId or nil) and Activity157Config.instance:isSideMission(actId, missionId) and isJudgeInProgress then
				local isProgressOther = Activity157Model.instance:isInProgressOtherMissionGroupByElementId(elementId)

				isCanProgress = not isProgressOther
			end

			if mapId == elementCo.mapId and isCanProgress and (isFinish or elementData) then
				table.insert(elementCoList, elementCo)
			end
		end
	end

	return elementCoList
end

VersionActivity1_8DungeonModel.instance = VersionActivity1_8DungeonModel.New()

return VersionActivity1_8DungeonModel
