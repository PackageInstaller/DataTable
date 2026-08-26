-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepRemoveUnitsWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepRemoveUnitsWork", package.seeall)

local SodacheStepRemoveUnitsWork = class("SodacheStepRemoveUnitsWork", SodacheStepBaseWork)

function SodacheStepRemoveUnitsWork:onWorkStart(context)
	local insideMo = SodacheModel.instance:getInsideMo()

	insideMo.unitBox:removeUnits(self._stepMo.paramLong)

	insideMo.unitDirty = true

	if SodacheModel.instance.____gmfastrun then
		self:onDone(true)

		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnRemoveUnits, self._stepMo.paramLong)
	self:onDone(true)
end

function SodacheStepRemoveUnitsWork:canMergeExecute(moveSet)
	local isUnitMove = false

	for i, v in ipairs(self._stepMo.paramLong) do
		if moveSet[v] then
			isUnitMove = true

			break
		end
	end

	return not isUnitMove
end

return SodacheStepRemoveUnitsWork
