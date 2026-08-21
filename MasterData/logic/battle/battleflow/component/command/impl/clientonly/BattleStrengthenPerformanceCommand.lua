-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleStrengthenPerformanceCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleStrengthenPerformanceCommand", package.seeall)

local BattleStrengthenPerformanceCommand = class("BattleStrengthenPerformanceCommand", BattleCommandBase)

function BattleStrengthenPerformanceCommand:parseClientCommand(cmdParser, attackerEntityId, skillId, isStrengthening)
	if not isStrengthening then
		return
	end

	local cmd = BattleStrengthenPerformanceCommand:createInstance()

	cmd:setAttackerEntityId(attackerEntityId)
	cmd:setSkillId(skillId)
	cmdParser:addCommand(cmd)
end

function BattleStrengthenPerformanceCommand:onInit()
	self._attackerEntityId = false
	self._skillId = false

	if self._timelineTask then
		self._timelineTask:clear()
	end
end

function BattleStrengthenPerformanceCommand:onClear()
	self._attackerEntityId = false
	self._skillId = false

	if self._timelineTask then
		self._timelineTask:clear()
	end
end

function BattleStrengthenPerformanceCommand:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local attacker = unitMgr:getUnit(self._attackerEntityId)
	local duration = 2

	self._timelineTask = self._timelineTask or TimelineTask.New()

	self._timelineTask:clear()
	self._timelineTask:addTask(0, self._doCastStrengthen, self)
	self._timelineTask:addTask(1, self._doCastReleaseEffect, self)
	self._timelineTask:addTask(duration - 1)
	self._timelineTask:setTimeScale(BattleTime.timeScale)
	self._timelineTask:addFinishListener(self._onCastFinish, self)
	self._timelineTask:start(battleFlow)
end

function BattleStrengthenPerformanceCommand:_doCastStrengthen(battleFlow)
	ViewMgr.instance:open(ViewName.BattleSkillHint, self._attackerEntityId, self._skillId, true)
	BattleMainViewFacade.instance:hideRightTopView()

	local unitMgr = battleFlow.unitMgr
	local attacker = unitMgr:getUnit(self._attackerEntityId)

	attacker.meshModel:setNextAnimationExtraPlaySpeed(0.5)
	attacker.meshModel:playAndAutoIdleIfExists(UnitAnimState.Cast)
	BattleAudioUtil.playVoice(attacker, BattleAudioUtil.VoiceEnum.speech_lizhiqianghua)
end

function BattleStrengthenPerformanceCommand:_doCastReleaseEffect(battleFlow)
	BattleMainViewFacade.instance:hideRightTopView()

	local unitMgr = battleFlow.unitMgr
	local attacker = unitMgr:getUnit(self._attackerEntityId)

	attacker.effectPlayer:playEffect(BattleConst.SANITY_STRENGTHEN_REALEASE_EFFECT)
end

function BattleStrengthenPerformanceCommand:_onCastFinish()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local attacker = unitMgr:getUnit(self._attackerEntityId)

	attacker.meshModel:setPlaySpeed(BattleTime.timeScale)

	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(self._skillId)

	if not ActiveSkillCOUtil.isReleaseTypeSniping(skillCOWrapper, true) then
		attacker.property:inactiveState(BattleEnum.State.SANITY_STRENGTHEN)
		attacker.effectPlayer:stopLoopEffectWithAnim(BattleConst.SANITY_BURN_LOOP_EFFECT, "End", 0.5)
	end

	BattleMainViewFacade.instance:showRightTopView()
	self:finish(true)
end

function BattleStrengthenPerformanceCommand:toString()
	return string.format("[enter BattleStrengthenPerformanceCommand  attackerEntityId = %s]", self._attackerEntityId)
end

function BattleStrengthenPerformanceCommand:setAttackerEntityId(attackerEntityId)
	self._attackerEntityId = attackerEntityId

	return self
end

function BattleStrengthenPerformanceCommand:setSkillId(skillId)
	self._skillId = skillId

	return self
end

return BattleStrengthenPerformanceCommand
