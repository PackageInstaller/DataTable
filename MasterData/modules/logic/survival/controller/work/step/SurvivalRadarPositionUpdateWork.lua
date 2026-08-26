-- chunkname: @modules/logic/survival/controller/work/step/SurvivalRadarPositionUpdateWork.lua

module("modules.logic.survival.controller.work.step.SurvivalRadarPositionUpdateWork", package.seeall)

local SurvivalRadarPositionUpdateWork = class("SurvivalRadarPositionUpdateWork", SurvivalStepBaseWork)

function SurvivalRadarPositionUpdateWork:onStart2(context)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	sceneMo.sceneProp.radarPosition = self._stepMo.position

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapRadarPosChange)
	self:onDone(true)
end

return SurvivalRadarPositionUpdateWork
