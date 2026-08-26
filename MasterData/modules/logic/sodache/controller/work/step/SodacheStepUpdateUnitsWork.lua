-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepUpdateUnitsWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepUpdateUnitsWork", package.seeall)

local SodacheStepUpdateUnitsWork = class("SodacheStepUpdateUnitsWork", SodacheStepBaseWork)

function SodacheStepUpdateUnitsWork:onWorkStart(context)
	local insideMo = SodacheModel.instance:getInsideMo()
	local unitBox = insideMo.unitBox

	for i, v in ipairs(self._stepMo.units) do
		local unitMo = unitBox.unitsMap[v.uid]

		if unitMo then
			unitMo:init(v)
		else
			logError("事件不存在！" .. v.uid)
		end
	end

	insideMo.unitDirty = true

	if SodacheModel.instance.____gmfastrun then
		self:onDone(true)

		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnUpdateUnits, self._stepMo.units, unitBox)
	self:onDone(true)
end

function SodacheStepUpdateUnitsWork:canMergeExecute()
	return true
end

return SodacheStepUpdateUnitsWork
