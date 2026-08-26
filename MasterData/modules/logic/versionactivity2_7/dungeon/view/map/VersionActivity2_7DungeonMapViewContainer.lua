-- chunkname: @modules/logic/versionactivity2_7/dungeon/view/map/VersionActivity2_7DungeonMapViewContainer.lua

module("modules.logic.versionactivity2_7.dungeon.view.map.VersionActivity2_7DungeonMapViewContainer", package.seeall)

local VersionActivity2_7DungeonMapViewContainer = class("VersionActivity2_7DungeonMapViewContainer", VersionActivityFixedDungeonMapViewContainer)

function VersionActivity2_7DungeonMapViewContainer:buildViews()
	self.mapScene = VersionActivity2_7DungeonMapScene.New()
	self.mapSceneElements = VersionActivityFixedHelper.getVersionActivityDungeonMapSceneElements(2, 7).New()
	self.mapView = VersionActivityFixedHelper.getVersionActivityDungeonMapView(2, 7).New()
	self.mapEpisodeView = VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeView(2, 7).New()
	self.interactView = VersionActivityFixedHelper.getVersionActivityDungeonMapInteractView(2, 7).New()
	self.mapElementReward = DungeonMapElementReward.New()

	return {
		VersionActivityFixedHelper.getVersionActivityDungeonMapHoleView(2, 7).New(),
		self.mapScene,
		self.mapSceneElements,
		self.mapView,
		self.mapEpisodeView,
		self.interactView,
		self.mapElementReward,
		TabViewGroup.New(1, "#go_topleft")
	}
end

return VersionActivity2_7DungeonMapViewContainer
