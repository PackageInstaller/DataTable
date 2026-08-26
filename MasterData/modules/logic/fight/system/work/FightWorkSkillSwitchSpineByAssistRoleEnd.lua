-- chunkname: @modules/logic/fight/system/work/FightWorkSkillSwitchSpineByAssistRoleEnd.lua

module("modules.logic.fight.system.work.FightWorkSkillSwitchSpineByAssistRoleEnd", package.seeall)

local FightWorkSkillSwitchSpineByAssistRoleEnd = class("FightWorkSkillSwitchSpineByAssistRoleEnd", BaseWork)

function FightWorkSkillSwitchSpineByAssistRoleEnd:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkSkillSwitchSpineByAssistRoleEnd:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 1)

	local targetEntityMo = FightDataHelper.entityMgr:getById(self.fightStepData.fromId)

	if not targetEntityMo then
		return self:onDone(true)
	end

	if not targetEntityMo:isAssistBoss() then
		return self:onDone(true)
	end

	if not FightDataHelper.paTaMgr:checkIsAssistRole() then
		return self:onDone(true)
	end

	self:showSrcEntity()
	self:deleteEntity()

	return self:onDone(true)
end

function FightWorkSkillSwitchSpineByAssistRoleEnd:showSrcEntity()
	local targetPos = FightWorkSkillSwitchSpineByAssistRole.TargetPosition
	local srcEntityMo = FightDataHelper.entityMgr:getEntityMoByPos(targetPos)

	if srcEntityMo then
		local srcEntity = FightHelper.getEntity(srcEntityMo.uid)

		srcEntity:setActive(true)

		if srcEntity.nameUI then
			srcEntity.nameUI:setActive(true, FightNameActiveKey.ReplacedAssistRoleKey)
		end
	end
end

function FightWorkSkillSwitchSpineByAssistRoleEnd:deleteEntity()
	local entity = FightGameMgr.entityMgr:getById(self.fightStepData.fromId)

	if not entity then
		return
	end

	if entity.skill and entity.skill.workComp:hasAliveWork() then
		return
	end

	FightGameMgr.entityMgr:delEntity(self.fightStepData.fromId)
end

function FightWorkSkillSwitchSpineByAssistRoleEnd:_delayDone()
	self:onDone(true)
end

function FightWorkSkillSwitchSpineByAssistRoleEnd:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightWorkSkillSwitchSpineByAssistRoleEnd
