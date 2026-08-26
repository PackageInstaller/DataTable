-- chunkname: @modules/logic/fight/mgr/FightTriggerBuffMgr.lua

module("modules.logic.fight.mgr.FightTriggerBuffMgr", package.seeall)

local FightTriggerBuffMgr = class("FightTriggerBuffMgr", FightBaseClass)

function FightTriggerBuffMgr:onConstructor()
	self.entityIdPlayingAniNameDict = {}
end

function FightTriggerBuffMgr:triggerBuffEffect(actEffectData)
	local hurtInfo = actEffectData.hurtInfo

	if not hurtInfo then
		return
	end

	if hurtInfo.damageFromType ~= FightHurtInfoData.DamageFromType.Buff then
		return
	end

	local buffUid = tostring(hurtInfo.buffUid)
	local buffMo = FightDataHelper.calMgr:getBuffMo(buffUid)

	if not buffMo then
		return
	end

	local targetUid = actEffectData.targetId
	local targetEntity = FightHelper.getEntity(targetUid)

	if not targetEntity then
		return
	end

	local buffCo = buffMo:getCO()

	if not buffCo then
		return
	end

	local effect, hangPoint, audio = self:getBuffTriggerParam(buffCo, hurtInfo.buffActId, targetEntity)

	self:addEffect(effect, hangPoint, audio, targetEntity)
	self:playAnim(buffCo, targetEntity)
end

function FightTriggerBuffMgr:getBuffTriggerParam(buffCo, buffActId, targetEntity)
	local triggerEffect = buffCo.triggerEffect
	local triggerEffectHangPoint = buffCo.triggerEffectHangPoint
	local triggerAudio = buffCo.triggerAudio

	if string.nilorempty(triggerEffect) or triggerEffect == "0" then
		local buffActCo = buffActId and lua_buff_act.configDict[buffActId]

		if buffActCo and not string.nilorempty(buffActCo.effect) then
			local effect = buffActCo.effect
			local effectHangPoint = buffActCo.effectHangPoint
			local audio = buffActCo.audioId

			if targetEntity then
				::label_3_0::

				local entityMO = FightDataHelper.entityMgr:getById(targetEntity.id)
				local replaceConfig = entityMO and lua_fight_replace_buff_act_effect.configDict[entityMO.skin]

				replaceConfig = replaceConfig and replaceConfig[buffActCo.id]

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

	triggerEffect = FightHelper.processBuffEffectPath(triggerEffect, targetEntity, buffCo.id, "triggerEffect")

	return triggerEffect, triggerEffectHangPoint, triggerAudio
end

local EffectDuration = 2

function FightTriggerBuffMgr:addEffect(effect, hangPoint, audio, targetEntity)
	if effect == "0" or string.nilorempty(effect) then
		return
	end

	if not string.find(effect, "/") then
		effect = "buff/" .. effect
	end

	local duration = EffectDuration / FightModel.instance:getSpeed()
	local effectWrap

	if not string.nilorempty(hangPoint) then
		effectWrap = targetEntity.effect:addHangEffect(effect, hangPoint, nil, duration)

		effectWrap:setLocalPos(0, 0, 0)
	else
		effectWrap = targetEntity.effect:addGlobalEffect(effect, nil, duration)

		local posX, posY, posZ = transformhelper.getPos(targetEntity.go.transform)

		effectWrap:setWorldPos(posX, posY, posZ)
	end

	FightRenderOrderMgr.instance:onAddEffectWrap(targetEntity.id, effectWrap)

	if audio and audio > 0 then
		FightAudioMgr.instance:playAudio(audio)
	end
end

function FightTriggerBuffMgr:playAnim(buffCo, targetEntity)
	if not buffCo then
		return
	end

	local animationName = buffCo.triggerAnimationName

	if string.nilorempty(animationName) then
		return
	end

	animationName = FightHelper.processEntityActionName(targetEntity, animationName)

	if targetEntity.spine and targetEntity.spine:hasAnimation(animationName) then
		targetEntity.spine:addAnimEventCallback(self.onAnimEvent, self, targetEntity.id)
		targetEntity.spine:play(animationName, false, true, true)
	end
end

function FightTriggerBuffMgr:onAnimEvent(actionName, eventName, eventArgs, entityUid)
	if eventName ~= SpineAnimEvent.ActionComplete then
		return
	end

	local playingAnim = self.entityIdPlayingAniNameDict[entityUid]

	if playingAnim == actionName then
		local targetEntity = FightHelper.getEntity(entityUid)

		if targetEntity then
			targetEntity.spine:removeAnimEventCallback(self.onAnimEvent, self)

			if not FightSkillMgr.instance:isEntityPlayingTimeline(entityUid) then
				targetEntity:resetAnimState()
			end
		end
	end
end

function FightTriggerBuffMgr:onDestructor()
	for entityUid, _ in pairs(self.entityIdPlayingAniNameDict) do
		local entity = FightHelper.getEntity(entityUid)

		if entity then
			entity.spine:removeAllAnimEventCallback()
		end
	end

	tabletool.clear(self.entityIdPlayingAniNameDict)
end

return FightTriggerBuffMgr
