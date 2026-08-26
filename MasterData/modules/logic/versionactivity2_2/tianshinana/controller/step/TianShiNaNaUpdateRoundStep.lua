-- chunkname: @modules/logic/versionactivity2_2/tianshinana/controller/step/TianShiNaNaUpdateRoundStep.lua

module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaUpdateRoundStep", package.seeall)

local TianShiNaNaUpdateRoundStep = class("TianShiNaNaUpdateRoundStep", TianShiNaNaStepBase)

function TianShiNaNaUpdateRoundStep:onStart()
	TianShiNaNaModel.instance.nowRound = self._data.currRound
	TianShiNaNaModel.instance.stepCount = self._data.stepCount
	TianShiNaNaModel.instance.waitClickJump = self._data.reason == 1

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.RoundUpdate, tostring(self._data.currRound + 1))

	if TianShiNaNaModel.instance.waitClickJump then
		TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.WaitClickJumpRound, self._onClick, self)
	else
		self:onDone(true)
	end
end

function TianShiNaNaUpdateRoundStep:_onClick()
	self:onDone(true)
end

function TianShiNaNaUpdateRoundStep:clearWork()
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.WaitClickJumpRound, self._onClick, self)
end

return TianShiNaNaUpdateRoundStep
