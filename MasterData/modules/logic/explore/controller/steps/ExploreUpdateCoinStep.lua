-- chunkname: @modules/logic/explore/controller/steps/ExploreUpdateCoinStep.lua

module("modules.logic.explore.controller.steps.ExploreUpdateCoinStep", package.seeall)

local ExploreUpdateCoinStep = class("ExploreUpdateCoinStep", ExploreStepBase)

function ExploreUpdateCoinStep:onStart()
	ExploreSimpleModel.instance:onGetCoin(self._data.id, self._data.num)
	ExploreController.instance:dispatchEvent(ExploreEvent.CoinCountUpdate)
	self:onDone()
end

return ExploreUpdateCoinStep
