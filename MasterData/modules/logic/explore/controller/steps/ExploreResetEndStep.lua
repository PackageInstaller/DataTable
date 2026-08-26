-- chunkname: @modules/logic/explore/controller/steps/ExploreResetEndStep.lua

module("modules.logic.explore.controller.steps.ExploreResetEndStep", package.seeall)

local ExploreResetEndStep = class("ExploreResetEndStep", ExploreStepBase)

function ExploreResetEndStep:onStart()
	TaskDispatcher.runDelay(self.onDone, self, 1)
end

function ExploreResetEndStep:onDestory()
	ExploreResetEndStep.super.onDestory(self)
	TaskDispatcher.cancelTask(self.onDone, self)

	ExploreModel.instance.isReseting = false

	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Reset)
end

return ExploreResetEndStep
