-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchEffect.lua

module("logic.extensions.guide.model.branch.GuideBranchEffect", package.seeall)

local GuideBranchEffect = class("GuideBranchEffect", GuideBranchBase)

function GuideBranchEffect:ctor(branchId, guideId)
	GuideBranchEffect.super.ctor(self, branchId, guideId)
end

function GuideBranchEffect:startGuide()
	GuideBranchEffect.super.startGuide(self)
	TaskController.instance:pause()
end

function GuideBranchEffect:setGuide(guideId)
	GuideBranchEffect.super.setGuide(self, guideId)

	if self:isFinished() then
		PetDisplayController.instance:checkAndOpenDisplay()
	end
end

function GuideBranchEffect:finishGuide()
	GuideBranchEffect.super.finishGuide(self)
	TaskController.instance:resume()
end

return GuideBranchEffect
