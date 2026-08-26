-- chunkname: @modules/logic/explore/controller/steps/ExploreBonusSceneStep.lua

module("modules.logic.explore.controller.steps.ExploreBonusSceneStep", package.seeall)

local ExploreBonusSceneStep = class("ExploreBonusSceneStep", ExploreStepBase)

function ExploreBonusSceneStep:onStart()
	ExploreSimpleModel.instance:onGetBonus(self._data.bonusSceneId, self._data.options)
	self:onDone()
end

return ExploreBonusSceneStep
