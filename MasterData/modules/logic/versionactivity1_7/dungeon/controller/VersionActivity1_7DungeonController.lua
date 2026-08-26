-- chunkname: @modules/logic/versionactivity1_7/dungeon/controller/VersionActivity1_7DungeonController.lua

module("modules.logic.versionactivity1_7.dungeon.controller.VersionActivity1_7DungeonController", package.seeall)

local VersionActivity1_7DungeonController = class("VersionActivity1_7DungeonController", BaseController)

function VersionActivity1_7DungeonController:onInit()
	return
end

function VersionActivity1_7DungeonController:reInit()
	return
end

function VersionActivity1_7DungeonController:openVersionActivityDungeonMapView()
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(VersionActivity1_7Enum.ActivityId.Dungeon)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	ActivityEnterMgr.instance:enterActivity(VersionActivity1_7Enum.ActivityId.Dungeon)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_7Enum.ActivityId.Dungeon
	})

	if DungeonModel.instance:chapterIsLock(DungeonEnum.ChapterId.Main1_6) then
		DungeonController.instance:enterDungeonView(true)
	else
		JumpController.instance:jumpTo("3#" .. tostring(DungeonEnum.ChapterId.Main1_6))
	end
end

function VersionActivity1_7DungeonController:openStoreView()
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(VersionActivity1_7Enum.ActivityId.DungeonStore)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(VersionActivity1_7Enum.ActivityId.DungeonStore, self._openStoreView, self)
end

function VersionActivity1_7DungeonController:_openStoreView()
	ViewMgr.instance:openView(ViewName.VersionActivity1_7StoreView)
end

function VersionActivity1_7DungeonController:openTaskView()
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(VersionActivity1_7Enum.ActivityId.Dungeon)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_7TaskView)
end

VersionActivity1_7DungeonController.instance = VersionActivity1_7DungeonController.New()

return VersionActivity1_7DungeonController
