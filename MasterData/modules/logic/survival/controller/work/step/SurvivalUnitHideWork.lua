-- chunkname: @modules/logic/survival/controller/work/step/SurvivalUnitHideWork.lua

module("modules.logic.survival.controller.work.step.SurvivalUnitHideWork", package.seeall)

local SurvivalUnitHideWork = class("SurvivalUnitHideWork", SurvivalStepBaseWork)

function SurvivalUnitHideWork:onStart2(context)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local reason

	for k, v in ipairs(self._stepMo.paramInt) do
		if k == 1 then
			reason = v
		else
			local unitMo = sceneMo.unitsById[v]

			if unitMo then
				if reason == SurvivalEnum.UnitDeadReason.DieByQuickItem then
					SurvivalMapHelper.instance:addPointEffect(unitMo.pos)

					for _, exPos in ipairs(unitMo.exPoints) do
						SurvivalMapHelper.instance:addPointEffect(exPos)
					end
				elseif reason == SurvivalEnum.UnitDeadReason.Transfer then
					-- block empty
				end
			end

			sceneMo:deleteUnit(v, reason == SurvivalEnum.UnitDeadReason.PlayDieAnim)
		end
	end

	self:onDone(true)
end

function SurvivalUnitHideWork:getRunOrder(params, flow)
	local haveMoveItem = false

	for k, id in ipairs(self._stepMo.paramInt) do
		if k ~= 1 and params.moveIdSet[id] then
			haveMoveItem = true

			break
		end
	end

	if haveMoveItem then
		return SurvivalEnum.StepRunOrder.After
	else
		if params.haveHeroMove then
			params.beforeFlow = FlowParallel.New()

			flow:addWork(params.beforeFlow)

			params.moveIdSet = {}
			params.haveHeroMove = false
		end

		return SurvivalEnum.StepRunOrder.Before
	end
end

return SurvivalUnitHideWork
