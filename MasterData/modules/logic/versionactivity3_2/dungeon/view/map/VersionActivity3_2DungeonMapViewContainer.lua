-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/map/VersionActivity3_2DungeonMapViewContainer.lua

module("modules.logic.versionactivity3_2.dungeon.view.map.VersionActivity3_2DungeonMapViewContainer", package.seeall)

local VersionActivity3_2DungeonMapViewContainer = class("VersionActivity3_2DungeonMapViewContainer", VersionActivityFixedDungeonMapViewContainer)

function VersionActivity3_2DungeonMapViewContainer:buildViews()
	self._dungeonMapControlView = VersionActivity3_2DungeonMapControlView.New()

	local views = VersionActivity3_2DungeonMapViewContainer.super.buildViews(self)

	tabletool.removeValue(views, self.mapSceneElements)
	table.insert(views, 1, self.mapSceneElements)
	table.insert(views, 1, VersionActivity3_2DungeonMapTaskInfo.New())
	table.insert(views, VersionActivity3_2DungeonMapEpisodeSceneView.New())
	table.insert(views, self._dungeonMapControlView)

	return views
end

function VersionActivity3_2DungeonMapViewContainer:showTimeline()
	return self._dungeonMapControlView:showTimeline()
end

function VersionActivity3_2DungeonMapViewContainer:getDungeonMapElementReward()
	return VersionActivity3_2DungeonMapElementReward.New()
end

function VersionActivity3_2DungeonMapViewContainer:onContainerOpen()
	VersionActivity3_2DungeonMapViewContainer.super.onContainerOpen(self)
	self:_initElementRecordInfos()
end

function VersionActivity3_2DungeonMapViewContainer:_initElementRecordInfos()
	local list = VersionActivity3_2DungeonConfig.instance:getOptionConfigs()
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

function VersionActivity3_2DungeonMapViewContainer:initNoteElementRecordInfos()
	local list = lua_v3a2_chapter_report.configList
	local resultList = {}

	for i, config in ipairs(list) do
		if DungeonMapModel.instance:elementIsFinished(config.element) then
			table.insert(resultList, config.element)
		end
	end

	if #resultList > 0 then
		DungeonRpc.instance:sendGetMapElementRecordRequest(resultList)
	end
end

return VersionActivity3_2DungeonMapViewContainer
