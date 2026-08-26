-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity1_2DungeonViewContainer.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonViewContainer", package.seeall)

local VersionActivity1_2DungeonViewContainer = class("VersionActivity1_2DungeonViewContainer", BaseViewContainer)

function VersionActivity1_2DungeonViewContainer:openInternal(viewParam, isImmediate)
	self:_processParam(viewParam)

	self._isOpenImmediate = isImmediate

	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveGet121InfosReply, self._onReceiveGet121InfosReply, self)
	Activity116Rpc.instance:sendGet116InfosRequest()
	Activity121Rpc.instance:sendGet121InfosRequest()
end

function VersionActivity1_2DungeonViewContainer:_processParam(viewParam)
	viewParam.chapterId = viewParam.chapterId or VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1
	viewParam.episodeId = viewParam.episodeId or VersionActivity1_2DungeonController.instance:_getDefaultFocusEpisode(viewParam.chapterId)

	local episodeCo = DungeonConfig.instance:getEpisodeCO(viewParam.episodeId)

	viewParam.chapterId = episodeCo.chapterId
	self.viewParam = viewParam
end

function VersionActivity1_2DungeonViewContainer:_onReceiveGet121InfosReply(resultCode)
	self.removeEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveGet121InfosReply, self._onReceiveGet121InfosReply, self)

	if resultCode == 0 then
		VersionActivity1_2DungeonViewContainer.super.openInternal(self, self.viewParam, self._isOpenImmediate)
	else
		ViewMgr.instance:closeView(ViewName.VersionActivity1_2DungeonView)
	end
end

function VersionActivity1_2DungeonViewContainer:onContainerUpdateParam()
	self.mapScene:setVisible(true)
	self:_processParam(self.viewParam)
	self.mapEpisodeView:reopenViewParamPrecessed()
	self.mapScene:reopenViewParamPrecessed()
end

function VersionActivity1_2DungeonViewContainer:buildViews()
	local views = {}

	self.mapScene = VersionActivity1_2DungeonMapScene.New()
	self.mapView = VersionActivity1_2DungeonView.New()
	self.mapEpisodeView = VersionActivity1_2DungeonMapEpisodeView.New()
	self.mapSceneElement = VersionActivity1_2DungeonMapSceneElement.New()

	table.insert(views, self.mapView)
	table.insert(views, self.mapSceneElement)
	table.insert(views, self.mapScene)
	table.insert(views, self.mapEpisodeView)
	table.insert(views, DungeonMapElementReward.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function VersionActivity1_2DungeonViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = DungeonNavigateButtonsView.New({
			true,
			true,
			false
		})

		self.navigateView:setOverrideClose(self.overClose, self)
		self.navigateView:setOpenCallback(self.initChapterRecheck, self)

		return {
			self.navigateView
		}
	end
end

function VersionActivity1_2DungeonViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_2Enum.ActivityId.Dungeon)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_2Enum.ActivityId.Dungeon
	})
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function VersionActivity1_2DungeonViewContainer:overClose()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)
	self:closeThis()
end

function VersionActivity1_2DungeonViewContainer:setVisibleInternal(isVisible)
	VersionActivity1_2DungeonViewContainer.super.setVisibleInternal(self, isVisible)

	if self.mapScene then
		self.mapScene:setVisible(isVisible)
	end
end

function VersionActivity1_2DungeonViewContainer:initChapterRecheck()
	local chapterId = self:_getChapterId()

	if self.navigateView then
		self.navigateView:initChapterRecheck(chapterId)
	end
end

function VersionActivity1_2DungeonViewContainer:getInteractiveItem()
	return self.interactView
end

function VersionActivity1_2DungeonViewContainer:_getChapterId()
	if self.viewParam then
		if not self.viewParam.chapterId then
			return VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1
		end
	end
end

return VersionActivity1_2DungeonViewContainer
