-- chunkname: @modules/logic/partygame/view/carddrop/timeline/CardDropBehaviourType.lua

module("modules.logic.partygame.view.carddrop.timeline.CardDropBehaviourType", package.seeall)

local CardDropBehaviourType = _M
local typeIndex = -1

local function GetTypeId()
	typeIndex = typeIndex + 1

	return typeIndex
end

CardDropBehaviourType.Type = {
	Move = GetTypeId(),
	ResetPos = GetTypeId(),
	PlayAction = GetTypeId(),
	AddEffect = GetTypeId(),
	AddGlobalEffect = GetTypeId(),
	PlayAudio = GetTypeId()
}

return CardDropBehaviourType
