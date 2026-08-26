-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepUpdatePatrolInfoWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepUpdatePatrolInfoWork", package.seeall)

local SodacheStepUpdatePatrolInfoWork = class("SodacheStepUpdatePatrolInfoWork", SodacheStepBaseWork)

function SodacheStepUpdatePatrolInfoWork:onWorkStart(context)
	local insideMo = SodacheModel.instance:getInsideMo()

	insideMo.patrolBox = self._stepMo.patrolBox

	if SodacheModel.instance.____gmfastrun then
		self:onDone(true)

		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnUpdatePatrolInfo)
	self:onDone(true)
end

return SodacheStepUpdatePatrolInfoWork
