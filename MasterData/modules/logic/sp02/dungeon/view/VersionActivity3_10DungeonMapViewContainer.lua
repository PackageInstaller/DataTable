-- chunkname: @modules/logic/sp02/dungeon/view/VersionActivity3_10DungeonMapViewContainer.lua

module("modules.logic.sp02.dungeon.view.VersionActivity3_10DungeonMapViewContainer", package.seeall)

local VersionActivity3_10DungeonMapViewContainer = class("VersionActivity3_10DungeonMapViewContainer", VersionActivityFixedDungeonMapViewContainer)

function VersionActivity3_10DungeonMapViewContainer:buildViews()
	self.mapScene = VersionActivityFixedHelper.getVersionActivityDungeonMapScene().New()
	self.mapSceneElements = VersionActivityFixedHelper.getVersionActivityDungeonMapSceneElements().New()
	self.mapView = VersionActivityFixedHelper.getVersionActivityDungeonMapView().New()
	self.mapEpisodeView = VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeView().New()
	self.interactView = VersionActivityFixedHelper.getVersionActivityDungeonMapInteractView().New()
	self.mapElementReward = DungeonMapElementReward.New()

	return {
		VersionActivityFixedHelper.getVersionActivityDungeonMapHoleView().New(),
		self.mapSceneElements,
		self.mapScene,
		self.mapView,
		self.mapEpisodeView,
		self.interactView,
		self.mapElementReward,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function VersionActivity3_10DungeonMapViewContainer:onContainerInit()
	VersionActivity3_10DungeonMapViewContainer.super.onContainerInit(self)
	self.versionActivityDungeonBaseMo:setLayoutPrefabUrl()
	self.versionActivityDungeonBaseMo:setLayoutOffsetY(0)
end

function VersionActivity3_10DungeonMapViewContainer:setVisibleInternal(isVisible)
	if self._isVisible == isVisible then
		return
	end

	self._isVisible = isVisible

	self.mapView:onVisibleChange(isVisible)
	VersionActivity3_10DungeonMapViewContainer.super.setVisibleInternal(self, isVisible)
end

return VersionActivity3_10DungeonMapViewContainer
