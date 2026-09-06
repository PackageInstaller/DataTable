-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchExpPool.lua

module("logic.extensions.guide.model.branch.GuideBranchExpPool", package.seeall)

local GuideBranchExpPool = class("GuideBranchExpPool", GuideBranchBase)

function GuideBranchExpPool:startGuide()
	GlobalDispatcher:addListener("guide_wait_signal", self.onWaitSignal, self)
	GuideBranchExpPool.super.startGuide(self)
end

function GuideBranchExpPool:finishGuide()
	GlobalDispatcher:removeListener("guide_wait_signal", self.onWaitSignal, self)
	GuideBranchExpPool.super.finishGuide(self)
end

function GuideBranchExpPool:onWaitSignal()
	if self._currGuide then
		removetimer(self.checkSignal, self)
		settimer(0, self.checkSignal, self)
	end
end

function GuideBranchExpPool:checkSignal()
	if self._currGuide then
		local obj = self._currGuide:getJsonParams()

		if obj.signal == 1 then
			if WTowerFacade.instance:getNeedShowGuide() then
				removetimer(self.checkSignal, self)
				GuideController.instance:finishGuide()
			end
		elseif obj.signal == 2 and WTowerFacade.instance:getExpPoolSelectPet() > 0 then
			removetimer(self.checkSignal, self)
			GuideController.instance:finishGuide()
		end
	end
end

function GuideBranchExpPool:shouldTrigger()
	return GuideBranchExpPool.super.shouldTrigger(self)
end

function GuideBranchExpPool:onEnterView(viewName)
	if self._currGuide and viewName == ViewName.exppool and WTowerFacade.instance:getExpPoolSelectPet() > 0 then
		return 5
	end

	return 0
end

return GuideBranchExpPool
