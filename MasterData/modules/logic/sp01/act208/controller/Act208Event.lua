-- chunkname: @modules/logic/sp01/act208/controller/Act208Event.lua

module("modules.logic.sp01.act208.controller.Act208Event", package.seeall)

local Act208Event = _M
local _get = GameUtil.getUniqueTb()

Act208Event.onGetInfo = _get()
Act208Event.onGetBonus = _get()

return Act208Event
