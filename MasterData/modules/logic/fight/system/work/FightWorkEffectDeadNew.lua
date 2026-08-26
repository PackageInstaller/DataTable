-- chunkname: @modules/logic/fight/system/work/FightWorkEffectDeadNew.lua

module("modules.logic.fight.system.work.FightWorkEffectDeadNew", package.seeall)

local FightWorkEffectDeadNew = class("FightWorkEffectDeadNew", FightWorkItem)
local TimeScale1 = 1
local DeadActionTime1 = 0.35
local DelayEffectTime1 = 0.4
local TimeScale2 = 1
local DeadActionTime2 = 0.1
local DelayEffectTime2 = 0.6

function FightWorkEffectDeadNew:onConstructor(fightStepData, fightActEffectData, waitForLastHit)
	self.fightStepData = fightStepData
	self.actEffectData = fightActEffectData
	self._waitForLastHit = waitForLastHit
end

function FightWorkEffectDeadNew:onStart()
	self:cancelFightWorkSafeTimer()

	self._deadEntity = FightHelper.getEntity(self.actEffectData.targetId)

	if self._deadEntity and not self._deadEntity.isDead then
		self._deadEntity.isDead = true

		if isTypeOf(self._deadEntity, FightEntityAssembledMonsterMain) then
			self._deadEntity:killAllSubMonster()
		end

		if isTypeOf(self._deadEntity, FightEntityAssembledMonsterSub) then
			self:onDone(true)

			return
		end

		self._deadEntityModelId = self._deadEntity:getMO().modelId

		FightController.instance:dispatchEvent(FightEvent.OnStartEntityDead, self._deadEntity.id)

		if self.fightStepData.actType == FightEnum.ActType.SKILL then
			self._deadEntity.deadBySkillId = self.fightStepData.actId
		end

		if self._waitForLastHit then
			local attacker = FightHelper.getEntity(self.fightStepData.fromId)

			if not attacker then
				self:_playDeadWork()

				return
			end

			FightController.instance:registerCallback(FightEvent.OnSkillLastHit, self._onLastHit, self)
			FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
			FightController.instance:registerCallback(FightEvent.PlaySameSkillOneDone, self._playSameSKillOneDone, self)
			FightController.instance:registerCallback(FightEvent.InvokeEntityDeadImmediately, self._invokeEntityDeadImmediately, self)
		else
			self:_playDeadWork()
		end
	else
		self:onDone(true)
	end
end

function FightWorkEffectDeadNew:_invokeEntityDeadImmediately(entityId, fightStepData)
	self:_onLastHit(entityId, fightStepData)
end

function FightWorkEffectDeadNew:_onLastHit(entityId, fightStepData)
	if self.fightStepData == fightStepData then
		if fightStepData.actId ~= self.fightStepData.actId then
			return
		end

		if entityId ~= self._deadEntity.id then
			return
		end

		if self._deadEntity then
			local entityMO = self._deadEntity:getMO()

			if not ((entityMO and lua_fight_skin_replay_lasthit.configDict[entityMO.skin] or nil) and true) and self:_isNoDeadEffect() then
				self._deadEntity.spine:play(SpineAnimState.hit, false, true)

				return
			end

			FightController.instance:unregisterCallback(FightEvent.OnSkillLastHit, self._onLastHit, self)
			FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
			FightController.instance:unregisterCallback(FightEvent.PlaySameSkillOneDone, self._playSameSKillOneDone, self)
			self:_playDeadWork()
		end
	end
end

function FightWorkEffectDeadNew:_playSameSKillOneDone(fightStepData)
	if self.fightStepData == fightStepData then
		FightController.instance:unregisterCallback(FightEvent.OnSkillLastHit, self._onLastHit, self)
		FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
		FightController.instance:unregisterCallback(FightEvent.PlaySameSkillOneDone, self._playSameSKillOneDone, self)
		self:_playDeadWork()
	end
end

