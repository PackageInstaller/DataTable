-- chunkname: @modules/logic/survival/controller/work/step/SurvivalFastBattleWork.lua

module("modules.logic.survival.controller.work.step.SurvivalFastBattleWork", package.seeall)

local SurvivalFastBattleWork = class("SurvivalFastBattleWork", SurvivalStepBaseWork)

function SurvivalFastBattleWork:onStart2(context)
	if not self._stepMo.paramInt[1] then
		local unitId = 0
		local entity = SurvivalMapHelper.instance:getEntity(unitId)

		if not entity then
			self:onDone(true)

			return
		end

		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_killed)
		entity:addEffect(SurvivalConst.UnitEffectPath.FastFight)

		self._entity = entity

		TaskDispatcher.runDelay(self._delayDone, self, SurvivalConst.UnitEffectTime[SurvivalConst.UnitEffectPath.FastFight])
	end
end

function SurvivalFastBattleWork:_delayDone()
	self._entity:removeEffect(SurvivalConst.UnitEffectPath.FastFight)
	self:onDone(true)
end

function SurvivalFastBattleWork:clearWork()
	self._entity = nil

	TaskDispatcher.cancelTask(self._delayDone, self)
end

function SurvivalFastBattleWork:getRunOrder(params, flow)
	flow:addWork(self)

	params.beforeFlow = FlowParallel.New()

	flow:addWork(params.beforeFlow)

	params.moveIdSet = {}
	params.haveHeroMove = false

	return SurvivalEnum.StepRunOrder.None
end

return SurvivalFastBattleWork
