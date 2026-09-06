-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchDress.lua

module("logic.extensions.guide.model.branch.GuideBranchDress", package.seeall)

local GuideBranchDress = class("GuideBranchDress", GuideBranchBase)

function GuideBranchDress:shouldTrigger()
	if self._currGuide then
		local guideId = self._currGuide:getGuideId()

		printInfo("GuideBranchDress:shouldTrigger:" .. guideId)

		local b = GuideBranchDress.super.shouldTrigger(self)

		printInfo("GuideBranchDress:shouldTrigger:" .. tostring(b))

		if self.hasDone and guideId == 2140 then
			self:finishGuide()

			return false
		else
			self.hasDone = false
		end

		if guideId == 2140 then
			self.hasDone = true
		end
	end

	return GuideBranchDress.super.shouldTrigger(self)
end

function GuideBranchDress:onExitView(viewName)
	if self._currGuide then
		local guideId = self._currGuide:getGuideId()

		printInfo("GuideBranchDress:onExitView:" .. guideId)
	end

	return GuideBranchDress.super.onExitView(self, viewName)
end

function GuideBranchDress:onEnterView(viewName)
	if self._currGuide then
		local guideId = self._currGuide:getGuideId()

		printInfo("GuideBranchDress:onEnterView:" .. guideId)

		if guideId == 2110 then
			-- block empty
		end
	end

	return GuideBranchDress.super.onEnterView(self, viewName)
end

function GuideBranchDress:startGuide()
	if self._currGuide then
		local guideId = self._currGuide:getGuideId()

		printInfo("GuideBranchDress:startGuide:" .. guideId)
	end

	GuideBranchDress.super.startGuide(self)
end

function GuideBranchDress:finishGuide()
	printInfo("GuideBranchDress:finishGuide:" .. ((self._currGuide or nil) and self._currGuide:getGuideId()))
	GuideBranchDress.super.finishGuide(self)
end

return GuideBranchDress
