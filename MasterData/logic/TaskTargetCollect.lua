-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetCollect.lua

module("logic.extensions.task.model.target.TaskTargetCollect", package.seeall)

local TaskTargetCollect = class("TaskTargetCollect", TaskTargetBase)

function TaskTargetCollect:ctor(taskStep, target)
	TaskTargetCollect.super.ctor(self, taskStep, target)

	self._progress = MaterialFacade.instance:getMatNumber(MatType.Item, self:getItemId())
end

function TaskTargetCollect:getTargetNum()
	return self.target.itemNum
end

function TaskTargetCollect:getProgress()
	if not TaskModel.instance.isTesting then
		-- block empty
	else
		self._progress = self:getTargetNum()
	end

	return self._progress
end

return TaskTargetCollect
