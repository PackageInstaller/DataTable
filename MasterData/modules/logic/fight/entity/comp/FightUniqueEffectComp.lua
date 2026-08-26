-- chunkname: @modules/logic/fight/entity/comp/FightUniqueEffectComp.lua

module("modules.logic.fight.entity.comp.FightUniqueEffectComp", package.seeall)

local FightUniqueEffectComp = class("FightUniqueEffectComp", FightBaseClass)

function FightUniqueEffectComp:onConstructor(entity)
	self.entity = entity
	self.entityId = self.entity.id
	self.existEffectWrapDict = {}
end

function FightUniqueEffectComp:onDestructor()
	for effectName, _ in pairs(self.existEffectWrapDict) do
		self:removeEffect(effectName)
	end
end

function FightUniqueEffectComp:addHangEffect(effectName, hangPoint, side, releaseTime)
	local effectWrap = self.existEffectWrapDict[effectName]

	if effectWrap then
		return effectWrap
	end

	effectWrap = self.entity.effect:addHangEffect(effectName, hangPoint, side)

	FightRenderOrderMgr.instance:onAddEffectWrap(self.entityId, effectWrap)

	self.existEffectWrapDict[effectName] = effectWrap

	if releaseTime then
		self:com_registTimer(self.removeEffect, releaseTime, effectName)
	end

	return effectWrap
end

function FightUniqueEffectComp:addGlobalEffect(effectName, side, releaseTime)
	if self.existEffectWrapDict[effectName] then
		return
	end

	local effectWrap = self.entity.effect:addGlobalEffect(effectName, side)

	FightRenderOrderMgr.instance:onAddEffectWrap(self.entityId, effectWrap)

	self.existEffectWrapDict[effectName] = effectWrap

	if releaseTime then
		self:com_registTimer(self.removeEffect, releaseTime, effectName)
	end

	return effectWrap
end

function FightUniqueEffectComp:removeEffect(effectName)
	local effectWrap = self.existEffectWrapDict[effectName]

	if not effectWrap then
		return
	end

	self.existEffectWrapDict[effectName] = nil

	FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entityId, effectWrap)
	self.entity.effect:removeEffect(effectWrap)
end

return FightUniqueEffectComp
