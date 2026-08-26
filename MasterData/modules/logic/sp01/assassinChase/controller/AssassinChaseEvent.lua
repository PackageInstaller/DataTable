-- chunkname: @modules/logic/sp01/assassinChase/controller/AssassinChaseEvent.lua

module("modules.logic.sp01.assassinChase.controller.AssassinChaseEvent", package.seeall)

local AssassinChaseEvent = _M
local _get = GameUtil.getUniqueTb()

AssassinChaseEvent.OnInfoUpdate = _get()
AssassinChaseEvent.OnSelectDirection = _get()
AssassinChaseEvent.OnGetReward = _get()
AssassinChaseEvent.OnDialogueEnd = _get()

return AssassinChaseEvent
