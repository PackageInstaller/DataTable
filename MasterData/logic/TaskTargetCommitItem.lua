-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetCommitItem.lua

module("logic.extensions.task.model.target.TaskTargetCommitItem", package.seeall)

local TaskTargetCommitItem = class("TaskTargetCommitItem", TaskTargetBase)

function TaskTargetCommitItem:ctor(taskStep, target)
	TaskTargetCommitItem.super.ctor(self, taskStep, target)

	self._progress = MaterialFacade.instance:getMatNumber(MatType.Item, self:getItemId())
end

function TaskTargetCommitItem:getTargetNum()
	return self.target.itemNum
end

function TaskTargetCommitItem:getProgress()
	if not TaskModel.instance.isTesting then
		-- block empty
	else
		self._progress = self:getTargetNum()
	end

	return self._progress
end

return TaskTargetCommitItem
