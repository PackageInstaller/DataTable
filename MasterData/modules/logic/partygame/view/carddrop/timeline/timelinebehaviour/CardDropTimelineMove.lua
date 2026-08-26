-- chunkname: @modules/logic/partygame/view/carddrop/timeline/timelinebehaviour/CardDropTimelineMove.lua

module("modules.logic.partygame.view.carddrop.timeline.timelinebehaviour.CardDropTimelineMove", package.seeall)

local CardDropTimelineMove = class("CardDropTimelineMove", CardDropTimelineBehaviourBase)

function CardDropTimelineMove:getType()
	return CardDropBehaviourType.Type.Move
end

function CardDropTimelineMove:onBehaviourStart(type, id, duration, paramStr)
	CardDropTimelineMove.super.onBehaviourStart(self, type, id, duration, paramStr)

	local param1 = CardDropGameTimelineHelper.getIntParam(paramStr[1])
	local posX, posY, posZ = CardDropGameTimelineHelper.getPosParam(paramStr[2])
	local entity = self:getEntity(param1)

	self:clearTween()

	local entityUid = self.entity.uid
	local isMySide = self.interface.GetMyPlayerUid() == entityUid

	self.tweenId = ZProj.TweenHelper.DOMove(entity:getContainerTransform(), isMySide and posX or -posX, posY, posZ, duration)
end

function CardDropTimelineMove:clearTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function CardDropTimelineMove:onBehaviourEnd()
	self:clearTween()
end

return CardDropTimelineMove
