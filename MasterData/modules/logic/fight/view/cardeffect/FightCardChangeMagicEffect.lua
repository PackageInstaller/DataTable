-- chunkname: @modules/logic/fight/view/cardeffect/FightCardChangeMagicEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardChangeMagicEffect", package.seeall)

local FightCardChangeMagicEffect = class("FightCardChangeMagicEffect", BaseWork)

function FightCardChangeMagicEffect:onStart(context)
	self:_playEffects()
end

function FightCardChangeMagicEffect:_playEffects()
	self:onDone(true)
end

function FightCardChangeMagicEffect:clearWork()
	return
end

return FightCardChangeMagicEffect
