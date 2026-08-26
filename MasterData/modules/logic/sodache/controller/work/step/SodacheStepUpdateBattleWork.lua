-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepUpdateBattleWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepUpdateBattleWork", package.seeall)

local SodacheStepUpdateBattleWork = class("SodacheStepUpdateBattleWork", SodacheStepBaseWork)

function SodacheStepUpdateBattleWork:onWorkStart(context)
	context.isEventEnd = true

	local battleInfo = SodacheModel.instance:getInsideMo().prop.battleInfo

	battleInfo:init(self._stepMo.battleInfo)

	if SodacheModel.instance.____gmfastrun then
		self:onDone(true)

		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnUpdateBattleInfo)
	self:onDone(true)
end

return SodacheStepUpdateBattleWork
