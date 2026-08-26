-- chunkname: @modules/logic/versionactivity2_5/dungeon/view/map/VersionActivity2_5DungeonMapViewContainer.lua

module("modules.logic.versionactivity2_5.dungeon.view.map.VersionActivity2_5DungeonMapViewContainer", package.seeall)

local VersionActivity2_5DungeonMapViewContainer = class("VersionActivity2_5DungeonMapViewContainer", BaseViewContainer)

function VersionActivity2_5DungeonMapViewContainer:buildViews()
	self.mapScene = VersionActivity2_5DungeonMapScene.New()
	self.mapSceneElements = VersionActivity2_5DungeonMapSceneElements.New()
	self.mapView = VersionActivity2_5DungeonMapView.New()
	self.mapEpisodeView = VersionActivity2_5DungeonMapEpisodeView.New()
	self.interactView = VersionActivity2_5DungeonMapInteractView.New()
	self.mapElementReward = DungeonMapElementReward.New()

	return {
		VersionActivity2_5DungeonMapHoleView.New(),
		self.mapScene,
		self.mapSceneElements,
		self.mapView,
		self.mapEpisodeView,
		self.interactView,
		self.mapElementReward,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function VersionActivity2_5DungeonMapViewContainer:buildTabViews(tabContainerId)
	self.navigateView = DungeonNavigateButtonsView.New({
		true,
		true,
		false
	})

	self.navigateView:setOverrideClose(self.onClickClose, self)
	self.navigateView:setOverrideHome(self.onClickHome, self)
	self.navigateView:setOpenCallback(self.initChapterRecheck, self)

	return {
		self.navigateView
	}
end

function VersionActivity2_5DungeonMapViewContainer:onClickClose()
	local isShowInteractView = VersionActivity2_5DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		return
	end

	self:closeThis()
end

function VersionActivity2_5DungeonMapViewContainer:onClickHome()
	local isShowInteractView = VersionActivity2_5DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		return
	end

	NavigateButtonsView.homeClick()
end

function VersionActivity2_5DungeonMapViewContainer:onContainerInit()
	self.versionActivityDungeonBaseMo = VersionActivity2_5DungeonMo.New()

	self.versionActivityDungeonBaseMo:init(VersionActivity2_5Enum.ActivityId.Dungeon, self.viewParam.chapterId, self.viewParam.episodeId)
	self.versionActivityDungeonBaseMo:setLayoutClass(VersionActivity2_5DungeonMapChapterLayout)
	self.versionActivityDungeonBaseMo:setMapEpisodeItemClass(VersionActivity2_5DungeonMapEpisodeItem)

	for _, view in ipairs(self._views) do
		view.activityDungeonMo = self.versionActivityDungeonBaseMo
	end

	VersionActivity2_5DungeonModel.instance:setDungeonBaseMo(self.versionActivityDungeonBaseMo)
	self.mapElementReward:setShowToastState(true)
end

function VersionActivity2_5DungeonMapViewContainer:onUpdateParamInternal(viewParam)
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

function VersionActivity2_5DungeonMapViewContainer:onContainerUpdateParam()
	self.versionActivityDungeonBaseMo:update(self.viewParam.chapterId, self.viewParam.episodeId)
	self:setVisibleInternal(true)
end

function VersionActivity2_5DungeonMapViewContainer:setVisibleInternal(isVisible)
	VersionActivity2_5DungeonMapViewContainer.super.setVisibleInternal(self, isVisible)

	if self.mapScene then
		self.mapScene:setVisible(isVisible)
	end
end

function VersionActivity2_5DungeonMapViewContainer:onContainerClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function VersionActivity2_5DungeonMapViewContainer:getMapScene()
	return self.mapScene
end

function VersionActivity2_5DungeonMapViewContainer:initChapterRecheck()
	local chapterId = self:_getChapterId()

	if self.navigateView then
		self.navigateView:initChapterRecheck(chapterId)
	end
end

function VersionActivity2_5DungeonMapViewContainer:getInteractiveItem()
	return self.interactView
end

function VersionActivity2_5DungeonMapViewContainer:_getChapterId()
	if self.viewParam then
		if not self.viewParam.chapterId then
			return VersionActivity2_5DungeonEnum.DungeonChapterId.Story
		end
	end
end

return VersionActivity2_5DungeonMapViewContainer
