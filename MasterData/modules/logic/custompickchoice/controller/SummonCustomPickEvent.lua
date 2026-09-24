-- chunkname: @modules/logic/custompickchoice/controller/SummonCustomPickEvent.lua

module("modules.logic.custompickchoice.controller.SummonCustomPickEvent", package.seeall)

local SummonCustomPickEvent = _M

SummonCustomPickEvent.OnGetServerInfoReply = 1
SummonCustomPickEvent.OnGetReward = 2
SummonCustomPickEvent.OnSummonCustomGet = 3
SummonCustomPickEvent.OnCustomPickListChanged = 4

return SummonCustomPickEvent
