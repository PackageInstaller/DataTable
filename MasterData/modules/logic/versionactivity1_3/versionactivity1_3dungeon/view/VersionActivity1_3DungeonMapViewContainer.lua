-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/view/VersionActivity1_3DungeonMapViewContainer.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonMapViewContainer", package.seeall)

local VersionActivity1_3DungeonMapViewContainer = class("VersionActivity1_3DungeonMapViewContainer", BaseViewContainer)

function VersionActivity1_3DungeonMapViewContainer:buildViews()
	local views = {}

	self.mapScene = VersionActivity1_3DungeonMapScene.New()
	self.mapView = VersionActivity1_3DungeonMapView.New()
	self.mapEpisodeView = VersionActivity1_3DungeonMapEpisodeView.New()
	self.mapSceneElements = VersionActivity1_3DungeonMapSceneElements.New()

	table.insert(views, self.mapView)
	table.insert(views, self.mapSceneElements)
	table.insert(views, self.mapScene)
	table.insert(views, self.mapEpisodeView)
	table.insert(views, DungeonMapElementReward.New())
	table.insert(views, VersionActivity1_3DungeonAudioView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function VersionActivity1_3DungeonMapViewContainer:getMapScene()
	return self.mapScene
end

function VersionActivity1_3DungeonMapViewContainer:buildTabViews(tabContainerId)
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

function VersionActivity1_3DungeonMapViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_3Enum.ActivityId.Dungeon)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_3Enum.ActivityId.Dungeon
	})

	self.versionActivityDungeonBaseMo = VersionActivityDungeonBaseMo.New()

	self.versionActivityDungeonBaseMo:init(VersionActivity1_3Enum.ActivityId.Dungeon, self.viewParam.chapterId, self.viewParam.episodeId)
	self.versionActivityDungeonBaseMo:setLayoutClass(VersionActivity1_3DungeonMapChapterLayout)
	self.versionActivityDungeonBaseMo:setMapEpisodeItemClass(VersionActivity1_3MapEpisodeItem)
end

function VersionActivity1_3DungeonMapViewContainer:onUpdateParamInternal(viewParam)
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

function VersionActivity1_3DungeonMapViewContainer:onContainerUpdateParam()
	self.versionActivityDungeonBaseMo:update(self.viewParam.chapterId, self.viewParam.episodeId)
	self:setVisibleInternal(true)
end

function VersionActivity1_3DungeonMapViewContainer:setVisibleInternal(isVisible)
	VersionActivity1_3DungeonMapViewContainer.super.setVisibleInternal(self, isVisible)

	if self.mapScene then
		self.mapScene:setVisible(isVisible)
	end
end

function VersionActivity1_3DungeonMapViewContainer:initChapterRecheck()
	local chapterId = self:_getChapterId()

	if self.navigateView then
		self.navigateView:initChapterRecheck(chapterId)
	end
end

function VersionActivity1_3DungeonMapViewContainer:_getChapterId()
	if self.viewParam then
		if not self.viewParam.chapterId then
			return VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei
		end
	end
end

return VersionActivity1_3DungeonMapViewContainer
