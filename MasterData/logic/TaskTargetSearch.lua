-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetSearch.lua

module("logic.extensions.task.model.target.TaskTargetSearch", package.seeall)

local TaskTargetSearch = class("TaskTargetSearch", TaskTargetBase)

function TaskTargetSearch:getDoingPerformed()
	local chatStoryId = self:getChatStoryId()

	if chatStoryId and chatStoryId > 0 and not self.searchZonePerform then
		self.searchZonePerform = {
			performedType = TaskConst.PERFORMED_SEACHZONE,
			method = TaskConst.PM_STORY
		}
		self.searchZonePerform.storyId = self.target.chatStoryId
		self.searchZonePerform.taskStep = self.taskStep
		self.searchZonePerform.sceneId = self.target.sceneId
		self.searchZonePerform.triggerId = self.target.triggerId
		self.searchZonePerform.target = self
	end

	return self.searchZonePerform
end

return TaskTargetSearch
