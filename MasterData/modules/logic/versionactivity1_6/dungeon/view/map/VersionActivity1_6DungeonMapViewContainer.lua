-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/map/VersionActivity1_6DungeonMapViewContainer.lua

module("modules.logic.versionactivity1_6.dungeon.view.map.VersionActivity1_6DungeonMapViewContainer", package.seeall)

local VersionActivity1_6DungeonMapViewContainer = class("VersionActivity1_6DungeonMapViewContainer", BaseViewContainer)

function VersionActivity1_6DungeonMapViewContainer:buildViews()
	local views = {}

	self.mapScene = VersionActivity1_6DungeonMapScene.New()
	self.mapView = VersionActivity1_6DungeonMapView.New()
	self.mapEpisodeView = VersionActivity1_6DungeonMapEpisodeView.New()
	self.mapSceneElements = VersionActivity1_6DungeonMapSceneElements.New()

	table.insert(views, self.mapView)
	table.insert(views, self.mapSceneElements)
	table.insert(views, self.mapScene)
	table.insert(views, self.mapEpisodeView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function VersionActivity1_6DungeonMapViewContainer:getMapScene()
	return self.mapScene
end

function VersionActivity1_6DungeonMapViewContainer:buildTabViews(tabContainerId)
	self.navigateView = DungeonNavigateButtonsView.New({
		true,
		true,
		false
	}, nil, nil, self.homeCallback, nil, self)

	self.navigateView:setOpenCallback(self.initChapterRecheck, self)

	return {
		self.navigateView
	}
end

function VersionActivity1_6DungeonMapViewContainer:onContainerInit()
	self.versionActivityDungeonBaseMo = VersionActivityDungeonBaseMo.New()

	self.versionActivityDungeonBaseMo:init(VersionActivity1_6Enum.ActivityId.Dungeon, self.viewParam.chapterId, self.viewParam.episodeId)
	self.versionActivityDungeonBaseMo:setLayoutClass(VersionActivity1_6DungeonMapChapterLayout)
	self.versionActivityDungeonBaseMo:setMapEpisodeItemClass(VersionActivity1_6DungeonMapEpisodeItem)

	for _, view in ipairs(self._views) do
		view.activityDungeonMo = self.versionActivityDungeonBaseMo
	end
end

function VersionActivity1_6DungeonMapViewContainer:onUpdateParamInternal(viewParam)
	self.viewParam = viewParam

	self:onContainerUpdateParam()
	self:_setVisible(true)

	if self._views then
		for _, item in ipairs(self._views) do
			item.viewParam = viewParam

			item:onUpdateParamInternal()
		end
	end
end

function VersionActivity1_6DungeonMapViewContainer:onContainerUpdateParam()
	self.versionActivityDungeonBaseMo:update(self.viewParam.chapterId, self.viewParam.episodeId)
	self:setVisibleInternal(true)
end

function VersionActivity1_6DungeonMapViewContainer:setVisibleInternal(isVisible)
	VersionActivity1_6DungeonMapViewContainer.super.setVisibleInternal(self, isVisible)

	if self.mapScene then
		self.mapScene:setVisible(isVisible)
	end
end

function VersionActivity1_6DungeonMapViewContainer:onContainerClose()
	return
end

function VersionActivity1_6DungeonMapViewContainer:initChapterRecheck()
	local chapterId = self:_getChapterId()

	if self.navigateView then
		self.navigateView:initChapterRecheck(chapterId)
	end
end

function VersionActivity1_6DungeonMapViewContainer:getInteractiveItem()
	return self.interactView
end

function VersionActivity1_6DungeonMapViewContainer:_getChapterId()
	if self.viewParam then
		if not self.viewParam.chapterId then
			return VersionActivity1_6DungeonEnum.DungeonChapterId.Story
		end
	end
end

return VersionActivity1_6DungeonMapViewContainer
