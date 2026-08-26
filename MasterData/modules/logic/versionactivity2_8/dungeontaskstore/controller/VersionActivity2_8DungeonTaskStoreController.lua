-- chunkname: @modules/logic/versionactivity2_8/dungeontaskstore/controller/VersionActivity2_8DungeonTaskStoreController.lua

module("modules.logic.versionactivity2_8.dungeontaskstore.controller.VersionActivity2_8DungeonTaskStoreController", package.seeall)

local VersionActivity2_8DungeonTaskStoreController = class("VersionActivity2_8DungeonTaskStoreController", BaseController)

function VersionActivity2_8DungeonTaskStoreController:onInit()
	return
end

function VersionActivity2_8DungeonTaskStoreController:reInit()
	return
end

function VersionActivity2_8DungeonTaskStoreController:openVersionActivityDungeonMapView(enterViewActId, dungeonActId, chapterId)
	local enterViewStatus, enterViewToastId, enterViewToastParam = ActivityHelper.getActivityStatusAndToast(enterViewActId)

	if enterViewStatus ~= ActivityEnum.ActivityStatus.Normal then
		if enterViewToastId then
			GameFacade.showToast(enterViewToastId, enterViewToastParam)
		end

		return
	end

	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(dungeonActId)

	if status == ActivityEnum.ActivityStatus.Normal then
		ActivityEnterMgr.instance:enterActivity(dungeonActId)
		ActivityRpc.instance:sendActivityNewStageReadRequest({
			dungeonActId
		})
	end

	if DungeonModel.instance:chapterIsLock(chapterId) then
		local formMainView = true

		DungeonController.instance:enterDungeonView(true, formMainView)
	else
		JumpController.instance:jumpTo("3#" .. tostring(chapterId))
	end
end

function VersionActivity2_8DungeonTaskStoreController:getModuleConfig()
	return self._moduleConfig
end

function VersionActivity2_8DungeonTaskStoreController:openTaskView(moduleConfig)
	self._moduleConfig = moduleConfig
	module_views.VersionActivity2_8TaskView.mainRes = self._moduleConfig.TaskViewRes
	module_views.VersionActivity2_8TaskView.otherRes[1] = self._moduleConfig.TaskItemRes

	local typeIds = {
		TaskEnum.TaskType.ActivityDungeon
	}

	TaskRpc.instance:sendGetTaskInfoRequest(typeIds, self._openTaskViewAfterRpc, self)
end

function VersionActivity2_8DungeonTaskStoreController:_openTaskViewAfterRpc()
	ViewMgr.instance:openView(ViewName.VersionActivity2_8TaskView)
end

function VersionActivity2_8DungeonTaskStoreController:openStoreView(moduleConfig)
	self._moduleConfig = moduleConfig
	module_views.VersionActivity2_8StoreView.mainRes = self._moduleConfig.StoreViewRes

	local actId = VersionActivity2_8DungeonTaskStoreController.instance:getModuleConfig().DungeonStore

	if not VersionActivityEnterHelper.checkCanOpen(actId) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(actId, self._openStoreViewAfterRpc, self)
end

function VersionActivity2_8DungeonTaskStoreController:_openStoreViewAfterRpc()
	ViewMgr.instance:openView(ViewName.VersionActivity2_8StoreView)
end

VersionActivity2_8DungeonTaskStoreController.instance = VersionActivity2_8DungeonTaskStoreController.New()

return VersionActivity2_8DungeonTaskStoreController
