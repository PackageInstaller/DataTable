-- chunkname: @modules/logic/survival/controller/work/step/SurvivalUnitShowWork.lua

module("modules.logic.survival.controller.work.step.SurvivalUnitShowWork", package.seeall)

local SurvivalUnitShowWork = class("SurvivalUnitShowWork", SurvivalStepBaseWork)

function SurvivalUnitShowWork:onStart2(context)
	local newUnitIds = {}

	for i, unit in ipairs(self._stepMo.unit) do
		local unitMo = SurvivalUnitMo.New()

		unitMo:init(unit)

		newUnitIds[unitMo.id] = true
	end

	if not self._stepMo.paramInt[1] then
		if self._stepMo.paramInt[1] == 1002 then
			if type(context.tryTrigger) == "table" then
				for id in pairs(newUnitIds) do
					context.tryTrigger[id] = true
				end
			else
				context.tryTrigger = newUnitIds
			end
		end

		if self._stepMo.paramInt[1] == 1003 then
			context.tryTrigger = true

			local entity = SurvivalMapHelper.instance:getEntity(0)

			if not entity then
				self:addUnit()
			else
				entity:addEffect(SurvivalConst.UnitEffectPath.MksEffect)
				TaskDispatcher.runDelay(self._delayDone, self, SurvivalConst.UnitEffectTime[SurvivalConst.UnitEffectPath.MksEffect])
			end
		else
			self:addUnit()
		end
	end
end

function SurvivalUnitShowWork:addUnit()
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	for i, unit in ipairs(self._stepMo.unit) do
		local unitMo = SurvivalUnitMo.New()

		unitMo:init(unit)
		sceneMo:addUnit(unitMo)
	end

	self:onDone(true)
end

function SurvivalUnitShowWork:_delayDone()
	local entity = SurvivalMapHelper.instance:getEntity(0)

	if entity then
		entity:removeEffect(SurvivalConst.UnitEffectPath.MksEffect)
	end

	self:addUnit()
end

function SurvivalUnitShowWork:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

function SurvivalUnitShowWork:getRunOrder(params, flow)
	if params.haveHeroMove then
		params.beforeFlow = FlowParallel.New()

		flow:addWork(params.beforeFlow)

		params.moveIdSet = {}
		params.haveHeroMove = false
	end

	return SurvivalEnum.StepRunOrder.Before
end

return SurvivalUnitShowWork
