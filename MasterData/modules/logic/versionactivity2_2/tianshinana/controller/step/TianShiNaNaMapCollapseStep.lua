-- chunkname: @modules/logic/versionactivity2_2/tianshinana/controller/step/TianShiNaNaMapCollapseStep.lua

module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaMapCollapseStep", package.seeall)

local TianShiNaNaMapCollapseStep = class("TianShiNaNaMapCollapseStep", BaseWork)

function TianShiNaNaMapCollapseStep:onStart(context)
	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.CheckMapCollapse)
	self:onDone(true)
end

return TianShiNaNaMapCollapseStep
