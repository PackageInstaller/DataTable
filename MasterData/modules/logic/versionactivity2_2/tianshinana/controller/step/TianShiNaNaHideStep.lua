-- chunkname: @modules/logic/versionactivity2_2/tianshinana/controller/step/TianShiNaNaHideStep.lua

module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaHideStep", package.seeall)

local TianShiNaNaHideStep = class("TianShiNaNaHideStep", TianShiNaNaStepBase)

function TianShiNaNaHideStep:onStart(context)
	TianShiNaNaModel.instance:removeUnit(self._data.id)
	self:onDone(true)
end

return TianShiNaNaHideStep
