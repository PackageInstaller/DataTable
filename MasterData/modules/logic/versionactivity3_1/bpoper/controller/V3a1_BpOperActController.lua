-- chunkname: @modules/logic/versionactivity3_1/bpoper/controller/V3a1_BpOperActController.lua

module("modules.logic.versionactivity3_1.bpoper.controller.V3a1_BpOperActController", package.seeall)

local V3a1_BpOperActController = class("V3a1_BpOperActController", BaseController)

function V3a1_BpOperActController:onInit()
	return
end

function V3a1_BpOperActController:reInit()
	return
end

function V3a1_BpOperActController:onInitFinish()
	return
end

function V3a1_BpOperActController:addConstEvents()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.checkActivity, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self.checkActivity, self)
end

function V3a1_BpOperActController:checkActivity()
	if not ActivityModel.instance:isActOnLine(BpModel.instance:getCurVersionOperActId()) then
		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.BpOperAct
	})
end

V3a1_BpOperActController.instance = V3a1_BpOperActController.New()

return V3a1_BpOperActController
