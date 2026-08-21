-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/effect/impl/EffectLineBullet.lua

module("logic.battle.effect.impl.EffectLineBullet", package.seeall)

local EffectLineBullet = class("EffectLineBullet", EffectUnitBase)

function EffectLineBullet:_initComponents()
	self:_addComponent("loader", EffectCompLoader)
	self:_addComponent("transform", EffectCompTransform)
	self:_addComponent("mover", EffectCompLineMover)
	self:_addComponent("audio", EffectCompAudio)
end

return EffectLineBullet
