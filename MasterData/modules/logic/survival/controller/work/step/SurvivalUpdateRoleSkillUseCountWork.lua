-- chunkname: @modules/logic/survival/controller/work/step/SurvivalUpdateRoleSkillUseCountWork.lua

module("modules.logic.survival.controller.work.step.SurvivalUpdateRoleSkillUseCountWork", package.seeall)

local SurvivalUpdateRoleSkillUseCountWork = class("SurvivalUpdateRoleSkillUseCountWork", SurvivalStepBaseWork)

function SurvivalUpdateRoleSkillUseCountWork:onStart2(context)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local skillInfo = sceneMo:getRoleSkillInfo()
	local info = {}

	info.useCount = self._stepMo.paramInt[1] or 0

	skillInfo:onUseRoleSkill(info)
	self:onDone(true)
end

return SurvivalUpdateRoleSkillUseCountWork
