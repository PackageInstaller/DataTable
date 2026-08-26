-- chunkname: @modules/logic/fight/entity/mgr/FightSkillBehaviorMgr.lua

module("modules.logic.fight.entity.mgr.FightSkillBehaviorMgr", package.seeall)

local FightSkillBehaviorMgr = class("FightSkillBehaviorMgr")

function FightSkillBehaviorMgr:init()
	FightController.instance:registerCallback(FightEvent.OnSkillEffectPlayFinish, self._onSkillEffectPlayFinish, self)

	self._hasPlayDict = {}
	self._specialWorkList = {}
end

function FightSkillBehaviorMgr:playSkillEffectBehavior(fightStepData, actEffectData)
	if not fightStepData or not actEffectData then
		return
	end

	if FightSkillMgr.instance:isPlayingAnyTimeline() then
		return
	end

	local behaviorType = actEffectData.configEffect

	if behaviorType and behaviorType > 0 then
		local entityBehaviorKey = actEffectData.targetId .. ":" .. behaviorType
		local hasPlayDict = self._hasPlayDict[fightStepData.stepUid]

		if not hasPlayDict then
			hasPlayDict = {}
			self._hasPlayDict[fightStepData.stepUid] = hasPlayDict
		end

		if not hasPlayDict[entityBehaviorKey] then
			hasPlayDict[entityBehaviorKey] = true

			local skillBehaviorCO = lua_skill_behavior.configDict[behaviorType]

			if skillBehaviorCO then
				self:_doSkillBehaviorEffect(fightStepData, actEffectData, skillBehaviorCO, false)
			end
		end
	end
end

function FightSkillBehaviorMgr:playSkillBehavior(fightStepData, needPlayBehaviorTypeDict, isSkillTimeline)
	if not fightStepData then
		return
	end

	local skillId = fightStepData.actId
	local skillCO = lua_skill.configDict[skillId]

	if not skillCO then
		return
	end

	for _, actEffectData in ipairs(fightStepData.actEffect) do
		local behaviorType = actEffectData.configEffect

		if behaviorType and behaviorType > 0 then
			local timelineNeedPlay = needPlayBehaviorTypeDict and needPlayBehaviorTypeDict[behaviorType]
			local entityBehaviorKey = actEffectData.targetId .. ":" .. behaviorType
			local hasPlayDict = self._hasPlayDict[fightStepData.stepUid]

			if not hasPlayDict then
				hasPlayDict = {}
				self._hasPlayDict[fightStepData.stepUid] = hasPlayDict
			end

			local skillEndNeedPlay = not needPlayBehaviorTypeDict and not hasPlayDict[entityBehaviorKey]

			if timelineNeedPlay or skillEndNeedPlay then
				hasPlayDict[entityBehaviorKey] = true

				local skillBehaviorCO = lua_skill_behavior.configDict[behaviorType]

				if skillBehaviorCO then
					self:_doSkillBehaviorEffect(fightStepData, actEffectData, skillBehaviorCO, isSkillTimeline)
				end
			end
		end
	end
end

