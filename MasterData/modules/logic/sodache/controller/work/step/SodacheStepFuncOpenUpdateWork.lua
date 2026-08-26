-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepFuncOpenUpdateWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepFuncOpenUpdateWork", package.seeall)

local SodacheStepFuncOpenUpdateWork = class("SodacheStepFuncOpenUpdateWork", SodacheStepBaseWork)

function SodacheStepFuncOpenUpdateWork:onWorkStart(context)
	local outSideMo = SodacheModel.instance:getOutsideMo()

	if outSideMo then
		table.insert(outSideMo.functionBox.functionIds, self._stepMo.paramInt[1])
	end

	self:onDone(true)
end

function SodacheStepFuncOpenUpdateWork:isInsideStep()
	return false
end

return SodacheStepFuncOpenUpdateWork
