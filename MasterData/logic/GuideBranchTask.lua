-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchTask.lua

module("logic.extensions.guide.model.branch.GuideBranchTask", package.seeall)

local GuideBranchTask = class("GuideBranchTask", GuideBranchBase)

function GuideBranchTask:shouldTrigger()
	if self._currGuide then
		local taskes = TaskFacade.instance:getCurrentTriggerTaskesShowedOnUI()

		if not taskes or #taskes == 0 then
			return
		end
	end

	return GuideBranchTask.super.shouldTrigger(self)
end

return GuideBranchTask
