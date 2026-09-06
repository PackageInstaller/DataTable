-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchExp.lua

module("logic.extensions.guide.model.branch.GuideBranchExp", package.seeall)

local GuideBranchExp = class("GuideBranchExp", GuideBranchBase)

function GuideBranchExp:startGuide()
	GuideBranchExp.super.startGuide(self)
	GlobalDispatcher:addListener(GlobalNotify.BagPetAttrChanged, self._OnPetDataUpdated, self)
end

function GuideBranchExp:_OnPetDataUpdated()
	GlobalDispatcher:removeListener(GlobalNotify.BagPetAttrChanged, self._OnPetDataUpdated, self)
	GuideController.instance:finishGuide()
end

return GuideBranchExp
