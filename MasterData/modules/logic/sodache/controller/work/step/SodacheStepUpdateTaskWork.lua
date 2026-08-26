-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepUpdateTaskWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepUpdateTaskWork", package.seeall)

local SodacheStepUpdateTaskWork = class("SodacheStepUpdateTaskWork", SodacheStepBaseWork)

function SodacheStepUpdateTaskWork:onWorkStart(context)
	local taskBox = SodacheModel.instance:getOutsideMo().taskBox

	taskBox:updateTasks(self._stepMo.tasks)

	if SodacheModel.instance.____gmfastrun then
		self:onDone(true)

		return
	end

	self:onDone(true)
end

function SodacheStepUpdateTaskWork:isInsideStep()
	return false
end

return SodacheStepUpdateTaskWork
