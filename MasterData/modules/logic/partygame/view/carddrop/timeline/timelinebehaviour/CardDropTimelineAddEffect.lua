-- chunkname: @modules/logic/partygame/view/carddrop/timeline/timelinebehaviour/CardDropTimelineAddEffect.lua

module("modules.logic.partygame.view.carddrop.timeline.timelinebehaviour.CardDropTimelineAddEffect", package.seeall)

local CardDropTimelineAddEffect = class("CardDropTimelineAddEffect", CardDropTimelineBehaviourBase)

function CardDropTimelineAddEffect:getType()
	return CardDropBehaviourType.Type.AddEffect
end

function CardDropTimelineAddEffect:onBehaviourStart(type, id, duration, paramStr)
	CardDropTimelineAddEffect.super.onBehaviourStart(self, type, id, duration, paramStr)

	local resName = paramStr[1]
	local attackSide = CardDropGameTimelineHelper.getIntParam(paramStr[2])
	local posX, posY, posZ = CardDropGameTimelineHelper.getPosParam(paramStr[3])
	local entity = self:getEntity(attackSide)
	local attackEntity = self:getEntity(CardDropEnum.AttackSide.Attacker)
	local isMySide = entity:getSide() == CardDropEnum.Side.My

	self.effectWrap = entity.effect:addLocalEffect(resName, isMySide and posX or -posX, posY, posZ, attackEntity:getSide())
	self.effectEntity = entity
end

function CardDropTimelineAddEffect:onTimelineEnd()
	self.effectEntity.effect:removeLocalEffect(self.effectWrap)

	self.effectEntity = nil
	self.effectWrap = nil
end

return CardDropTimelineAddEffect
