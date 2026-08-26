-- chunkname: @modules/logic/versionactivity1_2/dreamtail/controller/Activity119Controller.lua

module("modules.logic.versionactivity1_2.dreamtail.controller.Activity119Controller", package.seeall)

local Activity119Controller = class("Activity119Controller", BaseController)

function Activity119Controller:onInit()
	return
end

function Activity119Controller:onInitFinish()
	return
end

function Activity119Controller:reInit()
	return
end

function Activity119Controller:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._get119TaskInfo, self)
end

function Activity119Controller:_get119TaskInfo(activityId)
	if activityId then
		local activityCO = ActivityConfig.instance:getActivityCo(activityId)

		if activityCO and activityCO.typeId ~= ActivityEnum.ActivityTypeID.DreamTail then
			return
		end
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity119
	})
end

function Activity119Controller:openAct119View()
	ViewMgr.instance:openView(ViewName.Activity119View)
end

Activity119Controller.instance = Activity119Controller.New()

return Activity119Controller
