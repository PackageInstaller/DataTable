-- chunkname: @modules/logic/versionactivity2_4/dungeon/view/map/VersionActivity2_4DungeonMapViewContainer.lua

module("modules.logic.versionactivity2_4.dungeon.view.map.VersionActivity2_4DungeonMapViewContainer", package.seeall)

local VersionActivity2_4DungeonMapViewContainer = class("VersionActivity2_4DungeonMapViewContainer", BaseViewContainer)

function VersionActivity2_4DungeonMapViewContainer:buildViews()
	self.mapScene = VersionActivity2_4DungeonMapScene.New()
	self.mapSceneElements = VersionActivity2_4DungeonMapSceneElements.New()
	self.mapView = VersionActivity2_4DungeonMapView.New()
	self.mapEpisodeView = VersionActivity2_4DungeonMapEpisodeView.New()
	self.interactView = VersionActivity2_4DungeonMapInteractView.New()
	self.mapElementReward = DungeonMapElementReward.New()

	return {
		VersionActivity2_4DungeonMapHoleView.New(),
		self.mapScene,
		self.mapSceneElements,
		self.mapView,
		self.mapEpisodeView,
		self.interactView,
		self.mapElementReward,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function VersionActivity2_4DungeonMapViewContainer:buildTabViews(tabContainerId)
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

function VersionActivity2_4DungeonMapViewContainer:onClickClose()
	local isShowInteractView = VersionActivity2_4DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		return
	end

	self:closeThis()
end

function VersionActivity2_4DungeonMapViewContainer:onClickHome()
	local isShowInteractView = VersionActivity2_4DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		return
	end

	NavigateButtonsView.homeClick()
end

function VersionActivity2_4DungeonMapViewContainer:onContainerInit()
	self.versionActivityDungeonBaseMo = VersionActivity2_4DungeonMo.New()

	self.versionActivityDungeonBaseMo:init(VersionActivity2_4Enum.ActivityId.Dungeon, self.viewParam.chapterId, self.viewParam.episodeId)
	self.versionActivityDungeonBaseMo:setLayoutClass(VersionActivity2_4DungeonMapChapterLayout)
	self.versionActivityDungeonBaseMo:setMapEpisodeItemClass(VersionActivity2_4DungeonMapEpisodeItem)

	for _, view in ipairs(self._views) do
		view.activityDungeonMo = self.versionActivityDungeonBaseMo
	end

	VersionActivity2_4DungeonModel.instance:setDungeonBaseMo(self.versionActivityDungeonBaseMo)
	self.mapElementReward:setShowToastState(true)
end

function VersionActivity2_4DungeonMapViewContainer:onUpdateParamInternal(viewParam)
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

function VersionActivity2_4DungeonMapViewContainer:onContainerUpdateParam()
	self.versionActivityDungeonBaseMo:update(self.viewParam.chapterId, self.viewParam.episodeId)
	self:setVisibleInternal(true)
end

function VersionActivity2_4DungeonMapViewContainer:setVisibleInternal(isVisible)
	VersionActivity2_4DungeonMapViewContainer.super.setVisibleInternal(self, isVisible)

	if self.mapScene then
		self.mapScene:setVisible(isVisible)
	end
end

function VersionActivity2_4DungeonMapViewContainer:onContainerClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function VersionActivity2_4DungeonMapViewContainer:getMapScene()
	return self.mapScene
end

function VersionActivity2_4DungeonMapViewContainer:initChapterRecheck()
	local chapterId = self:_getChapterId()

	if self.navigateView then
		self.navigateView:initChapterRecheck(chapterId)
	end
end

function VersionActivity2_4DungeonMapViewContainer:getInteractiveItem()
	return self.interactView
end

function VersionActivity2_4DungeonMapViewContainer:_getChapterId()
	if self.viewParam then
		if not self.viewParam.chapterId then
			return VersionActivity2_4DungeonEnum.DungeonChapterId.Story
		end
	end
end

return VersionActivity2_4DungeonMapViewContainer
