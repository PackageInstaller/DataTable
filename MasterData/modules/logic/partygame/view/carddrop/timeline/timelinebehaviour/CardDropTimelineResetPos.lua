-- chunkname: @modules/logic/partygame/view/carddrop/timeline/timelinebehaviour/CardDropTimelineResetPos.lua

module("modules.logic.partygame.view.carddrop.timeline.timelinebehaviour.CardDropTimelineResetPos", package.seeall)

local CardDropTimelineResetPos = class("CardDropTimelineResetPos", CardDropTimelineBehaviourBase)

function CardDropTimelineResetPos:getType()
	return CardDropBehaviourType.Type.ResetPos
end

function CardDropTimelineResetPos:onBehaviourStart(type, id, duration, paramStr)
	CardDropTimelineResetPos.super.onBehaviourStart(self, type, id, duration, paramStr)

	local param1 = CardDropGameTimelineHelper.getIntParam(paramStr[1])
	local entity = self:getEntity(param1)
	local uid = entity:getUid()
	local posX, posY, posZ = self.interface.GetCharacterShowPos(uid, nil, nil, nil)

	self:clearTween()

	self.tweenId = ZProj.TweenHelper.DOMove(entity:getContainerTransform(), posX, posY, posZ, duration)
end

function CardDropTimelineResetPos:clearTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function CardDropTimelineResetPos:onBehaviourEnd()
	self:clearTween()
end

return CardDropTimelineResetPos
