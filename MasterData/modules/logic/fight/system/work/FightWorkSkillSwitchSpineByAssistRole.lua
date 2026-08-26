-- chunkname: @modules/logic/fight/system/work/FightWorkSkillSwitchSpineByAssistRole.lua

module("modules.logic.fight.system.work.FightWorkSkillSwitchSpineByAssistRole", package.seeall)

local FightWorkSkillSwitchSpineByAssistRole = class("FightWorkSkillSwitchSpineByAssistRole", BaseWork)

function FightWorkSkillSwitchSpineByAssistRole:ctor(fightStepData)
	self.fightStepData = fightStepData
end

FightWorkSkillSwitchSpineByAssistRole.TargetPosition = 3

function FightWorkSkillSwitchSpineByAssistRole:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 5)

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

	self:hideSrcEntity()
	self:createNewEntity(targetEntityMo)
end

function FightWorkSkillSwitchSpineByAssistRole:hideSrcEntity()
	local targetPos = FightWorkSkillSwitchSpineByAssistRole.TargetPosition
	local srcEntityMo = FightDataHelper.entityMgr:getEntityMoByPos(targetPos)

	if srcEntityMo then
		local srcEntity = FightHelper.getEntity(srcEntityMo.uid)

		srcEntity:setActive(false, true)

		if srcEntity.nameUI then
			srcEntity.nameUI:setActive(false, FightNameActiveKey.ReplacedAssistRoleKey)
		end
	end
end

function FightWorkSkillSwitchSpineByAssistRole:createNewEntity(entityMo)
	local work = FightGameMgr.entityMgr:registNewEntityWork(entityMo)

	work:registFinishCallback(self.onSpineLoaded, self)
	work:start()
end

function FightWorkSkillSwitchSpineByAssistRole:onSpineLoaded()
	self:onDone(true)
end

function FightWorkSkillSwitchSpineByAssistRole:_delayDone()
	self:onDone(true)
end

function FightWorkSkillSwitchSpineByAssistRole:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightWorkSkillSwitchSpineByAssistRole
