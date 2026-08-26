-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepLevelUpdateWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepLevelUpdateWork", package.seeall)

local SodacheStepLevelUpdateWork = class("SodacheStepLevelUpdateWork", SodacheStepBaseWork)

function SodacheStepLevelUpdateWork:onWorkStart(context)
	local propMo = SodacheModel.instance:getOutsideMo().prop
	local params = self._stepMo.paramInt

	propMo:updateProp(params[1], params[2])

	if SodacheModel.instance.____gmfastrun then
		self:onDone(true)

		return
	end

	self:onDone(true)
end

function SodacheStepLevelUpdateWork:isInsideStep()
	return false
end

return SodacheStepLevelUpdateWork
