-- chunkname: @modules/logic/versionactivity1_5/peaceulu/controller/PeaceUluController.lua

module("modules.logic.versionactivity1_5.peaceulu.controller.PeaceUluController", package.seeall)

local PeaceUluController = class("PeaceUluController", BaseController)

function PeaceUluController:onInit()
	return
end

function PeaceUluController:onInitFinish()
	return
end

function PeaceUluController:addConstEvents()
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
end

function PeaceUluController:_onUpdateTaskList(msg)
	PeaceUluModel.instance:setTasksInfo(msg.taskInfo)
end

function PeaceUluController:openPeaceUluView(param)
	PeaceUluRpc.instance:sendGet145InfosRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu, function()
		ViewMgr.instance:openView(ViewName.PeaceUluView, {
			param = param
		})
	end, self)
end

function PeaceUluController:reInit()
	return
end

PeaceUluController.instance = PeaceUluController.New()

return PeaceUluController
