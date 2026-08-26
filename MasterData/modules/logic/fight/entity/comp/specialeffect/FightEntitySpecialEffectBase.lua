-- chunkname: @modules/logic/fight/entity/comp/specialeffect/FightEntitySpecialEffectBase.lua

module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffectBase", package.seeall)

local FightEntitySpecialEffectBase = class("FightEntitySpecialEffectBase", UserDataDispose)

function FightEntitySpecialEffectBase:ctor(entity)
	self:__onInit()

	self._entity = entity
	self._internalEffects = {}
	self._internalClass = {}

	self:initClass()
end

function FightEntitySpecialEffectBase:initClass()
	return
end

function FightEntitySpecialEffectBase:newClass(class)
	table.insert(self._internalClass, class.New(self._entity))
end

function FightEntitySpecialEffectBase:addHangEffect(...)
	local effectWrap = self._entity:addHangEffect(...)

	self._internalEffects[effectWrap.uniqueId] = effectWrap

	return effectWrap
end

function FightEntitySpecialEffectBase:addGlobalEffect(...)
	local effectWrap = self._entity:addGlobalEffect(...)

	self._internalEffects[effectWrap.uniqueId] = effectWrap

	return effectWrap
end

function FightEntitySpecialEffectBase:removeEffect(effectWrap)
	self._internalEffects[effectWrap.uniqueId] = nil

	self._entity.effect:removeEffect(effectWrap)
	FightRenderOrderMgr.instance:onRemoveEffectWrap(self._entity.id, effectWrap)
end

function FightEntitySpecialEffectBase:setEffectActive(state)
	if self._internalClass then
		for i, v in ipairs(self._internalClass) do
			if v.setEffectActive then
				v:setEffectActive(state)
			end
		end
	end

	if self._internalEffects then
		for i, v in pairs(self._internalEffects) do
			v:setActive(state, "FightEntitySpecialEffectBase")
		end
	end
end

function FightEntitySpecialEffectBase:releaseSelf()
	return
end

function FightEntitySpecialEffectBase:disposeSelf()
	for i, v in ipairs(self._internalClass) do
		v:disposeSelf()
	end

	for i, v in pairs(self._internalEffects) do
		self:removeEffect(v)
	end

	self:releaseSelf()

	self._internalClass = nil
	self._internalEffects = nil
	self._entity = nil

	self:__onDispose()
end

return FightEntitySpecialEffectBase
