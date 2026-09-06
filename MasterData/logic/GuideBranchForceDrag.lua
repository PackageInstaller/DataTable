-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchForceDrag.lua

module("logic.extensions.guide.model.branch.GuideBranchForceDrag", package.seeall)

local GuideBranchForceDrag = class("GuideBranchForceDrag", GuideBranchBase)

function GuideBranchForceDrag:ctor(branchId, currGuideId)
	GuideBranchForceDrag.super.ctor(self, branchId, currGuideId)
	GlobalDispatcher:addListener("guide_drag_right", self.startGuideDragRight, self)
	print(">>>>>>>>>>>>>>>>>>> GuideBranchForceDrag", branchId, currGuideId)
end

function GuideBranchForceDrag:startGuide()
	GuideBranchForceDrag.super.startGuide(self)

	if self:isGuiding() then
		local guideType = self._currGuide:getGuideUIType()

		if guideType == GuideConst.GUIDE_FORCEDRAG then
			print(">>>>>>>>>>>> 白虎拖12")
		end
	end
end

function GuideBranchForceDrag:finishGuide()
	GuideBranchForceDrag.super.finishGuide(self)
end

function GuideBranchForceDrag:startGuideDragRight()
	if self:isGuiding() then
		GlobalDispatcher:removeListener("guide_drag_right", self.startGuideDragRight, self)
		print(">>>>>>>>>>>>>>>>>>> 拖拽正确", self:isGuiding())
		GuideController.instance:finishGuide()
	end
end

function GuideBranchForceDrag:onEnterView(viewName)
	if self._currGuide then
		GlobalDispatcher:dispatch(GlobalNotify.BagPetsStopAnimator)

		if viewName == ViewName.WuShenPrePareView then
			return 2
		end

		return 1
	end

	return 0
end

return GuideBranchForceDrag
