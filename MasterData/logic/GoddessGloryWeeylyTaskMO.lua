-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/model/GoddessGloryWeeylyTaskMO.lua

module("logic.extensions.goddessglory.model.GoddessGloryWeeylyTaskMO", package.seeall)

local GoddessGloryWeeylyTaskMO = class("GoddessGloryWeeylyTaskMO")

function GoddessGloryWeeylyTaskMO:ctor()
	self.challengeId = 0
	self.type = 0
	self.taskId = 0
	self.progress = 0
	self.gainPrizeIds = nil
end

function GoddessGloryWeeylyTaskMO:calCurTaskId()
	if self.challengeId == 0 then
		return
	end

	self.taskId = 0

	local tasks = GoddessGloryConfig.instance:getWeeklyTaskCoList(self.challengeId, self.type)

	for i = 1, #tasks do
		if not self:hasGainPrize(tasks[i].taskId) then
			self.taskId = tasks[i].taskId

			break
		end
	end

	if self.taskId == 0 then
		self.taskId = tasks[#tasks].taskId
	end
end

function GoddessGloryWeeylyTaskMO:hasGainPrize(taskId)
	return self.gainPrizeIds and table.indexof(self.gainPrizeIds, taskId)
end

return GoddessGloryWeeylyTaskMO
