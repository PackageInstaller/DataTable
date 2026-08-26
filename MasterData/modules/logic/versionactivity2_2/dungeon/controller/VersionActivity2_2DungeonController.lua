-- chunkname: @modules/logic/versionactivity2_2/dungeon/controller/VersionActivity2_2DungeonController.lua

module("modules.logic.versionactivity2_2.dungeon.controller.VersionActivity2_2DungeonController", package.seeall)

local VersionActivity2_2DungeonController = class("VersionActivity2_2DungeonController", BaseController)

function VersionActivity2_2DungeonController:onInit()
	return
end

function VersionActivity2_2DungeonController:reInit()
	return
end

function VersionActivity2_2DungeonController:openVersionActivityDungeonMapView()
	local enterViewStatus, enterViewToastId, enterViewToastParam = ActivityHelper.getActivityStatusAndToast(VersionActivity2_2Enum.ActivityId.EnterView)

	if enterViewStatus ~= ActivityEnum.ActivityStatus.Normal then
		if enterViewToastId then
			GameFacade.showToast(enterViewToastId, enterViewToastParam)
		end

		return
	end

	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(VersionActivity2_2Enum.ActivityId.Dungeon)

	if status == ActivityEnum.ActivityStatus.Normal then
		ActivityEnterMgr.instance:enterActivity(VersionActivity2_2Enum.ActivityId.Dungeon)
		ActivityRpc.instance:sendActivityNewStageReadRequest({
			VersionActivity2_2Enum.ActivityId.Dungeon
		})
	end

	if DungeonModel.instance:chapterIsLock(DungeonEnum.ChapterId.Main1_8) then
		local formMainView = true

		DungeonController.instance:enterDungeonView(true, formMainView)
	else
		JumpController.instance:jumpTo("3#" .. tostring(DungeonEnum.ChapterId.Main1_8))
	end
end

function VersionActivity2_2DungeonController:openTaskView()
	local typeIds = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(typeIds, self._openTaskViewAfterRpc, self)
end

function VersionActivity2_2DungeonController:_openTaskViewAfterRpc()
	ViewMgr.instance:openView(ViewName.VersionActivity2_2TaskView)
end

function VersionActivity2_2DungeonController:openStoreView()
	local actId = VersionActivity2_2Enum.ActivityId.DungeonStore

	if not VersionActivityEnterHelper.checkCanOpen(actId) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(actId, self._openStoreViewAfterRpc, self)
end

function VersionActivity2_2DungeonController:_openStoreViewAfterRpc()
	ViewMgr.instance:openView(ViewName.VersionActivity2_2StoreView)
end

VersionActivity2_2DungeonController.instance = VersionActivity2_2DungeonController.New()

return VersionActivity2_2DungeonController
