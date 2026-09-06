-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchFirstOpenFb.lua

module("logic.extensions.guide.model.branch.GuideBranchFirstOpenFb", package.seeall)

local GuideBranchFirstOpenFb = class("GuideBranchFirstOpenFb", GuideBranchBase)

function GuideBranchFirstOpenFb:ctor(branchId, currGuideId)
	GuideBranchFirstOpenFb.super.ctor(self, branchId, currGuideId)
end

function GuideBranchFirstOpenFb:forceToInView(viewName, childName)
	if self._currGuide then
		if viewName == "plotchapterview" then
			return 1
		elseif viewName == "plotstageview" then
			return 2
		end
	end

	return 0
end

function GuideBranchFirstOpenFb:onExitView(viewName)
	return 0
end

function GuideBranchFirstOpenFb:onEnterView(viewName)
	return 0
end

return GuideBranchFirstOpenFb
