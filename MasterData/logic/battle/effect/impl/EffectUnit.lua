-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/effect/impl/EffectUnit.lua

module("logic.battle.effect.impl.EffectUnit", package.seeall)

local EffectUnit = class("EffectUnit", EffectUnitBase)

function EffectUnit:_initComponents()
	self:_addComponent("main", EffectCompMain)
	self:_addComponent("loader", EffectCompLoader)
	self:_addComponent("transform", EffectCompTransform)
	self:_addComponent("lifeTime", EffectCompLifeTime)
	self:_addComponent("audio", EffectCompAudio)
end

return EffectUnit
