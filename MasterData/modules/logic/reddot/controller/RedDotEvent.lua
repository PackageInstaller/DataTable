-- chunkname: @modules/logic/reddot/controller/RedDotEvent.lua

module("modules.logic.reddot.controller.RedDotEvent", package.seeall)

local RedDotEvent = _M

RedDotEvent.RefreshClientCharacterDot = 1
RedDotEvent.UpdateFriendInfoDot = 2
RedDotEvent.UpdateRelateDotInfo = 3
RedDotEvent.UpdateActTag = 4
RedDotEvent.PreSetRedDot = 5

return RedDotEvent
