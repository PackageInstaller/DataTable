-- chunkname: @modules/logic/versionactivity2_3/dungeon/view/map/VersionActivity2_3DungeonMapViewContainer.lua

module("modules.logic.versionactivity2_3.dungeon.view.map.VersionActivity2_3DungeonMapViewContainer", package.seeall)

local VersionActivity2_3DungeonMapViewContainer = class("VersionActivity2_3DungeonMapViewContainer", BaseViewContainer)

function VersionActivity2_3DungeonMapViewContainer:buildViews()
	self.mapScene = VersionActivity2_3DungeonMapScene.New()
	self.mapSceneElements = VersionActivity2_3DungeonMapSceneElements.New()
	self.mapView = VersionActivity2_3DungeonMapView.New()
	self.mapEpisodeView = VersionActivity2_3DungeonMapEpisodeView.New()
	self.interactView = VersionActivity2_3DungeonMapInteractView.New()
	self.mapElementReward = DungeonMapElementReward.New()

	return {
		VersionActivity2_3DungeonMapHoleView.New(),
		self.mapScene,
		self.mapSceneElements,
		self.mapView,
		self.mapEpisodeView,
		self.interactView,
		self.mapElementReward,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function VersionActivity2_3DungeonMapViewContainer:buildTabViews(tabContainerId)
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

function VersionActivity2_3DungeonMapViewContainer:onClickClose()
	local isShowInteractView = VersionActivity2_3DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		return
	end

	self:closeThis()
end

function VersionActivity2_3DungeonMapViewContainer:onClickHome()
	local isShowInteractView = VersionActivity2_3DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		return
	end

	NavigateButtonsView.homeClick()
end

function VersionActivity2_3DungeonMapViewContainer:onContainerInit()
	self.versionActivityDungeonBaseMo = VersionActivity2_3DungeonMo.New()

	self.versionActivityDungeonBaseMo:init(VersionActivity2_3Enum.ActivityId.Dungeon, self.viewParam.chapterId, self.viewParam.episodeId)
	self.versionActivityDungeonBaseMo:setLayoutClass(VersionActivity2_3DungeonMapChapterLayout)
	self.versionActivityDungeonBaseMo:setMapEpisodeItemClass(VersionActivity2_3DungeonMapEpisodeItem)

	for _, view in ipairs(self._views) do
		view.activityDungeonMo = self.versionActivityDungeonBaseMo
	end

	VersionActivity2_3DungeonModel.instance:setDungeonBaseMo(self.versionActivityDungeonBaseMo)
	self.mapElementReward:setShowToastState(true)
end

function VersionActivity2_3DungeonMapViewContainer:onUpdateParamInternal(viewParam)
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

function VersionActivity2_3DungeonMapViewContainer:onContainerUpdateParam()
	self.versionActivityDungeonBaseMo:update(self.viewParam.chapterId, self.viewParam.episodeId)
	self:setVisibleInternal(true)
end

function VersionActivity2_3DungeonMapViewContainer:setVisibleInternal(isVisible)
	VersionActivity2_3DungeonMapViewContainer.super.setVisibleInternal(self, isVisible)

	if self.mapScene then
		self.mapScene:setVisible(isVisible)
	end
end

function VersionActivity2_3DungeonMapViewContainer:onContainerClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function VersionActivity2_3DungeonMapViewContainer:getMapScene()
	return self.mapScene
end

function VersionActivity2_3DungeonMapViewContainer:initChapterRecheck()
	local chapterId = self:_getChapterId()

	if self.navigateView then
		self.navigateView:initChapterRecheck(chapterId)
	end
end

function VersionActivity2_3DungeonMapViewContainer:getInteractiveItem()
	return self.interactView
end

function VersionActivity2_3DungeonMapViewContainer:_getChapterId()
	if self.viewParam then
		if not self.viewParam.chapterId then
			return VersionActivity2_3DungeonEnum.DungeonChapterId.Story
		end
	end
end

return VersionActivity2_3DungeonMapViewContainer
