-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetChatNpc.lua

module("logic.extensions.task.model.target.TaskTargetChatNpc", package.seeall)

local TaskTargetChatNpc = class("TaskTargetChatNpc", TaskTargetBase)

function TaskTargetChatNpc:getDoingPerformed()
	local chatStoryId = self:getChatStoryId()

	if chatStoryId and chatStoryId > 0 and not self.chatNpcPerform then
		self.chatNpcPerform = {
			performedType = TaskConst.PERFORMED_CHATNPC,
			method = TaskConst.PM_STORY
		}
		self.chatNpcPerform.storyId = self.target.chatStoryId
		self.chatNpcPerform.taskStep = self.taskStep
		self.chatNpcPerform.npcId = self.target.chatNpcId
		self.chatNpcPerform.target = self
	end

	return self.chatNpcPerform
end

return TaskTargetChatNpc
