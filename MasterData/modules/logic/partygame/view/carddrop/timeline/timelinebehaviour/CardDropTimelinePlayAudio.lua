-- chunkname: @modules/logic/partygame/view/carddrop/timeline/timelinebehaviour/CardDropTimelinePlayAudio.lua

module("modules.logic.partygame.view.carddrop.timeline.timelinebehaviour.CardDropTimelinePlayAudio", package.seeall)

local CardDropTimelinePlayAudio = class("CardDropTimelinePlayAudio", CardDropTimelineBehaviourBase)

function CardDropTimelinePlayAudio:getType()
	return CardDropBehaviourType.Type.PlayAudio
end

function CardDropTimelinePlayAudio:onBehaviourStart(type, id, duration, paramStr)
	CardDropTimelinePlayAudio.super.onBehaviourStart(self, type, id, duration, paramStr)

	local audioId = tonumber(paramStr[1])

	if audioId and audioId > 0 then
		AudioMgr.instance:trigger(audioId)
	end
end

return CardDropTimelinePlayAudio
