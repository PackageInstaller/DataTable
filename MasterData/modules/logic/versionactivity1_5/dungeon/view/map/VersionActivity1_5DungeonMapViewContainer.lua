-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/map/VersionActivity1_5DungeonMapViewContainer.lua

module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapViewContainer", package.seeall)

local VersionActivity1_5DungeonMapViewContainer = class("VersionActivity1_5DungeonMapViewContainer", BaseViewContainer)

function VersionActivity1_5DungeonMapViewContainer:buildViews()
	local views = {}

	self.mapScene = VersionActivity1_5DungeonMapScene.New()
	self.mapView = VersionActivity1_5DungeonMapView.New()
	self.mapEpisodeView = VersionActivity1_5DungeonMapEpisodeView.New()
	self.mapSceneElements = VersionActivity1_5DungeonMapSceneElements.New()
	self.interactView = VersionActivity1_5DungeonMapInteractView.New()

	table.insert(views, self.mapView)
	table.insert(views, self.mapSceneElements)
	table.insert(views, self.mapScene)
	table.insert(views, self.mapEpisodeView)
	table.insert(views, VersionActivity1_5DungeonMapHeroIconView.New())
	table.insert(views, self.interactView)
	table.insert(views, VersionActivity1_5DungeonMapHoleView.New())
	table.insert(views, VersionActivity1_5DungeonSceneEffectView.New())
	table.insert(views, DungeonMapElementReward.New())
	table.insert(views, VersionActivity1_5DungeonMapAudioView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function VersionActivity1_5DungeonMapViewContainer:getMapScene()
	return self.mapScene
end

function VersionActivity1_5DungeonMapViewContainer:buildTabViews(tabContainerId)
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

function VersionActivity1_5DungeonMapViewContainer:onClickClose()
	if VersionActivity1_5DungeonModel.instance:checkIsShowInteractView() then
		return
	end

	self:closeThis()
end

function VersionActivity1_5DungeonMapViewContainer:onClickHome()
	if VersionActivity1_5DungeonModel.instance:checkIsShowInteractView() then
		return
	end

	NavigateButtonsView.homeClick()
end

function VersionActivity1_5DungeonMapViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_5Enum.ActivityId.Dungeon)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_5Enum.ActivityId.Dungeon
	})

	self.versionActivityDungeonBaseMo = VersionActivity1_5DungeonMo.New()

	self.versionActivityDungeonBaseMo:init(VersionActivity1_5Enum.ActivityId.Dungeon, self.viewParam.chapterId, self.viewParam.episodeId)
	self.versionActivityDungeonBaseMo:setLayoutClass(VersionActivity1_5DungeonMapChapterLayout)
	self.versionActivityDungeonBaseMo:setMapEpisodeItemClass(VersionActivity1_5DungeonMapEpisodeItem)

	for _, view in ipairs(self._views) do
		view.activityDungeonMo = self.versionActivityDungeonBaseMo
	end

	TaskDispatcher.runRepeat(self.everySecondCall, self, 1)
end

function VersionActivity1_5DungeonMapViewContainer:onUpdateParamInternal(viewParam)
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

function VersionActivity1_5DungeonMapViewContainer:onContainerUpdateParam()
	self.versionActivityDungeonBaseMo:update(self.viewParam.chapterId, self.viewParam.episodeId)
	self:setVisibleInternal(true)
end

function VersionActivity1_5DungeonMapViewContainer:setVisibleInternal(isVisible)
	VersionActivity1_5DungeonMapViewContainer.super.setVisibleInternal(self, isVisible)

	if self.mapScene then
		self.mapScene:setVisible(isVisible)
	end
end

function VersionActivity1_5DungeonMapViewContainer:onContainerClose()
	VersionActivity1_5RevivalTaskModel.instance:clear()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function VersionActivity1_5DungeonMapViewContainer:everySecondCall()
	VersionActivity1_5DungeonModel.instance:checkDispatchFinish()
end

function VersionActivity1_5DungeonMapViewContainer:initChapterRecheck()
	local chapterId = self:_getChapterId()

	if self.navigateView then
		self.navigateView:initChapterRecheck(chapterId)
	end
end

function VersionActivity1_5DungeonMapViewContainer:getInteractiveItem()
	return self.interactView
end

function VersionActivity1_5DungeonMapViewContainer:_getChapterId()
	if self.viewParam then
		if not self.viewParam.chapterId then
			return VersionActivity1_5DungeonEnum.DungeonChapterId.Story
		end
	end
end

return VersionActivity1_5DungeonMapViewContainer
