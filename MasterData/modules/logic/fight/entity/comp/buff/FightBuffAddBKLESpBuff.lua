-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffAddBKLESpBuff.lua

module("modules.logic.fight.entity.comp.buff.FightBuffAddBKLESpBuff", package.seeall)

local FightBuffAddBKLESpBuff = class("FightBuffAddBKLESpBuff")

function FightBuffAddBKLESpBuff:ctor()
	return
end

function FightBuffAddBKLESpBuff:onBuffStart(entity, buffMo)
	if not entity then
		return
	end

	local formId = buffMo.fromUid
	local fromEntityMo = FightDataHelper.entityMgr:getById(formId)

	if not fromEntityMo then
		return
	end

	local skinId = fromEntityMo.skin
	local co = lua_fight_sp_effect_bkle.configDict[skinId]

	if not co then
		return
	end

	local effectRes = FightHeroSpEffectConfig.instance:getBKLEAddBuffEffect(skinId)

	if not effectRes then
		return
	end

	self.entity = entity
	self.buffMo = buffMo
	self.wrap = entity.effect:addHangEffect(effectRes, co.hangPoint)

	FightRenderOrderMgr.instance:onAddEffectWrap(entity.id, self.wrap)
	self.wrap:setLocalPos(0, 0, 0)

	local audioId = co.audio

	if audioId ~= 0 then
		AudioMgr.instance:trigger(audioId)
	end

	entity.buff:addLoopBuff(self.wrap)
end

function FightBuffAddBKLESpBuff:onBuffEnd()
	if not self.wrap then
		return
	end

	self.entity.buff:removeLoopBuff(self.wrap)
	self.entity.effect:removeEffect(self.wrap)
	FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entity.id, self.wrap)

	self.wrap = nil
end

return FightBuffAddBKLESpBuff