function FightWorkEffectDeadNew:_onSkillPlayFinish(entity, skillId, fightStepData)
	if self.fightStepData == fightStepData then
		FightController.instance:unregisterCallback(FightEvent.OnSkillLastHit, self._onLastHit, self)
		FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
		FightController.instance:unregisterCallback(FightEvent.PlaySameSkillOneDone, self._playSameSKillOneDone, self)
		self:_playDeadWork()
	end
end

function FightWorkEffectDeadNew:_playDeadWork()
	local entityMO = self._deadEntity:getMO()
	local aniName = self:_getDieActName(entityMO)

	if aniName then
		self._deadEntity.spine:play(aniName, false, false)
	end

	for _, buffMO in pairs(entityMO:getBuffDic()) do
		self._deadEntity.buff:delBuff(buffMO.uid, true)
	end

	entityMO:clearAllBuff()
	self._deadEntity:resetSpineMat()
	FightController.instance:dispatchEvent(FightEvent.BeforeDeadEffect, self._deadEntity.id)
	FightController.instance:dispatchEvent(FightEvent.SetEntityWeatherEffectVisible, self._deadEntity, false)
	FightController.instance:dispatchEvent(FightEvent.OnSpineMaterialChange, self._deadEntity.id, self._deadEntity.spineRenderer:getReplaceMat())

	if entityMO.modelId == 111101 then
		local fight_param = FightModel.instance:getFightParam()

		if fight_param.episodeId == 10115 then
			self._direct_end_work = true
		end
	end

	local v1 = "OnGuideEntityDeadPause"
	local v2 = FightEvent.OnGuideEntityDeadPause
	local v3 = FightEvent.OnGuideEntityDeadContinue
	local v4 = self._deadContinue
	local v5 = self
	local v6 = {
		side = self._deadEntity:getSide(),
		modelId = self._deadEntity:getMO().modelId
	}
	local result = FightController.instance:GuideFlowPauseAndContinue(v1, v2, v3, v4, v5, v6)

	if result then
		-- block empty
	end

	if self._deadEntity.nameUI then
		self._deadEntity.nameUI:playDeadEffect()
	end

	FightAudioMgr.instance:playHeroVoiceRandom(self._deadEntity:getMO().modelId, CharacterEnum.VoiceType.FightDie)
end

function FightWorkEffectDeadNew:_getDieActName(entityMO)
	local deadPerformanceConfig = lua_fight_skin_dead_performance.configDict[entityMO.skin]

	if deadPerformanceConfig then
		return nil
	end

	local aniName = SpineAnimState.die
	local fight_die_act_config = lua_fight_die_act_enemyus.configDict[entityMO.skin]

	if fight_die_act_config then
		fight_die_act_config = self._deadEntity:isMySide() and fight_die_act_config[1] or fight_die_act_config[2]

		if fight_die_act_config then
			self._showDeadEffect = fight_die_act_config.playEffect
			aniName = fight_die_act_config.act
		end
	end

	return aniName
end

function FightWorkEffectDeadNew:_deadContinue()
	local entityMO = self._deadEntity:getMO()
	local deadPerformanceConfig = lua_fight_skin_dead_performance.configDict[entityMO.skin]

	if deadPerformanceConfig then
		self:_delayNoDeadEffectDone()
	else
		local skeletonAnim = self._deadEntity.spine:getSkeletonAnim()

		if gohelper.isNil(skeletonAnim) then
			-- block empty
		end

		local deadAnimDuration = skeletonAnim and skeletonAnim:GetCurAnimDuration() or 0.01
		local spineActionDict = FightConfig.instance:getSkinSpineActionDict(self._deadEntity:getMO().skin)
		local spineActionCO = spineActionDict and spineActionDict[SpineAnimState.die]

		if spineActionCO and spineActionCO.effectRemoveTime ~= 0 then
			deadAnimDuration = spineActionCO.effectRemoveTime
		end

		deadAnimDuration = deadAnimDuration / FightModel.instance:getSpeed()

		if self:_isNoDeadEffect() then
			TaskDispatcher.runDelay(self._delayNoDeadEffectDone, self, deadAnimDuration)
		elseif self._deadEntity then
			local mo = self._deadEntity:getMO()

			if mo and mo:isCharacter() then
				if not DeadActionTime1 then
					local deadActionTime = DeadActionTime2

					TaskDispatcher.runDelay(self._deadComplete, self, deadAnimDuration * deadActionTime)
				end
			end
		end
	end

	if FightDataHelper.stateMgr.isReplay then
		TaskDispatcher.runRepeat(self._tick, self, 1, 10)
	end
