-- chunkname: @modules/logic/versionactivity/view/VersionActivityDungeonMapViewContainer.lua

module("modules.logic.versionactivity.view.VersionActivityDungeonMapViewContainer", package.seeall)

local VersionActivityDungeonMapViewContainer = class("VersionActivityDungeonMapViewContainer", BaseViewContainer)

function VersionActivityDungeonMapViewContainer:buildViews()
	local views = {}

	self.mapScene = VersionActivityDungeonMapScene.New()
	self.mapView = VersionActivityDungeonMapView.New()
	self.mapEpisodeView = VersionActivityDungeonMapEpisodeView.New()

	table.insert(views, self.mapView)
	table.insert(views, VersionActivityDungeonMapSceneElements.New())
	table.insert(views, self.mapScene)
	table.insert(views, self.mapEpisodeView)
	table.insert(views, DungeonMapElementReward.New())
	table.insert(views, VersionActivityDungeonAudioView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function VersionActivityDungeonMapViewContainer:getMapScene()
	return self.mapScene
end

function VersionActivityDungeonMapViewContainer:buildTabViews(tabContainerId)
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

function VersionActivityDungeonMapViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivityEnum.ActivityId.Act113)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivityEnum.ActivityId.Act113
	})

	self.versionActivityDungeonBaseMo = VersionActivityDungeonBaseMo.New()

	self.versionActivityDungeonBaseMo:init(VersionActivityEnum.ActivityId.Act113, self.viewParam.chapterId, self.viewParam.episodeId)
	self.versionActivityDungeonBaseMo:setLayoutClass(VersionActivityDungeonMapChapterLayout)
	self.versionActivityDungeonBaseMo:setMapEpisodeItemClass(VersionActivityMapEpisodeItem)
end

function VersionActivityDungeonMapViewContainer:onUpdateParamInternal(viewParam)
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

function VersionActivityDungeonMapViewContainer:onContainerUpdateParam()
	self.mapScene:setVisible(true)
	self.versionActivityDungeonBaseMo:update(self.viewParam.chapterId, self.viewParam.episodeId)
end

function VersionActivityDungeonMapViewContainer:setVisibleInternal(isVisible)
	VersionActivityDungeonMapViewContainer.super.setVisibleInternal(self, isVisible)
	self.mapScene:setVisible(isVisible)
end

function VersionActivityDungeonMapViewContainer:initChapterRecheck()
	local chapterId = self:_getChapterId()

	if self.navigateView then
		self.navigateView:initChapterRecheck(chapterId)
	end
end

function VersionActivityDungeonMapViewContainer:_getChapterId()
	if self.viewParam then
		if not self.viewParam.chapterId then
			return VersionActivityEnum.DungeonChapterId.LeiMiTeBei
		end
	end
end

return VersionActivityDungeonMapViewContainer
