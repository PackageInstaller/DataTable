-- chunkname: @modules/logic/partygame/view/carddrop/timeline/timelinebehaviour/CardDropTimelinePlayAction.lua

module("modules.logic.partygame.view.carddrop.timeline.timelinebehaviour.CardDropTimelinePlayAction", package.seeall)

local CardDropTimelinePlayAction = class("CardDropTimelinePlayAction", CardDropTimelineBehaviourBase)

function CardDropTimelinePlayAction:getType()
	return CardDropBehaviourType.Type.PlayAction
end

function CardDropTimelinePlayAction:onBehaviourStart(type, id, duration, paramStr)
	CardDropTimelinePlayAction.super.onBehaviourStart(self, type, id, duration, paramStr)

	local param1 = CardDropGameTimelineHelper.getIntParam(paramStr[1])
	local actionName = paramStr[2]
	local entity = self:getEntity(param1)

	entity:playAnim(actionName)
end

return CardDropTimelinePlayAction
