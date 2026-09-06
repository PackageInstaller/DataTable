-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargeUserAction.lua

module("logic.extensions.task.model.target.TaskTargeUserAction", package.seeall)

local TaskTargeUserAction = class("TaskTargeUserAction", TaskTargetBase)

function TaskTargeUserAction:getTargetNum()
	return self.target.times
end

function TaskTargeUserAction:getDoingPerformed()
	if self.target.actionType == TaskConst.USER_OP_UI_INTERACTIVE then
		return
	end

	local chatStoryId = self:getChatStoryId()

	if chatStoryId and chatStoryId > 0 and not self.doingPerform then
		self.doingPerform = {
			performedType = TaskConst.PERFORMED_USERACTION,
			method = TaskConst.PM_STORY
		}
		self.doingPerform.storyId = self.target.chatStoryId
		self.doingPerform.taskStep = self.taskStep
		self.doingPerform.target = self
	end

	return self.doingPerform
end

return TaskTargeUserAction
