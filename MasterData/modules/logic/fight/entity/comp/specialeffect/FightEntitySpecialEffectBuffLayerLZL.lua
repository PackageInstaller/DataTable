-- chunkname: @modules/logic/fight/entity/comp/specialeffect/FightEntitySpecialEffectBuffLayerLZL.lua

module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffectBuffLayerLZL", package.seeall)

local FightEntitySpecialEffectBuffLayerLZL = class("FightEntitySpecialEffectBuffLayerLZL", FightBaseClass)

function FightEntitySpecialEffectBuffLayerLZL:onConstructor(entity)
	self.entity = entity
	self.entityId = self.entity.id
	self.curEffectWrap = nil

	self:com_registFightEvent(FightEvent.OnBuffUpdate, self.onBuffUpdate)
end

function FightEntitySpecialEffectBuffLayerLZL:onBuffUpdate(entityId, effectType, buffId, buffUid)
	if entityId ~= self.entityId then
		return
	end

	if effectType ~= FightEnum.EffectType.BUFFUPDATE and effectType ~= FightEnum.EffectType.BUFFADD then
		return
	end

	local buffCo = lua_skill_buff.configDict[buffId]
	local buffTypeId = buffCo and buffCo.typeId

	if not buffTypeId then
		return
	end

	local layerEffectNaNaCo = lua_fight_lzl_buff_float.configDict[buffTypeId]

	if not layerEffectNaNaCo then
		return
	end

	if self.entity then
		local entityMo = self.entity:getMO()

		if not entityMo then
			return
		end

		local buffMo = entityMo:getBuffMO(buffUid)

		if not buffMo then
			return
		end

		local layer = buffMo.layer

		layerEffectNaNaCo = layerEffectNaNaCo[layer] or layerEffectNaNaCo[311601]

		if not layerEffectNaNaCo then
			logError(string.format("冷周六飘字表没找到buffTypeId = `%s`, layer = `%s` 的配置", buffTypeId, layer))

			return
		end

		layerEffectNaNaCo = layerEffectNaNaCo[entityMo.skin]

		if not layerEffectNaNaCo then
			logError(string.format("冷周六飘字表没找到buffTypeId = `%s`, layer = `%s`, skinId = `%s` 的配置", buffTypeId, layer, entityMo.skin))

			return
		end

		self:removeEffect()

		local effect = layerEffectNaNaCo.effect
		local hangPoint = layerEffectNaNaCo.effectRoot
		local audio = layerEffectNaNaCo.effectAudio
		local duration = layerEffectNaNaCo.duration

		self.curEffectWrap = self.entity.effect:addHangEffect(effect, hangPoint, nil, duration)

		self.curEffectWrap:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(entityId, self.curEffectWrap)

		if audio > 0 then
			FightAudioMgr.instance:playAudio(audio)
		end
	end
end

function FightEntitySpecialEffectBuffLayerLZL:removeEffect()
	if self.curEffectWrap then
		self.entity.effect:removeEffect(self.curEffectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entityId, self.curEffectWrap)

		self.curEffectWrap = nil
	end
end

function FightEntitySpecialEffectBuffLayerLZL:onDestructor()
	self:removeEffect()
end

return FightEntitySpecialEffectBuffLayerLZL
