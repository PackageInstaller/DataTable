-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchFormation.lua

module("logic.extensions.guide.model.branch.GuideBranchFormation", package.seeall)

local GuideBranchFormation = class("GuideBranchFormation", GuideBranchBase)

function GuideBranchFormation:shouldTrigger()
	if self._currGuide then
		local guideId = self._currGuide:getGuideId()

		if guideId == 220 and FormationFacade.instance:isCurFormationEmpty() then
			return
		end
	end

	return GuideBranchFormation.super.shouldTrigger(self)
end

return GuideBranchFormation
