-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9DungeonMapViewContainer.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapViewContainer", package.seeall)

local VersionActivity2_9DungeonMapViewContainer = class("VersionActivity2_9DungeonMapViewContainer", VersionActivityFixedDungeonMapViewContainer)

function VersionActivity2_9DungeonMapViewContainer:buildViews()
	self.mapScene = VersionActivityFixedHelper.getVersionActivityDungeonMapScene().New()
	self.mapSceneElements = VersionActivityFixedHelper.getVersionActivityDungeonMapSceneElements().New()
	self.mapView = VersionActivityFixedHelper.getVersionActivityDungeonMapView().New()
	self.mapEpisodeView = VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeView().New()
	self.interactView = VersionActivityFixedHelper.getVersionActivityDungeonMapInteractView().New()
	self.mapElementReward = VersionActivity2_9DungeonMapElementReward.New()
	self.director = VersionActivity2_9DungeonMapDirector.New()

	local views = {
		VersionActivityFixedHelper.getVersionActivityDungeonMapHoleView().New(),
		self.mapSceneElements,
		self.mapScene,
		self.mapView,
		self.mapEpisodeView,
		self.interactView,
		self.mapElementReward,
		self.director,
		VersionActivity2_9DungeonMapExtraView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}

	if isDebugBuild then
		table.insert(views, VersionActivity2_9DungeonMapEditView.New())
	end

	return views
end

function VersionActivity2_9DungeonMapViewContainer:playCloseTransition()
	local animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	animatorPlayer:Play("to_game", self.onPlayCloseTransitionFinish, self)
end

return VersionActivity2_9DungeonMapViewContainer
