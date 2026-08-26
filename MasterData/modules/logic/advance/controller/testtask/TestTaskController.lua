-- chunkname: @modules/logic/advance/controller/testtask/TestTaskController.lua

module("modules.logic.advance.controller.testtask.TestTaskController", package.seeall)

local TestTaskController = class("TestTaskController", BaseController)

function TestTaskController:onInit()
	return
end

function TestTaskController:reInit()
	return
end

function TestTaskController:openTestTaskView()
	self:_openTestTaskView()
end

function TestTaskController:_openTestTaskView()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.TestTask
	}, function()
		ViewMgr.instance:openView(ViewName.TestTaskView)
	end)
end

TestTaskController.instance = TestTaskController.New()

LuaEventSystem.addEventMechanism(TestTaskController.instance)

return TestTaskController
