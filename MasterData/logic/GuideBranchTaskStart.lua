-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchTaskStart.lua

module("logic.extensions.guide.model.branch.GuideBranchTaskStart", package.seeall)

local GuideBranchTaskStart = class("GuideBranchTaskStart", GuideBranchBase)

function GuideBranchTaskStart:shouldTrigger()
	if self._currGuide then
		local taskes = TaskFacade.instance:getCurrentTriggerTaskesShowedOnUI()

		if not taskes or #taskes == 0 then
			return
		end

		local params = self._currGuide:getJsonParams()
		local ts = params.taskStart

		if ts then
			local taskId = ts[1]
			local stepId = ts[2]
			local idx = -1

			for i = 1, #taskes do
				local task = taskes[i].task

				if task.taskCo and task.taskCo.taskId == taskId and task.currStep and stepId == task.currStep:getStepId() then
					idx = i

					break
				end
			end

			if idx ~= -1 then
				return GuideBranchTaskStart.super.shouldTrigger(self)
			else
				return
			end
		end
	end

	return GuideBranchTaskStart.super.shouldTrigger(self)
end

return GuideBranchTaskStart
