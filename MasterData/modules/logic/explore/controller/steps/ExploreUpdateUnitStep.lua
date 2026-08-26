-- chunkname: @modules/logic/explore/controller/steps/ExploreUpdateUnitStep.lua

module("modules.logic.explore.controller.steps.ExploreUpdateUnitStep", package.seeall)

local ExploreUpdateUnitStep = class("ExploreUpdateUnitStep", ExploreStepBase)

function ExploreUpdateUnitStep:onStart()
	local interact = self._data.interact

	ExploreModel.instance:updateInteractInfo(interact, nil, true)

	if ExploreHelper.getBit(interact.status, ExploreEnum.InteractIndex.IsEnter) <= 0 then
		local stepData = {
			stepType = ExploreEnum.StepType.DelUnit,
			interact = self._data.interact
		}

		ExploreStepController.instance:insertClientStep(stepData, 1)
		self:onDone()

		return
	end

	local map = ExploreController.instance:getMap()
	local unit = map:getUnit(interact.id, true)

	if unit then
		unit:checkShowIcon()

		if not unit.nodePos or unit.nodePos.x ~= interact.posx or unit.nodePos.y ~= interact.posy then
			local status = map:getNowStatus()

			if status == ExploreEnum.MapStatus.Normal then
				unit:setPosByNode({
					x = interact.posx,
					y = interact.posy
				})
			end
		end

		if ExploreHeroResetFlow.instance:isReseting() then
			unit.mo.unitDir = interact.dir

			unit:updateRotationRoot()
		end
	else
		ExploreController.instance:updateUnit(interact)

		local unit = map:getUnit(interact.id)

		map:checkUnitNear(unit.nodePos, unit)
	end

	self:onDone()
end

return ExploreUpdateUnitStep
