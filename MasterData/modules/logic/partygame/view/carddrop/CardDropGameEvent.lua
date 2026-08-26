-- chunkname: @modules/logic/partygame/view/carddrop/CardDropGameEvent.lua

module("modules.logic.partygame.view.carddrop.CardDropGameEvent", package.seeall)

local CardDropGameEvent = _M
local _uid = 0

local function GetEventId()
	_uid = _uid + 1

	return _uid
end

CardDropGameEvent.OnSelectedCardChange = GetEventId()
CardDropGameEvent.OnLogicStateStart = GetEventId()
CardDropGameEvent.OnFloatDamage = GetEventId()

return CardDropGameEvent
