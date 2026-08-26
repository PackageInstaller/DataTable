-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepCheckResultWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepCheckResultWork", package.seeall)

local SodacheStepCheckResultWork = class("SodacheStepCheckResultWork", SodacheStepBaseWork)

function SodacheStepCheckResultWork:onWorkStart(context)
	if SodacheModel.instance.____gmfastrun then
		self:onDone(true)

		return
	end

	local param = {}

	param.isUse = false
	param.result = self._stepMo.paramInt[1]
	param.dices = self._stepMo.diceResults
	param.callback = self.onResultEnd
	param.callobj = self

	SodacheController.instance:dispatchEvent(SodacheEvent.OnCheckResult, param)

	if not param.isUse then
		self:onDone(true)
	end
end

function SodacheStepCheckResultWork:onResultEnd()
	self:onDone(true)
end

return SodacheStepCheckResultWork
