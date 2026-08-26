-- chunkname: @modules/logic/globalvote/controller/GlobalVoteEvent.lua

module("modules.logic.globalvote.controller.GlobalVoteEvent", package.seeall)

local GlobalVoteEvent = _M
local make = GameUtil.getUniqueTb()

GlobalVoteEvent.onReceiveGlobalVoteGetInfoReply = make()

return GlobalVoteEvent
