-- chunkname: @modules/logic/versionactivity3_4/dungeon/view/map/VersionActivity3_4DungeonMapViewContainer.lua

module("modules.logic.versionactivity3_4.dungeon.view.map.VersionActivity3_4DungeonMapViewContainer", package.seeall)

local VersionActivity3_4DungeonMapViewContainer = class("VersionActivity3_4DungeonMapViewContainer", VersionActivityFixedDungeonMapViewContainer)

function VersionActivity3_4DungeonMapViewContainer:buildViews()
	self._dungeonMapControlView = VersionActivity3_4DungeonMapControlView.New()

	local views = VersionActivity3_4DungeonMapViewContainer.super.buildViews(self)

	tabletool.removeValue(views, self.mapSceneElements)
	table.insert(views, 1, self.mapSceneElements)
	table.insert(views, 1, VersionActivity3_4DungeonMapTaskInfo.New())
	table.insert(views, VersionActivity3_4DungeonMapEpisodeSceneView.New())
	table.insert(views, self._dungeonMapControlView)

	return views
end

function VersionActivity3_4DungeonMapViewContainer:showTimeline()
	return self._dungeonMapControlView:showTimeline()
end

function VersionActivity3_4DungeonMapViewContainer:getDungeonMapElementReward()
	return VersionActivity3_4DungeonMapElementReward.New()
end

function VersionActivity3_4DungeonMapViewContainer:onContainerOpen()
	VersionActivity3_4DungeonMapViewContainer.super.onContainerOpen(self)
	self:_initElementRecordInfos()
end

function VersionActivity3_4DungeonMapViewContainer:_initElementRecordInfos()
	local list = VersionActivity3_4DungeonConfig.instance:getOptionConfigs()
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

function VersionActivity3_4DungeonMapViewContainer:initNoteElementRecordInfos()
	local resultList = VersionActivity3_4DungeonConfig.instance:getElementsChapterReport()

	if #resultList > 0 then
		DungeonRpc.instance:sendGetMapElementRecordRequest(resultList)
	end
end

return VersionActivity3_4DungeonMapViewContainer
