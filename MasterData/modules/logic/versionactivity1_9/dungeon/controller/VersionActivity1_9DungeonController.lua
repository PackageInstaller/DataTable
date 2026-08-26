-- chunkname: @modules/logic/versionactivity1_9/dungeon/controller/VersionActivity1_9DungeonController.lua

module("modules.logic.versionactivity1_9.dungeon.controller.VersionActivity1_9DungeonController", package.seeall)

local VersionActivity1_9DungeonController = class("VersionActivity1_9DungeonController", BaseController)

function VersionActivity1_9DungeonController:onInit()
	return
end

function VersionActivity1_9DungeonController:reInit()
	return
end

function VersionActivity1_9DungeonController:openVersionActivityDungeonMapView()
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(VersionActivity1_9Enum.ActivityId.Dungeon)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	ActivityEnterMgr.instance:enterActivity(VersionActivity1_9Enum.ActivityId.Dungeon)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_9Enum.ActivityId.Dungeon
	})

	if DungeonModel.instance:chapterIsLock(DungeonEnum.ChapterId.Main1_7) then
		local formMainView = true

		DungeonController.instance:enterDungeonView(true, formMainView)
	else
		JumpController.instance:jumpTo("3#" .. tostring(DungeonEnum.ChapterId.Main1_7))
	end
end

function VersionActivity1_9DungeonController:openStoreView()
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(VersionActivity1_9Enum.ActivityId.DungeonStore)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(VersionActivity1_9Enum.ActivityId.DungeonStore, self._openStoreView, self)
end

function VersionActivity1_9DungeonController:_openStoreView()
	ViewMgr.instance:openView(ViewName.VersionActivity1_9StoreView)
end

function VersionActivity1_9DungeonController:openTaskView()
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(VersionActivity1_9Enum.ActivityId.Dungeon)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_9TaskView)
end

VersionActivity1_9DungeonController.instance = VersionActivity1_9DungeonController.New()

return VersionActivity1_9DungeonController
