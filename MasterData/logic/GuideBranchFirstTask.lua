-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchFirstTask.lua

module("logic.extensions.guide.model.branch.GuideBranchFirstTask", package.seeall)

local GuideBranchFirstTask = class("GuideBranchFirstTask", GuideBranchBase)

function GuideBranchFirstTask:ctor(branchId, currGuideId)
	GuideBranchFirstTask.super.ctor(self, branchId, currGuideId)
	print(">>>>>>>>>>>>>>>>>>> GuideBranchFirstTask", branchId, currGuideId)
end

function GuideBranchFirstTask:startGuide()
	GuideBranchFirstTask.super.startGuide(self)
end

function GuideBranchFirstTask:finishGuide()
	GuideBranchFirstTask.super.finishGuide(self)
end

function GuideBranchFirstTask:shouldTrigger()
	if not TaskFacade.instance:isTaskStepFinished(1, 1) then
		return GuideBranchFirstTask.super.shouldTrigger(self)
	end
end

return GuideBranchFirstTask
