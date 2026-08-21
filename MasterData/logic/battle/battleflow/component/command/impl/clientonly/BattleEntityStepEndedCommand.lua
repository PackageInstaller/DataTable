-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleEntityStepEndedCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleEntityStepEndedCommand", package.seeall)

local BattleEntityStepEndedCommand = class("BattleEntityStepEndedCommand", BattleCommandBase)

function BattleEntityStepEndedCommand:create(entityId, targetEntityId)
	local cmd = BattleEntityStepEndedCommand:createInstance()

	cmd:setEntityId(entityId)
	cmd:setTargetEntityId(targetEntityId)

	return cmd
end

function BattleEntityStepEndedCommand:onInit()
	self._entityId = false
	self._targetEntityId = false
end

function BattleEntityStepEndedCommand:onClear()
	self._entityId = false
	self._targetEntityId = false
end

function BattleEntityStepEndedCommand:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if BattleUnitUtil.isAlive(unit) then
		self:_tryPlayLowSanityAudio(unit)
		unit.property:inactiveState(BattleEnum.State.MANUAL)
		unit.skill:setSkillStatus(BattleEnum.SkillStatus.Normal)

		local isInSniping2Stage = runningContext:getParam(BattleCmdRunningContext.Param_InSniping2Stage)

		if isInSniping2Stage then
			unit.stateEffect:refreshStateEffect()
			runningContext:clearParam(BattleCmdRunningContext.Param_InSniping2Stage)
		else
			unit.property:activeState(BattleEnum.State.STEPPED)
			unit.sign:setOperatableSignVisible(false)
			unit.stateEffect:refreshStateEffect()
		end
	end

	BattleDispatcher:dispatchEvent(BattleEventType.OnEntitySteppedFinish, self._entityId)
	BattleDamageHintFacade.instance:setVisible(false)
	self:finish(true)
end

function BattleEntityStepEndedCommand:_tryPlayLowSanityAudio(unit)
	if unit.skill:getSkillStatus() == BattleEnum.SkillStatus.Strenthening and BattleUnitUtil.isLowSanity(unit) then
		BattleAudioUtil.playVoice(unit, BattleAudioUtil.VoiceEnum.speech_dilizhi)
	end
end

function BattleEntityStepEndedCommand:toString()
	return string.format("[entity step ended command entityId = %s,targetEntityId = %s]", self._entityId, tostring(self._targetEntityId))
end

function BattleEntityStepEndedCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleEntityStepEndedCommand:setTargetEntityId(targetEntityId)
	self._targetEntityId = targetEntityId

	return self
end

return BattleEntityStepEndedCommand