end

function FightWorkEffectDeadNew:_tick()
	if FightDataHelper.stateMgr.isReplay then
		FightController.instance:dispatchEvent(FightEvent.ReplayTick)
	end
end

function FightWorkEffectDeadNew:_deadComplete()
	local entityMO = self._deadEntity:getMO()
	local isCharacter = not not (entityMO and entityMO:isCharacter())
	local deadEffectType = self:_getDeadEffectType()

	if deadEffectType == FightEnum.DeadEffectType.NormalEffect then
		if isCharacter then
			if not DelayEffectTime1 then
				local delayEffectTime = DelayEffectTime2

				TaskDispatcher.runDelay(self._deadPlayEffect, self, delayEffectTime / FightModel.instance:getSpeed())
			end
		end
	end

	self._dissolveWork = SpineDissolveWork.New()

	self._dissolveWork:registerDoneListener(self._onDissolveDone, self)

	local context = {}

	context.dissolveEntity = self._deadEntity
	context.dissolveType = self:_getDissolveType(deadEffectType, isCharacter)

	if isCharacter then
		context.timeScale = TimeScale1 or TimeScale2
	end

	self._dissolveWork:onStart(context)
end

function FightWorkEffectDeadNew:_getDissolveType(deadEffectType, isCharacter)
	if deadEffectType == FightEnum.DeadEffectType.NormalEffect then
		return (isCharacter or nil) and (FightEnum.DissolveType.Player or FightEnum.DissolveType.Monster)
	elseif deadEffectType == FightEnum.DeadEffectType.ZaoWu then
		return FightEnum.DissolveType.ZaoWu
	elseif deadEffectType == FightEnum.DeadEffectType.Abjqr4 then
		return FightEnum.DissolveType.Abjqr4
	else
		return (isCharacter or nil) and (FightEnum.DissolveType.Player or FightEnum.DissolveType.Monster)
	end
end

function FightWorkEffectDeadNew:_deadPlayEffect()
	if self._deadEntity:isMySide() then
		if not FightPreloadEffectWork.buff_siwang then
			local effectPath = FightPreloadEffectWork.buff_siwang_monster

			if effectPath == FightPreloadEffectWork.buff_siwang_monster then
				AudioMgr.instance:trigger(410000079)
			end

			if self._deadEntity.effect:isDestroyed() then
				return
			end

			self._effectWrap = self._deadEntity.effect:addHangEffect(effectPath, ModuleEnum.SpineHangPointRoot)

			FightRenderOrderMgr.instance:onAddEffectWrap(self._deadEntity.id, self._effectWrap)
			self._effectWrap:setLocalPos(0, 0, 0)
		end
	end
end

function FightWorkEffectDeadNew:_onDissolveDone()
	self:_doneAndRemoveEntity()
end

function FightWorkEffectDeadNew:_delayNoDeadEffectDone()
	if self._direct_end_work then
		self:_checkDieDialogAfter()

		return
	end

	self:_doneAndRemoveEntity()
end

