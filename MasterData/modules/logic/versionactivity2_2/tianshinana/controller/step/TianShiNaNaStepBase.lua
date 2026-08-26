-- chunkname: @modules/logic/versionactivity2_2/tianshinana/controller/step/TianShiNaNaStepBase.lua

module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaStepBase", package.seeall)

local TianShiNaNaStepBase = class("TianShiNaNaStepBase", BaseWork)

function TianShiNaNaStepBase:initData(data)
	self._data = data
end

function TianShiNaNaStepBase:onStart(context)
	self:onDone(true)
end

return TianShiNaNaStepBase
