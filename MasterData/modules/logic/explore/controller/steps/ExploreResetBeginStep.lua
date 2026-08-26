-- chunkname: @modules/logic/explore/controller/steps/ExploreResetBeginStep.lua

module("modules.logic.explore.controller.steps.ExploreResetBeginStep", package.seeall)

local ExploreResetBeginStep = class("ExploreResetBeginStep", ExploreStepBase)

function ExploreResetBeginStep:onStart()
	ExploreModel.instance.isReseting = true

	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Reset)
	ViewMgr.instance:openView(ViewName.ExploreBlackView)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
end

function ExploreResetBeginStep:onOpenViewFinish(viewName)
	if viewName == ViewName.ExploreBlackView then
		TaskDispatcher.runDelay(self.onDone, self, 0.2)
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	end
end

function ExploreResetBeginStep:onDestory()
	ExploreResetBeginStep.super.onDestory(self)
	TaskDispatcher.cancelTask(self.onDone, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
end

return ExploreResetBeginStep
