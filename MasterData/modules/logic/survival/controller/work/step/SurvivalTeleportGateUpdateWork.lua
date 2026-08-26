-- chunkname: @modules/logic/survival/controller/work/step/SurvivalTeleportGateUpdateWork.lua

module("modules.logic.survival.controller.work.step.SurvivalTeleportGateUpdateWork", package.seeall)

local SurvivalTeleportGateUpdateWork = class("SurvivalTeleportGateUpdateWork", SurvivalStepBaseWork)

function SurvivalTeleportGateUpdateWork:onStart2(context)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	sceneMo.sceneProp.teleportGate = self._stepMo.paramInt[1] or 0
	sceneMo.sceneProp.teleportGateHex = self._stepMo.position

	SurvivalMapHelper.instance:getScene().pointEffect:setTeleportGateEffect()
	self:onDone(true)
end

return SurvivalTeleportGateUpdateWork
