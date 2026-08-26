-- chunkname: @modules/logic/partygame/view/carddrop/timeline/timelinebehaviour/CardDropTimelineAddGlobalEffect.lua

module("modules.logic.partygame.view.carddrop.timeline.timelinebehaviour.CardDropTimelineAddGlobalEffect", package.seeall)

local CardDropTimelineAddGlobalEffect = class("CardDropTimelineAddGlobalEffect", CardDropTimelineBehaviourBase)

function CardDropTimelineAddGlobalEffect:getType()
	return CardDropBehaviourType.Type.AddGlobalEffect
end

function CardDropTimelineAddGlobalEffect:onBehaviourStart(type, id, duration, paramStr)
	CardDropTimelineAddGlobalEffect.super.onBehaviourStart(self, type, id, duration, paramStr)

	local resName = paramStr[1]
	local posX, posY, posZ = CardDropGameTimelineHelper.getPosParam(paramStr[2])
	local attackEntity = self:getEntity(CardDropEnum.AttackSide.Attacker)

	self.effectWrap = self.entity.effect:addGlobalEffect(resName, posX, posY, posZ, attackEntity:getSide())
end

function CardDropTimelineAddGlobalEffect:onTimelineEnd()
	self.entity.effect:removeGlobalEffect(self.effectWrap)

	self.effectWrap = nil
end

return CardDropTimelineAddGlobalEffect
