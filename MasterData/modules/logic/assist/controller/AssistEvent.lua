-- chunkname: @modules/logic/assist/controller/AssistEvent.lua

module("modules.logic.assist.controller.AssistEvent", package.seeall)

local AssistEvent = _M
local _get = GameUtil.getUniqueTb()

AssistEvent.UpdateBadgeInfo = _get()
AssistEvent.UpdateWearBadges = _get()
AssistEvent.CloseAddFriendView = _get()
AssistEvent.UpdateNewTag = _get()

return AssistEvent
