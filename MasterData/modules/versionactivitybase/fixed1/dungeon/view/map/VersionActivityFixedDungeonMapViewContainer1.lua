-- chunkname: @modules/versionactivitybase/fixed1/dungeon/view/map/VersionActivityFixedDungeonMapViewContainer1.lua

module("modules.versionactivitybase.fixed1.dungeon.view.map.VersionActivityFixedDungeonMapViewContainer1", package.seeall)

local VersionActivityFixedDungeonMapViewContainer1 = class("VersionActivityFixedDungeonMapViewContainer1", VersionActivityFixedDungeonMapViewContainer)

function VersionActivityFixedDungeonMapViewContainer1:buildViews()
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local scriptSuffix = VersionActivityFixedHelper.getVersionActivityScriptSuffix(bigVersion, smallVersion)
	local dungeonMapControlView1 = VersionActivityFixedHelper.getVersionActivityDungeonMapControlView(bigVersion, smallVersion, scriptSuffix)
	local dungeonMapTaskInfo1 = VersionActivityFixedHelper.getVersionActivityDungeonMapTaskInfo(bigVersion, smallVersion, scriptSuffix)
	local dungeonMapEpisodeSceneView1 = VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeSceneView(bigVersion, smallVersion, scriptSuffix)

	self._dungeonMapControlView = dungeonMapControlView1.New()
	self.mapScene = VersionActivityFixedHelper.getVersionActivityDungeonMapScene(bigVersion, smallVersion, scriptSuffix).New()
	self.mapSceneElements = VersionActivityFixedHelper.getVersionActivityDungeonMapSceneElements(bigVersion, smallVersion, scriptSuffix).New()
	self.mapView = VersionActivityFixedHelper.getVersionActivityDungeonMapView(bigVersion, smallVersion, scriptSuffix).New()
	self.mapEpisodeView = VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeView(bigVersion, smallVersion, scriptSuffix).New()
	self.interactView = VersionActivityFixedHelper.getVersionActivityDungeonMapInteractView(bigVersion, smallVersion, scriptSuffix).New()
	self.mapElementReward = self:getDungeonMapElementReward()
	self.dungeonMapHoleView = VersionActivityFixedHelper.getVersionActivityDungeonMapHoleView(bigVersion, smallVersion, scriptSuffix).New()

	return {
		self.mapSceneElements,
		self.dungeonMapHoleView,
		self.mapScene,
		self.mapView,
		self.mapEpisodeView,
		self.interactView,
		self.mapElementReward,
		dungeonMapTaskInfo1.New(),
		dungeonMapEpisodeSceneView1.New(),
		self._dungeonMapControlView,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function VersionActivityFixedDungeonMapViewContainer1:showTimeline()
	return self._dungeonMapControlView:showTimeline()
end

function VersionActivityFixedDungeonMapViewContainer1:getDungeonMapElementReward()
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local scriptSuffix = VersionActivityFixedHelper.getVersionActivityScriptSuffix(bigVersion, smallVersion)
	local dungeonMapElementReward1 = VersionActivityFixedHelper.getVersionActivityDungeonMapElementReward(bigVersion, smallVersion, scriptSuffix)

	return dungeonMapElementReward1.New()
end

function VersionActivityFixedDungeonMapViewContainer1:onContainerInit()
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local enum = VersionActivityFixedHelper.getVersionActivityEnum(bigVersion, smallVersion)
	local scriptSuffix = VersionActivityFixedHelper.getVersionActivityScriptSuffix(bigVersion, smallVersion)
	local chapterLayout = VersionActivityFixedHelper.getVersionActivityDungeonMapChapterLayout(bigVersion, smallVersion, scriptSuffix)
	local episodeItem = VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeItem(bigVersion, smallVersion, scriptSuffix)

	self.versionActivityDungeonBaseMo = VersionActivityFixedDungeonMo.New()

	self.versionActivityDungeonBaseMo:init(enum.ActivityId.Dungeon, self.viewParam.chapterId, self.viewParam.episodeId)
	self.versionActivityDungeonBaseMo:setLayoutClass(chapterLayout)
	self.versionActivityDungeonBaseMo:setMapEpisodeItemClass(episodeItem)

	for _, view in ipairs(self._views) do
		view.activityDungeonMo = self.versionActivityDungeonBaseMo
	end

	VersionActivityFixedDungeonModel.instance:setDungeonBaseMo(self.versionActivityDungeonBaseMo)
	self.mapElementReward:setShowToastState(true)
end

function VersionActivityFixedDungeonMapViewContainer1:onContainerOpen()
	VersionActivityFixedDungeonMapViewContainer1.super.onContainerOpen(self)
	self:_initElementRecordInfos()
end

function VersionActivityFixedDungeonMapViewContainer1:_initElementRecordInfos()
	local list = VersionActivityFixedDungeonConfig1.instance:getOptionConfigs()
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

function VersionActivityFixedDungeonMapViewContainer1:initNoteElementRecordInfos()
	local resultList = VersionActivityFixedDungeonConfig1.instance:getElementsChapterReport()

	if #resultList > 0 then
		DungeonRpc.instance:sendGetMapElementRecordRequest(resultList)
	end
end

return VersionActivityFixedDungeonMapViewContainer1
