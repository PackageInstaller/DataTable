-- chunkname: @modules/logic/survival/controller/work/step/SurvivalUpdateUnitDataWork.lua

module("modules.logic.survival.controller.work.step.SurvivalUpdateUnitDataWork", package.seeall)

local SurvivalUpdateUnitDataWork = class("SurvivalUpdateUnitDataWork", SurvivalStepBaseWork)

function SurvivalUpdateUnitDataWork:onStart2(context)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	for _, unit in ipairs(self._stepMo.unit) do
		local unitMo = sceneMo.unitsById[unit.id]

		if unitMo then
			local preCfgId = unitMo.cfgId
			local oldPos = unitMo.pos

			unitMo:init(unit)

			if oldPos ~= unitMo.pos then
				local newPos = unitMo.pos

				unitMo.pos = oldPos

				sceneMo:onUnitUpdatePos(unitMo, newPos)
			end

			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitChange, unitMo.id)

			if preCfgId ~= unitMo.cfgId then
				sceneMo:fixUnitExPos(unitMo)
			end
		else
			unitMo = sceneMo.blocksById[unit.id]

			if sceneMo.blocksById[unit.id] then
				unitMo:init(unit)

				if unitMo:isDestory() then
					SurvivalHelper.instance:addNodeToDict(sceneMo.allDestroyPos, unitMo.pos)

					for _, pos in ipairs(unitMo.exPoints) do
						SurvivalHelper.instance:addNodeToDict(sceneMo.allDestroyPos, pos)
					end

					sceneMo:deleteUnit(unitMo.id)
					SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapDestoryPosAdd, unitMo)
				end
			end
		end

		if not unitMo then
			logError("元件不存在，更新失败" .. tostring(unit.id))
		end
	end

	self:onDone(true)
end

function SurvivalUpdateUnitDataWork:getRunOrder(params, flow)
	local haveMoveItem = false

	for k, unit in ipairs(self._stepMo.unit) do
		if params.moveIdSet[unit.id] then
			haveMoveItem = true

			break
		end
	end

	if haveMoveItem then
		flow:addWork(self)

		return SurvivalEnum.StepRunOrder.None
	end

	return SurvivalEnum.StepRunOrder.Before
end

return SurvivalUpdateUnitDataWork
