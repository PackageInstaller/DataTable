-- chunkname: @modules/logic/survival/controller/work/step/SurvivalUpdateSafeZoneInfoWork.lua

module("modules.logic.survival.controller.work.step.SurvivalUpdateSafeZoneInfoWork", package.seeall)

local SurvivalUpdateSafeZoneInfoWork = class("SurvivalUpdateSafeZoneInfoWork", SurvivalStepBaseWork)

function SurvivalUpdateSafeZoneInfoWork:onStart2(context)
	local safeZone = self._stepMo.safeZone.shrinkInfo
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	sceneMo.safeZone = {}

	for i, v in ipairs(safeZone) do
		local mo = SurvivalShrinkInfoMo.New()

		mo:init(v)
		table.insert(sceneMo.safeZone, mo)
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShrinkInfoUpdate)
	self:onDone(true)
end

function SurvivalUpdateSafeZoneInfoWork:getRunOrder(params, flow)
	return SurvivalEnum.StepRunOrder.Before
end

return SurvivalUpdateSafeZoneInfoWork
