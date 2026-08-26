-- chunkname: @modules/logic/versionactivity2_6/dungeon/controller/VersionActivity2_6DungeonController.lua

module("modules.logic.versionactivity2_6.dungeon.controller.VersionActivity2_6DungeonController", package.seeall)

local VersionActivity2_6DungeonController = class("VersionActivity2_6DungeonController", BaseController)

function VersionActivity2_6DungeonController:onInit()
	return
end

function VersionActivity2_6DungeonController:reInit()
	return
end

function VersionActivity2_6DungeonController:openVersionActivityDungeonMapView()
	local enterViewStatus, enterViewToastId, enterViewToastParam = ActivityHelper.getActivityStatusAndToast(VersionActivity2_6Enum.ActivityId.EnterView)

	if enterViewStatus ~= ActivityEnum.ActivityStatus.Normal then
		if enterViewToastId then
			GameFacade.showToast(enterViewToastId, enterViewToastParam)
		end

		return
	end

	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(VersionActivity2_6Enum.ActivityId.Dungeon)

	if status == ActivityEnum.ActivityStatus.Normal then
		ActivityEnterMgr.instance:enterActivity(VersionActivity2_6Enum.ActivityId.Dungeon)
		ActivityRpc.instance:sendActivityNewStageReadRequest({
			VersionActivity2_6Enum.ActivityId.Dungeon
		})
	end

	if DungeonModel.instance:chapterIsLock(DungeonEnum.ChapterId.Main1_9) then
		local formMainView = true

		DungeonController.instance:enterDungeonView(true, formMainView)
	else
		JumpController.instance:jumpTo("3#" .. tostring(DungeonEnum.ChapterId.Main1_9))
	end
end

function VersionActivity2_6DungeonController:openTaskView()
	local typeIds = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(typeIds, self._openTaskViewAfterRpc, self)
end

function VersionActivity2_6DungeonController:_openTaskViewAfterRpc()
	ViewMgr.instance:openView(ViewName.VersionActivity2_6TaskView)
end

function VersionActivity2_6DungeonController:openStoreView()
	local actId = VersionActivity2_6Enum.ActivityId.DungeonStore

	if not VersionActivityEnterHelper.checkCanOpen(actId) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(actId, self._openStoreViewAfterRpc, self)
end

function VersionActivity2_6DungeonController:_openStoreViewAfterRpc()
	ViewMgr.instance:openView(ViewName.VersionActivity2_6StoreView)
end

VersionActivity2_6DungeonController.instance = VersionActivity2_6DungeonController.New()

return VersionActivity2_6DungeonController
