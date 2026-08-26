-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/map/VersionActivity1_8DungeonMapViewContainer.lua

module("modules.logic.versionactivity1_8.dungeon.view.map.VersionActivity1_8DungeonMapViewContainer", package.seeall)

local VersionActivity1_8DungeonMapViewContainer = class("VersionActivity1_8DungeonMapViewContainer", BaseViewContainer)

function VersionActivity1_8DungeonMapViewContainer:buildViews()
	self.mapScene = VersionActivity1_8DungeonMapScene.New()
	self.mapSceneElements = VersionActivity1_8DungeonMapSceneElements.New()
	self.mapView = VersionActivity1_8DungeonMapView.New()
	self.mapEpisodeView = VersionActivity1_8DungeonMapEpisodeView.New()
	self.interactView = VersionActivity1_8DungeonMapInteractView.New()

	return {
		self.mapScene,
		self.mapSceneElements,
		self.mapView,
		self.mapEpisodeView,
		self.interactView,
		VersionActivity1_8DungeonMapHoleView.New(),
		DungeonMapElementReward.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function VersionActivity1_8DungeonMapViewContainer:buildTabViews(tabContainerId)
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

function VersionActivity1_8DungeonMapViewContainer:onClickClose()
	local isShowInteractView = VersionActivity1_8DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		return
	end

	self:closeThis()
end

function VersionActivity1_8DungeonMapViewContainer:onClickHome()
	local isShowInteractView = VersionActivity1_8DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		return
	end

	NavigateButtonsView.homeClick()
end

function VersionActivity1_8DungeonMapViewContainer:onContainerInit()
	self.versionActivityDungeonBaseMo = VersionActivity1_8DungeonMo.New()

	self.versionActivityDungeonBaseMo:init(VersionActivity1_8Enum.ActivityId.Dungeon, self.viewParam.chapterId, self.viewParam.episodeId)
	self.versionActivityDungeonBaseMo:setLayoutClass(VersionActivity1_8DungeonMapChapterLayout)
	self.versionActivityDungeonBaseMo:setMapEpisodeItemClass(VersionActivity1_8DungeonMapEpisodeItem)

	for _, view in ipairs(self._views) do
		view.activityDungeonMo = self.versionActivityDungeonBaseMo
	end

	TaskDispatcher.runRepeat(self.everySecondCall, self, 1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function VersionActivity1_8DungeonMapViewContainer:everySecondCall()
	DispatchModel.instance:checkDispatchFinish()
end

function VersionActivity1_8DungeonMapViewContainer:onUpdateParamInternal(viewParam)
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

function VersionActivity1_8DungeonMapViewContainer:onContainerUpdateParam()
	self.versionActivityDungeonBaseMo:update(self.viewParam.chapterId, self.viewParam.episodeId)
	self:setVisibleInternal(true)
end

function VersionActivity1_8DungeonMapViewContainer:setVisibleInternal(isVisible)
	VersionActivity1_8DungeonMapViewContainer.super.setVisibleInternal(self, isVisible)

	if self.mapScene then
		self.mapScene:setVisible(isVisible)
	end
end

function VersionActivity1_8DungeonMapViewContainer:onContainerClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function VersionActivity1_8DungeonMapViewContainer:getMapScene()
	return self.mapScene
end

function VersionActivity1_8DungeonMapViewContainer:initChapterRecheck()
	local chapterId = self:_getChapterId()

	if self.navigateView then
		self.navigateView:initChapterRecheck(chapterId)
	end
end

function VersionActivity1_8DungeonMapViewContainer:getInteractiveItem()
	return self.interactView
end

function VersionActivity1_8DungeonMapViewContainer:_getChapterId()
	if self.viewParam then
		if not self.viewParam.chapterId then
			return VersionActivity1_8DungeonEnum.DungeonChapterId.Story
		end
	end
end

return VersionActivity1_8DungeonMapViewContainer
