-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/model/GoddessGloryTaskMO.lua

module("logic.extensions.goddessglory.model.GoddessGloryTaskMO", package.seeall)

local GoddessGloryTaskMO = class("GoddessGloryTaskMO")

function GoddessGloryTaskMO:ctor()
	self.taskPlanId = 0
	self.type = 0
	self.taskId = 0
	self.progress = 0
	self.gainPrizeIds = nil
end

function GoddessGloryTaskMO:calCurTaskId()
	if self.taskPlanId == 0 then
		return
	end

	self.taskId = 0

	local tasks = GoddessGloryConfig.instance:getTaskCoList(self.taskPlanId, self.type)

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

function GoddessGloryTaskMO:hasGainPrize(taskId)
	return self.gainPrizeIds and table.indexof(self.gainPrizeIds, taskId)
end

return GoddessGloryTaskMO
