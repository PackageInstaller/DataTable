-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/effect/DiceHeroBaseEffectWork.lua

module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroBaseEffectWork", package.seeall)

local DiceHeroBaseEffectWork = class("DiceHeroBaseEffectWork", BaseWork)

function DiceHeroBaseEffectWork:ctor(effectMo)
	self._effectMo = effectMo
end

function DiceHeroBaseEffectWork:onStart(context)
	self:onDone(true)
end

return DiceHeroBaseEffectWork