function FightWorkEffectDeadNew:_doneAndRemoveEntity()
	TaskDispatcher.cancelTask(self._deadPlayEffect, self)

	self._afterDeadFlow = FlowSequence.New()

	local entityMgr = FightGameMgr.entityMgr
	local isMySide = self._deadEntity:isMySide()
	local entityMO = self._deadEntity:getMO()
	local deadMgrConfig = entityMO and lua_fight_dead_entity_mgr.configDict[entityMO.skin]
	local deadPerformanceConfig = entityMO and lua_fight_skin_dead_performance.configDict[entityMO.skin]

	if deadMgrConfig then
		entityMgr.entityDic[self._deadEntity.id] = nil

		FightController.instance:dispatchEvent(FightEvent.EntrustEntity, self._deadEntity)
		self._afterDeadFlow:addWork(WorkWaitSeconds.New(deadMgrConfig.playTime / 1000))
	elseif deadPerformanceConfig then
		self._afterDeadFlow:addWork(FightHelper.buildDeadPerformanceWork(deadPerformanceConfig, self._deadEntity))
		self._afterDeadFlow:addWork(FunctionWork.New(function()
			entityMgr:delEntity(self._deadEntity.id)
		end))
	else
		entityMgr:delEntity(self._deadEntity.id)
	end

	self._afterDeadFlow:addWork(FunctionWork.New(self._dispatchDead, self))

	if isMySide then
		self._afterDeadFlow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.CheckDeadEntityCount))
	end

	self._afterDeadFlow:registerDoneListener(self._checkDieDialogAfter, self)
	self._afterDeadFlow:start()
end

function FightWorkEffectDeadNew:_dispatchDead()
	FightController.instance:dispatchEvent(FightEvent.OnEntityDead, self._deadEntity.id)
end

function FightWorkEffectDeadNew:_checkDieDialogAfter()
	FightWorkEffectDeadNew.needStopDeadWork = nil

	if self._deadEntityModelId then
		FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterDieP, self._deadEntityModelId)

		if FightWorkEffectDeadNew.needStopDeadWork then
			FightController.instance:registerCallback(FightEvent.FightDialogEnd, self._onFightDialogEnd, self)
		else
			self:_onFinish()
		end
	else
		self:_onFinish()
	end
end

function FightWorkEffectDeadNew:_onFightDialogEnd()
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, self._onFightDialogEnd, self)
	self:_onFinish()
end

function FightWorkEffectDeadNew:_onFinish()
	FightController.instance:dispatchEvent(FightEvent.EntityDeadFinish, self._deadEntityModelId)
	self:onDone(true)
end

function FightWorkEffectDeadNew:clearWork()
	if self._afterDeadFlow then
		self._afterDeadFlow:unregisterDoneListener(self._checkDieDialogAfter, self)
		self._afterDeadFlow:stop()

		self._afterDeadFlow = nil
	end

	TaskDispatcher.cancelTask(self._tick, self)

	if self._dissolveWork then
		self._dissolveWork:onStop()
		self._dissolveWork:unregisterDoneListener(self._onDissolveDone, self)

		self._dissolveWork = nil
	end

	FightController.instance:unregisterCallback(FightEvent.InvokeEntityDeadImmediately, self._invokeEntityDeadImmediately, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillLastHit, self._onLastHit, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, self._onFightDialogEnd, self)
	TaskDispatcher.cancelTask(self._deadPlayEffect, self)
	TaskDispatcher.cancelTask(self._deadComplete, self)
	TaskDispatcher.cancelTask(self._delayNoDeadEffectDone, self)

	self.fightStepData = nil
	self.actEffectData = nil
end

function FightWorkEffectDeadNew:onResume()
	logError("dead step can't resume")
end

function FightWorkEffectDeadNew:_isNoDeadEffect()
	if self._showDeadEffect == 0 then
		return true
	elseif self._showDeadEffect == 1 then
		return false
	end

	if self._deadEntity then
		local mo = self._deadEntity:getMO()
		local skinId = mo and mo.skin

		if not skinId then
			local co = mo and mo:getCO()

			skinId = co and co.skinId
		end

		local skinCO = FightConfig.instance:getSkinCO(skinId)

		return skinCO and skinCO.noDeadEffect == FightEnum.DeadEffectType.NoEffect
	end
end

function FightWorkEffectDeadNew:_getDeadEffectType()
	if self._deadEntity then
		local mo = self._deadEntity:getMO()

		if mo then
			::label_25_0::

			local skinCO = FightConfig.instance:getSkinCO(mo.skin)

			return skinCO and skinCO.noDeadEffect
		end
	end
end

return FightWorkEffectDeadNew
