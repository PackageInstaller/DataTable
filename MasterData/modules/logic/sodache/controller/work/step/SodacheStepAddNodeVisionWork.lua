-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepAddNodeVisionWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepAddNodeVisionWork", package.seeall)

local SodacheStepAddNodeVisionWork = class("SodacheStepAddNodeVisionWork", SodacheStepBaseWork)

function SodacheStepAddNodeVisionWork:onWorkStart(context)
	local insideMo = SodacheModel.instance:getInsideMo()

	insideMo:addNodeVision(self._stepMo.paramInt)
	SodacheController.instance:dispatchEvent(SodacheEvent.OnUpdateNodeVision)
	self:onDone(true)
end

return SodacheStepAddNodeVisionWork
