-- chunkname: @modules/logic/fight/system/work/FightBuffTriggerEffect.lua

module("modules.logic.fight.system.work.FightBuffTriggerEffect", package.seeall)

local FightBuffTriggerEffect = class("FightBuffTriggerEffect", FightEffectBase)
local OnceEffectTime = 2
local AnimTime = 2

function FightBuffTriggerEffect:onStart()
	local targetEntity = FightHelper.getEntity(self.actEffectData.targetId)

	if not targetEntity then
		self:onDone(true)

		return
	end

	local buffCO = lua_skill_buff.configDict[self.actEffectData.effectNum]

	if buffCO and FightHelper.shouUIPoisoningEffect(buffCO.id) and targetEntity.nameUI and targetEntity.nameUI.showPoisoningEffect then
		targetEntity.nameUI:showPoisoningEffect(buffCO)
	end

	local triggerEffect, triggerEffectHangPoint, triggerAudio = self:_getBuffTriggerParam(buffCO, targetEntity)

	if triggerEffect ~= "0" and not string.nilorempty(triggerEffect) then
		local side = targetEntity:getSide()
		local effectPath = "buff/" .. triggerEffect

		self._effectWrap = nil

		if not string.nilorempty(triggerEffectHangPoint) then
			self._effectWrap = targetEntity.effect:addHangEffect(effectPath, triggerEffectHangPoint, side)

			self._effectWrap:setLocalPos(0, 0, 0)
		else
			self._effectWrap = targetEntity.effect:addGlobalEffect(effectPath, side)

			local posX, posY, posZ = transformhelper.getPos(targetEntity.go.transform)

			self._effectWrap:setWorldPos(posX, posY, posZ)
		end

		FightRenderOrderMgr.instance:onAddEffectWrap(targetEntity.id, self._effectWrap)
		TaskDispatcher.runDelay(self._onTickCheckRemoveEffect, self, OnceEffectTime / FightModel.instance:getSpeed())
	end

	if triggerAudio and triggerAudio > 0 then
		FightAudioMgr.instance:playAudio(triggerAudio)
	end

	self._animationName = buffCO and buffCO.triggerAnimationName
	self._animationName = FightHelper.processEntityActionName(targetEntity, self._animationName)

	if not string.nilorempty(self._animationName) and targetEntity.spine and targetEntity.spine:hasAnimation(self._animationName) then
		self._hasPlayAnim = true

		targetEntity.spine:addAnimEventCallback(self._onAnimEvent, self)
		targetEntity.spine:play(self._animationName, false, true, true)
		TaskDispatcher.runDelay(self._onTickCheckRemoveAnim, self, AnimTime / FightModel.instance:getSpeed())
	end

	self:onDone(true)
end

function FightBuffTriggerEffect:_getBuffTriggerParam(buffCO, targetEntity)
	local triggerEffect = buffCO and buffCO.triggerEffect
	local triggerEffectHangPoint = buffCO and buffCO.triggerEffectHangPoint
	local triggerAudio = buffCO and buffCO.triggerAudio

	if string.nilorempty(triggerEffect) or triggerEffect == "0" then
		local buffActCO = lua_buff_act.configDict[self.actEffectData.buffActId]

		if buffActCO and not string.nilorempty(buffActCO.effect) then
			local effect = buffActCO.effect
			local effectHangPoint = buffActCO.effectHangPoint
			local audio = buffActCO.audioId

			if targetEntity then
				::label_2_0::

				local entityMO = FightDataHelper.entityMgr:getById(targetEntity.id)
				local replaceConfig = entityMO and lua_fight_replace_buff_act_effect.configDict[entityMO.skin]

				replaceConfig = replaceConfig and replaceConfig[buffActCO.id]

				if replaceConfig then
					effect = string.nilorempty(replaceConfig.effect) and effect or replaceConfig.effect
					effectHangPoint = string.nilorempty(replaceConfig.effectHangPoint) and effectHangPoint or replaceConfig.effectHangPoint
					audio = replaceConfig.audioId == 0 and audio or replaceConfig.audioId
				end

				if effect ~= "0" and not string.nilorempty(effect) then
					return effect, effectHangPoint, audio
				end
			end
		end
	end

	if buffCO then
		triggerEffect = FightHelper.processBuffEffectPath(triggerEffect, targetEntity, buffCO.id, "triggerEffect")
	end

	return triggerEffect, triggerEffectHangPoint, triggerAudio
end

function FightBuffTriggerEffect:_onAnimEvent(actionName, eventName, eventArgs)
	if actionName == self._animationName and eventName == SpineAnimEvent.ActionComplete then
		local targetEntity = FightHelper.getEntity(self.actEffectData.targetId)

		if targetEntity then
			targetEntity.spine:removeAnimEventCallback(self._onAnimEvent, self)

			if not FightSkillMgr.instance:isEntityPlayingTimeline(targetEntity.id) then
				targetEntity:resetAnimState()
			end
		end
	end
end

function FightBuffTriggerEffect:_onTickCheckRemoveEffect()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return
	end

	local targetEntity = FightHelper.getEntity(self.actEffectData.targetId)

	if self._effectWrap and targetEntity then
		targetEntity.effect:removeEffect(self._effectWrap)

		self._effectWrap = nil
	end
end

function FightBuffTriggerEffect:_onTickCheckRemoveAnim()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return
	end

	local targetEntity = FightHelper.getEntity(self.actEffectData.targetId)

	if targetEntity then
		targetEntity.spine:removeAnimEventCallback(self._onAnimEvent, self)
	end
end

function FightBuffTriggerEffect:onDestroy()
	TaskDispatcher.cancelTask(self._onTickCheckRemoveEffect, self)
	TaskDispatcher.cancelTask(self._onTickCheckRemoveAnim, self)

	if self._hasPlayAnim then
		local targetEntity = FightHelper.getEntity(self.actEffectData.targetId)

		if targetEntity then
			targetEntity.spine:removeAnimEventCallback(self._onAnimEvent, self)
		end
	end

	FightBuffTriggerEffect.super.onDestroy(self)
end

return FightBuffTriggerEffect
