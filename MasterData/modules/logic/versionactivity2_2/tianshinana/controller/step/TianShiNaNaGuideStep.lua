-- chunkname: @modules/logic/versionactivity2_2/tianshinana/controller/step/TianShiNaNaGuideStep.lua

module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaGuideStep", package.seeall)

local TianShiNaNaGuideStep = class("TianShiNaNaGuideStep", TianShiNaNaStepBase)

function TianShiNaNaGuideStep:onStart(context)
	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.OnGuideTrigger, tostring(self._data.guideId))
	self:onDone(true)
end

return TianShiNaNaGuideStep
