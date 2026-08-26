-- chunkname: @modules/logic/advance/model/testtask/TestTaskModel.lua

module("modules.logic.advance.model.testtask.TestTaskModel", package.seeall)

local TestTaskModel = class("TestTaskModel", BaseModel)

function TestTaskModel:onInit()
	return
end

function TestTaskModel:reInit()
	return
end

function TestTaskModel:getTaskData(id)
	return TaskModel.instance:getTaskById(id)
end

TestTaskModel.instance = TestTaskModel.New()

return TestTaskModel
