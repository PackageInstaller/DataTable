-- chunkname: @modules/logic/survival/controller/work/step/SurvivalUpdateRoleSkillMaxUseCountWork.lua

module("modules.logic.survival.controller.work.step.SurvivalUpdateRoleSkillMaxUseCountWork", package.seeall)

local SurvivalUpdateRoleSkillMaxUseCountWork = class("SurvivalUpdateRoleSkillMaxUseCountWork", SurvivalStepBaseWork)

function SurvivalUpdateRoleSkillMaxUseCountWork:onStart2(context)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local skillInfo = sceneMo:getRoleSkillInfo()
	local info = {}

	info.maxUseCount = self._stepMo.paramInt[1] or 0

	skillInfo:onUseRoleSkill(info)
	self:onDone(true)
end

return SurvivalUpdateRoleSkillMaxUseCountWork
