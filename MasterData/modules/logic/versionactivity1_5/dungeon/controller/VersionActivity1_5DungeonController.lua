-- chunkname: @modules/logic/versionactivity1_5/dungeon/controller/VersionActivity1_5DungeonController.lua

module("modules.logic.versionactivity1_5.dungeon.controller.VersionActivity1_5DungeonController", package.seeall)

local VersionActivity1_5DungeonController = class("VersionActivity1_5DungeonController", BaseController)

function VersionActivity1_5DungeonController:onInit()
	return
end

function VersionActivity1_5DungeonController:reInit()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenMapViewDone, self)
end

function VersionActivity1_5DungeonController:openVersionActivityDungeonMapView(chapterId, episodeId, rpcCallback, rpcCallbackObj)
	self.openViewParam = {
		chapterId = chapterId,
		episodeId = episodeId
	}
	self.rpcCallback = rpcCallback
	self.rpcCallbackObj = rpcCallbackObj
	self.receiveTaskReply = nil
	self.receiveAct139InfoReply = nil

	VersionActivity1_5DungeonModel.instance:init()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, self._onReceiveTaskReply, self)
	VersionActivity1_5DungeonRpc.instance:sendGet139InfosRequest(self._onReceiveAct139InfoReply, self)
end

function VersionActivity1_5DungeonController:_onReceiveTaskReply()
	self.receiveTaskReply = true

	self:_openVersionActivityDungeonMapView()
end

function VersionActivity1_5DungeonController:_onReceiveAct139InfoReply()
	self.receiveAct139InfoReply = true

	self:_openVersionActivityDungeonMapView()
end

function VersionActivity1_5DungeonController:_openVersionActivityDungeonMapView()
	if not self.receiveTaskReply or not self.receiveAct139InfoReply then
		return
	end

	self.receiveTaskReply = nil
	self.receiveAct139InfoReply = nil

	if self.rpcCallback then
		self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenMapViewDone, self)
		self.addEventCb(self, ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self._onOpenMapViewDone, self)
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_5DungeonMapView, self.openViewParam)
end

function VersionActivity1_5DungeonController:_onOpenMapViewDone(viewName)
	if viewName == ViewName.VersionActivity1_5DungeonMapView then
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenMapViewDone, self)
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self._onOpenMapViewDone, self)

		local callback = self.rpcCallback
		local callbackObj = self.rpcCallbackObj

		self.rpcCallback = nil
		self.rpcCallbackObj = nil

		if callback then
			self.rpcCallback(callbackObj)
		end
	end
end

function VersionActivity1_5DungeonController:getEpisodeMapConfig(episodeId)
	local episodeCo = self:getStoryEpisodeCo(episodeId)

	return DungeonConfig.instance:getChapterMapCfg(VersionActivity1_5DungeonEnum.DungeonChapterId.Story, episodeCo.preEpisode)
end

function VersionActivity1_5DungeonController:getEpisodeIndex(episodeId)
	local episodeConfig = self:getStoryEpisodeCo(episodeId)

	return DungeonConfig.instance:getChapterEpisodeIndexWithSP(episodeConfig.chapterId, episodeConfig.id)
end

function VersionActivity1_5DungeonController:getStoryEpisodeCo(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig.chapterId == VersionActivity1_5DungeonEnum.DungeonChapterId.Hard then
		episodeId = episodeId - 10000
		episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	elseif episodeConfig.chapterId == VersionActivity1_5DungeonEnum.DungeonChapterId.ElementFight then
		-- block empty
	else
		while episodeConfig.chapterId ~= VersionActivity1_5DungeonEnum.DungeonChapterId.Story do
			episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
		end
	end

	return episodeConfig
end

function VersionActivity1_5DungeonController:openTaskView()
	ViewMgr.instance:openView(ViewName.VersionActivity1_5TaskView)
end

function VersionActivity1_5DungeonController:openStoreView()
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(VersionActivity1_5Enum.ActivityId.DungeonStore, function()
		ViewMgr.instance:openView(ViewName.VersionActivity1_5StoreView)
	end)
end

function VersionActivity1_5DungeonController:openDispatchView(dispatchId)
	local status = VersionActivity1_5DungeonModel.instance:getDispatchStatus(dispatchId)

	if status == VersionActivity1_5DungeonEnum.DispatchStatus.Finished then
		return
	end

	VersionActivity1_5DungeonModel.instance:checkDispatchFinish()
	ViewMgr.instance:openView(ViewName.VersionActivity1_5DispatchView, {
		dispatchId = dispatchId
	})
end

function VersionActivity1_5DungeonController:openRevivalTaskView()
	local revivalTaskUnLockEpisodeId = VersionActivity1_5DungeonConfig.instance.revivalTaskUnlockEpisodeId

	if not DungeonModel.instance:hasPassLevelAndStory(revivalTaskUnLockEpisodeId) then
		GameFacade.showToast(VersionActivity1_5DungeonConfig.instance.revivalTaskLockToastId)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_5RevivalTaskView)
end

function VersionActivity1_5DungeonController:openBuildView()
	local episodeId = VersionActivity1_5DungeonConfig.instance.buildUnlockEpisodeId

	if not DungeonModel.instance:hasPassLevelAndStory(episodeId) then
		GameFacade.showToast(VersionActivity1_5DungeonConfig.instance.buildLockToastId)

		return
	end

	VersionActivity1_5DungeonRpc.instance:sendGet140InfosRequest(self._openBuildView, self)
end

function VersionActivity1_5DungeonController:_openBuildView()
	ViewMgr.instance:openView(ViewName.V1a5BuildingView)
end

function VersionActivity1_5DungeonController:setLastEpisodeId(episodeId)
	self.lastEpisodeId = episodeId
end

function VersionActivity1_5DungeonController:getLastEpisodeId()
	return self.lastEpisodeId
end

VersionActivity1_5DungeonController.instance = VersionActivity1_5DungeonController.New()

return VersionActivity1_5DungeonController
