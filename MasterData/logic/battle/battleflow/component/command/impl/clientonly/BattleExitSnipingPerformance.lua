-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleExitSnipingPerformance.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleExitSnipingPerformance", package.seeall)

local BattleExitSnipingPerformance = class("BattleExitSnipingPerformance", BattleCommandBase)

function BattleExitSnipingPerformance:create(attackerEntityId, victimEntityId, skillId)
	local cmd = BattleExitSnipingPerformance:createInstance()

	cmd:setAttackerEntityId(attackerEntityId)
	cmd:setVictimEntityId(victimEntityId)
	cmd:setSkillId(skillId)

	return cmd
end

function BattleExitSnipingPerformance:onInit()
	self._timlineTask = TimelineTask.New()
	self._attackerEntityId = false
	self._victimEntityId = false
	self._skillId = false
end

function BattleExitSnipingPerformance:onClear()
	self._timlineTask:clear()

	self._attackerEntityId = false
	self._victimEntityId = false
	self._skillId = false
end

function BattleExitSnipingPerformance:execute(battleFlow, runningContext)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local attacker = unitMgr:getUnit(self._attackerEntityId)

	if not attacker then
		self:finish(true)

		return
	end

	if BattleSkillAssist.isStepAgainAfterReleaseSniping(attacker) then
		runningContext:setParam(BattleCmdRunningContext.Param_InSniping2Stage, true)
	end

	self._timlineTask:addFinishListener(self._onTaskFinish, self)
	self._timlineTask:addTask(0.5, self._tResumeAnimation, self)
	self._timlineTask:addTask(0.5)
	self._timlineTask:setTimeScale(BattleTime.timeScale)
	self._timlineTask:start()
end

function BattleExitSnipingPerformance:_tResumeAnimation()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local attacker = unitMgr:getUnit(self._attackerEntityId)
	local aimEnd = BattleEnterSnipingPerformance:getSnipingAnimationName(self._attackerEntityId, self._skillId, UnitAnimState.AimEnd)

	attacker.meshModel:playAndAutoIdleIfExists(aimEnd)
	attacker.meshModelMover:resetBusinessMappedAnimation(UnitAnimState.Idle)
	attacker.meshModelMover:resetBusinessMappedAnimation(UnitAnimState.Idle2)
	attacker.meshModelMover:resetBusinessMappedAnimation(UnitAnimState.React)
	attacker.meshModelMover:resetBusinessMappedAnimation(UnitAnimState.Hit2)
	attacker.meshModelMover:resetBusinessMappedAnimation(UnitAnimState.Hit)
end

function BattleExitSnipingPerformance:_onTaskFinish()
	self:finish(true)
end

function BattleExitSnipingPerformance:toString()
	return string.format("[exit sniping performance command attackerEntityId = %s,victimEntityId = %s, skillId = %s]", self._attackerEntityId, self._victimEntityId, self._skillId)
end

function BattleExitSnipingPerformance:setAttackerEntityId(attackerEntityId)
	self._attackerEntityId = attackerEntityId

	return self
end

function BattleExitSnipingPerformance:setVictimEntityId(victimEntityId)
	self._victimEntityId = victimEntityId

	return self
end

function BattleExitSnipingPerformance:setSkillId(skillId)
	self._skillId = skillId

	return self
end

return BattleExitSnipingPerformance
