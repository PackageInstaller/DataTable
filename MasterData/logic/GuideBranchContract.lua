-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchContract.lua

module("logic.extensions.guide.model.branch.GuideBranchContract", package.seeall)

local GuideBranchContract = class("GuideBranchContract", GuideBranchBase)

function GuideBranchContract:startGuide()
	GuideBranchContract.super.startGuide(self)
end

function GuideBranchContract:finishGuide()
	GuideBranchContract.super.finishGuide(self)
end

return GuideBranchContract
