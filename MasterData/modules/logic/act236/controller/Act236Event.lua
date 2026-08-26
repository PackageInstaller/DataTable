-- chunkname: @modules/logic/act236/controller/Act236Event.lua

module("modules.logic.act236.controller.Act236Event", package.seeall)

local Act236Event = _M
local _get = GameUtil.getUniqueTb()

Act236Event.OnInfoUpdate = _get()
Act236Event.OnGainReward = _get()

return Act236Event
