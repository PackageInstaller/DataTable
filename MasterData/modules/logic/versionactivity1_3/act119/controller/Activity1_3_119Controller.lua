-- chunkname: @modules/logic/versionactivity1_3/act119/controller/Activity1_3_119Controller.lua

module("modules.logic.versionactivity1_3.act119.controller.Activity1_3_119Controller", package.seeall)

local Activity1_3_119Controller = class("Activity1_3_119Controller", BaseController)

function Activity1_3_119Controller:onInit()
	return
end

function Activity1_3_119Controller:onInitFinish()
	return
end

function Activity1_3_119Controller:reInit()
	return
end

function Activity1_3_119Controller:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._get119TaskInfo, self)
end

function Activity1_3_119Controller:_get119TaskInfo(activityId)
	if activityId then
		local activityCO = ActivityConfig.instance:getActivityCo(activityId)

		if activityCO and activityCO.typeId ~= VersionActivity1_3Enum.ActivityId.Act307 then
			return
		end
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity119
	})
end

function Activity1_3_119Controller:openView()
	ViewMgr.instance:openView(ViewName.Activity1_3_119View)
end

Activity1_3_119Controller.instance = Activity1_3_119Controller.New()

return Activity1_3_119Controller