function FightSkillBehaviorMgr:_doSkillBehaviorEffect(fightStepData, actEffectData, skillBehaviorCO, isSkillTimeline)
	local targetEntity = FightHelper.getEntity(actEffectData.targetId)

	targetEntity = targetEntity or actEffectData.entity and FightHelper.getEntity(actEffectData.entity.id)

	local effectPath = skillBehaviorCO.effect
	local effectHangPoint = skillBehaviorCO.effectHangPoint
	local audioId = skillBehaviorCO.audioId
	local entityMO = FightDataHelper.entityMgr:getById(fightStepData.fromId)

	if entityMO then
		local replaceConfig = lua_fight_replace_skill_behavior_effect.configDict[entityMO.skin]

		replaceConfig = replaceConfig and replaceConfig[skillBehaviorCO.id]

		if replaceConfig then
			effectPath = string.nilorempty(replaceConfig.effect) and effectPath or replaceConfig.effect
			effectHangPoint = string.nilorempty(replaceConfig.effectHangPoint) and effectHangPoint or replaceConfig.effectHangPoint
			audioId = replaceConfig.audioId == 0 and audioId or replaceConfig.audioId
		end
	end

	if skillBehaviorCO.id == 60052 and entityMO then
		local config = lua_fight_sp_effect_kkny_bear_damage_hit.configDict[entityMO.skin]

		if config then
			effectPath = config.path
			effectHangPoint = config.hangPoint
			audioId = config.audio
		end
	end

	if not string.nilorempty(effectPath) and targetEntity and targetEntity.effect then
		local effectWrap

		if not string.nilorempty(effectHangPoint) then
			effectWrap = targetEntity.effect:addHangEffect(effectPath, effectHangPoint)

			effectWrap:setLocalPos(0, 0, 0)
		else
			effectWrap = targetEntity.effect:addGlobalEffect(effectPath)

			effectWrap:setWorldPos(FightHelper.getProcessEntitySpinePos(targetEntity))
		end

		FightRenderOrderMgr.instance:onAddEffectWrap(targetEntity.id, effectWrap)

		self._effectCache = self._effectCache or {}

		table.insert(self._effectCache, {
			targetEntity.id,
			effectWrap,
			Time.time
		})
		TaskDispatcher.runRepeat(self._removeEffects, self, 0.5)
	end

	if audioId > 0 then
		FightAudioMgr.instance:playAudio(audioId)
	end

	if skillBehaviorCO.dec_Type > 0 then
		FightFloatMgr.instance:float((actEffectData.effectType == FightEnum.EffectType.CARDLEVELCHANGE or nil) and (actEffectData.entity and actEffectData.entity.uid or fightStepData.fromId), FightEnum.FloatType.buff, skillBehaviorCO.dec, skillBehaviorCO.dec_Type, false)
	end

	if isSkillTimeline then
		local btype = skillBehaviorCO.type

		if (btype == FightEnum.Behavior_AddExPoint or btype == FightEnum.Behavior_DelExPoint) and actEffectData.effectType == FightEnum.EffectType.EXPOINTCHANGE then
			local work = FightWork2Work.New(FightWorkExPointChange, fightStepData, actEffectData)

			work:onStart()
			table.insert(self._specialWorkList, work)
		elseif FightEnum.BuffEffectType[actEffectData.effectType] then
			FightSkillBuffMgr.instance:playSkillBuff(fightStepData, actEffectData)
		elseif btype == FightEnum.Behavior_LostLife and actEffectData.effectType == FightEnum.EffectType.DAMAGE and not actEffectData:isDone() then
			local work = FightWork2Work.New(FightWorkEffectDamage, fightStepData, actEffectData)

			work:onStart()
			table.insert(self._specialWorkList, work)
		end
	end
end

function FightSkillBehaviorMgr:_onSkillEffectPlayFinish(fightStepData)
	self:playSkillBehavior(fightStepData, false)
end

function FightSkillBehaviorMgr:_removeEffects(removeAll)
	if not self._effectCache then
		return
	end

	local now = Time.time

	for i = #self._effectCache, 1, -1 do
		local entityId = self._effectCache[i][1]
		local effectWrap = self._effectCache[i][2]
		local cacheTime = self._effectCache[i][3]
		local entity = FightHelper.getEntity(entityId)

		if removeAll or now - cacheTime > 2 then
			if entity then
				FightRenderOrderMgr.instance:onRemoveEffectWrap(entity.id, effectWrap)
				entity.effect:removeEffect(effectWrap)
			end

			table.remove(self._effectCache, i)
		end
	end

	if #self._effectCache == 0 then
		TaskDispatcher.cancelTask(self._removeEffects, self)
	end
end

function FightSkillBehaviorMgr:dispose()
	if self._specialWorkList then
		for _, work in ipairs(self._specialWorkList) do
			if work.status == WorkStatus.Running then
				work:onStop()
			end
		end
	end

	self._specialWorkList = nil

	FightController.instance:unregisterCallback(FightEvent.OnSkillEffectPlayFinish, self._onSkillEffectPlayFinish, self)
	TaskDispatcher.cancelTask(self._removeEffects, self)
	self:_removeEffects(true)

	self._effectCache = nil
	self._hasPlayDict = nil
end

FightSkillBehaviorMgr.instance = FightSkillBehaviorMgr.New()

return FightSkillBehaviorMgr
