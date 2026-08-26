-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepAddUnitsWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepAddUnitsWork", package.seeall)

local SodacheStepAddUnitsWork = class("SodacheStepAddUnitsWork", SodacheStepBaseWork)

function SodacheStepAddUnitsWork:onWorkStart(context)
	local insideMo = SodacheModel.instance:getInsideMo()
	local unitBox = insideMo.unitBox

	unitBox:addUnits(self._stepMo.units)

	insideMo.unitDirty = true

	if SodacheModel.instance.____gmfastrun then
		self:onDone(true)

		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnAddUnits, self._stepMo.units, unitBox)
	self:onDone(true)
end

function SodacheStepAddUnitsWork:canMergeExecute()
	return true
end

return SodacheStepAddUnitsWork
