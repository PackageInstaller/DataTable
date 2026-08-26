-- chunkname: @modules/logic/versionactivity3_5/dungeon/view/map/VersionActivity3_5DungeonMapViewContainer.lua

module("modules.logic.versionactivity3_5.dungeon.view.map.VersionActivity3_5DungeonMapViewContainer", package.seeall)

local VersionActivity3_5DungeonMapViewContainer = class("VersionActivity3_5DungeonMapViewContainer", VersionActivityFixedDungeonMapViewContainer)

function VersionActivity3_5DungeonMapViewContainer:buildViews()
	self._dungeonMapControlView = VersionActivity3_5DungeonMapControlView.New()

	local views = VersionActivity3_5DungeonMapViewContainer.super.buildViews(self)

	tabletool.removeValue(views, self.mapSceneElements)
	table.insert(views, 1, self.mapSceneElements)
	table.insert(views, 1, VersionActivity3_5DungeonMapTaskInfo.New())
	table.insert(views, VersionActivity3_5DungeonMapEpisodeSceneView.New())
	table.insert(views, self._dungeonMapControlView)

	return views
end

function VersionActivity3_5DungeonMapViewContainer:showTimeline()
	return self._dungeonMapControlView:showTimeline()
end

function VersionActivity3_5DungeonMapViewContainer:getDungeonMapElementReward()
	return VersionActivity3_5DungeonMapElementReward.New()
end

function VersionActivity3_5DungeonMapViewContainer:onContainerOpen()
	VersionActivity3_5DungeonMapViewContainer.super.onContainerOpen(self)
	self:_initElementRecordInfos()
end

function VersionActivity3_5DungeonMapViewContainer:_initElementRecordInfos()
	local list = VersionActivity3_5DungeonConfig.instance:getOptionConfigs()
	local reportList = {}

	for i, config in ipairs(list) do
		if DungeonMapModel.instance:elementIsFinished(config.id) then
			table.insert(reportList, config.id)
		end
	end

	if #reportList > 0 then
		DungeonRpc.instance:sendGetMapElementRecordRequest(reportList)
	end
end

function VersionActivity3_5DungeonMapViewContainer:initNoteElementRecordInfos()
	local resultList = VersionActivity3_5DungeonConfig.instance:getElementsChapterReport()

	if #resultList > 0 then
		DungeonRpc.instance:sendGetMapElementRecordRequest(resultList)
	end
end

return VersionActivity3_5DungeonMapViewContainer
