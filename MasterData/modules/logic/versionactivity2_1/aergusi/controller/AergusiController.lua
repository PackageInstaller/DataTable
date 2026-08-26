-- chunkname: @modules/logic/versionactivity2_1/aergusi/controller/AergusiController.lua

module("modules.logic.versionactivity2_1.aergusi.controller.AergusiController", package.seeall)

local AergusiController = class("AergusiController", BaseController)

function AergusiController:addConstEvents()
	return
end

function AergusiController:reInit()
	return
end

function AergusiController:openAergusiLevelView(actId, isReqInfo)
	actId = actId or VersionActivity2_1Enum.ActivityId.Aergusi

	if isReqInfo then
		Activity163Rpc.instance:sendGet163InfosRequest(actId, function(cmd, resultCode, msg)
			if resultCode == 0 then
				ViewMgr.instance:openView(ViewName.AergusiLevelView)
			end
		end)
	else
		ViewMgr.instance:openView(ViewName.AergusiLevelView)
	end
end

function AergusiController:openAergusiTaskView()
	ViewMgr.instance:openView(ViewName.AergusiTaskView)
end

function AergusiController:openAergusiDialogView(data)
	ViewMgr.instance:openView(ViewName.AergusiDialogView, data)
end

function AergusiController:openAergusiClueView(data)
	ViewMgr.instance:openView(ViewName.AergusiClueView, data)
end

function AergusiController:openAergusiFailView(data)
	ViewMgr.instance:openView(ViewName.AergusiFailView, data)
end

function AergusiController:openAergusiDialogStartView(groupId, callback, callbackObj)
	local data = {}

	data.groupId = groupId
	data.callback = callback
	data.callbackObj = callbackObj

	ViewMgr.instance:openView(ViewName.AergusiDialogStartView, data)
end

function AergusiController:openAergusiDialogEndView(episodeId, callback, callbackObj)
	local data = {}

	data.episodeId = episodeId
	data.callback = callback
	data.callbackObj = callbackObj

	ViewMgr.instance:openView(ViewName.AergusiDialogEndView, data)
end

function AergusiController:delayReward(delayTime, taskMO)
	if self._actTaskMO == nil and taskMO then
		self._actTaskMO = taskMO

		TaskDispatcher.runDelay(self._onPreFinish, self, delayTime)

		return true
	end

	return false
end

function AergusiController:_onPreFinish()
	local actTaskMO = self._actTaskMO

	self._actTaskMO = nil

	if actTaskMO and (actTaskMO.id == AergusiEnum.TaskMOAllFinishId or actTaskMO:alreadyGotReward()) then
		AergusiTaskListModel.instance:preFinish(actTaskMO)

		self._actTaskId = actTaskMO.id

		TaskDispatcher.runDelay(self._onRewardTask, self, AergusiEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function AergusiController:_onRewardTask()
	local actTaskId = self._actTaskId

	self._actTaskId = nil

	if actTaskId then
		if actTaskId == AergusiEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity163)
		else
			TaskRpc.instance:sendFinishTaskRequest(actTaskId)
		end
	end
end

function AergusiController:oneClaimReward(actId)
	local list = AergusiTaskListModel.instance:getList()

	for _, actTaskMO in pairs(list) do
		if actTaskMO:alreadyGotReward() and actTaskMO.id ~= AergusiEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishTaskRequest(actTaskMO.id)
		end
	end
end

AergusiController.instance = AergusiController.New()

return AergusiController
