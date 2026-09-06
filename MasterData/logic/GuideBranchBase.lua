-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/GuideBranchBase.lua

module("logic.extensions.guide.model.GuideBranchBase", package.seeall)

local GuideBranchBase = class("GuideBranchBase")

function GuideBranchBase:ctor(branchId, currGuideId)
	self.branchId = branchId
	self._branchParam = nil

	self:setGuide(currGuideId)
end

function GuideBranchBase:isFinished()
	return not self._currGuide
end

function GuideBranchBase:forceToInView(viewName, childName)
	return 0
end

function GuideBranchBase:onExitView(viewName)
	return 0
end

function GuideBranchBase:onEnterView(viewName)
	return 0
end

function GuideBranchBase:forceToInScene(sceneId, sceneType)
	return 0
end

function GuideBranchBase:shouldTrigger()
	if self._currGuide then
		return self._currGuide:shouldTrigger()
	end
end

function GuideBranchBase:setGuide(guideId)
	self:finishGuide()

	self._currGuide = guideId ~= GuideConst.INVALID_GUIDE_ID and GuideGuideBase.New(self.branchId, guideId) or nil
end

function GuideBranchBase:getGuide()
	return self._currGuide
end

function GuideBranchBase:isGuiding()
	return self._currGuide and self._currGuide.isGuiding
end

function GuideBranchBase:startGuide()
	if self._currGuide and not self._currGuide.isGuiding then
		if self._currGuide:checkFinish() then
			GuideController.instance:forceFinishBranch()
		else
			self._currGuide:startGuide()
		end
	end
end

function GuideBranchBase:finishGuide()
	if self._currGuide and self._currGuide.isGuiding then
		self._branchParam = nil

		self._currGuide:finishGuide()
	end
end

function GuideBranchBase:setParam(param)
	self._branchParam = param

	if self._currGuide then
		self._currGuide:setGuideParam(param)
	end
end

return GuideBranchBase
