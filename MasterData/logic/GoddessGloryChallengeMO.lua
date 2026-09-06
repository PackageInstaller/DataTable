-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/model/GoddessGloryChallengeMO.lua

module("logic.extensions.goddessglory.model.GoddessGloryChallengeMO", package.seeall)

local GoddessGloryChallengeMO = class("GoddessGloryChallengeMO")

function GoddessGloryChallengeMO:ctor()
	self.challengeId = 0
	self.stages = nil
	self.storyId = 0
	self.hasPlayedStory = false
	self.weeklyTasks = nil
end

function GoddessGloryChallengeMO:hasTaskCompeleted()
	if not self.weeklyTasks then
		return false
	end

	for i = 1, #self.weeklyTasks do
		local taskData = self.weeklyTasks[i]
		local taskCo = GoddessGloryConfig.instance:getWeeklyTaskCo(self.challengeId, taskData.type, taskData.taskId)

		if not taskData:hasGainPrize(taskData.taskId) and taskData.progress >= taskCo.maxProgress then
			return true
		end
	end

	return false
end

return GoddessGloryChallengeMO
