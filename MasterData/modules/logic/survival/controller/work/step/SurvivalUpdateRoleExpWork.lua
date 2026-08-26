-- chunkname: @modules/logic/survival/controller/work/step/SurvivalUpdateRoleExpWork.lua

module("modules.logic.survival.controller.work.step.SurvivalUpdateRoleExpWork", package.seeall)

local SurvivalUpdateRoleExpWork = class("SurvivalUpdateRoleExpWork", SurvivalStepBaseWork)

function SurvivalUpdateRoleExpWork:onStart2()
	local survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo

	if not self._stepMo.paramInt[1] then
		survivalShelterRoleMo:setExp(self._stepMo.paramInt[1])
		survivalShelterRoleMo:setExpCache(self._stepMo.paramInt[1])
		self:onDone(true)
	end
end

return SurvivalUpdateRoleExpWork
