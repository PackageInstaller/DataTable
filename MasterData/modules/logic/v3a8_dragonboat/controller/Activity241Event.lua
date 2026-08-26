-- chunkname: @modules/logic/v3a8_dragonboat/controller/Activity241Event.lua

module("modules.logic.v3a8_dragonboat.controller.Activity241Event", package.seeall)

local Activity241Event = _M
local make = GameUtil.getUniqueTb()

Activity241Event.onReceiveAct241GetInfoReply = make()
Activity241Event.onReceiveAct241VoteReply = make()
Activity241Event.onReceiveAct241GetBonusReply = make()

return Activity241Event
