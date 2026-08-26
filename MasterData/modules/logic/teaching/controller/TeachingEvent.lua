-- chunkname: @modules/logic/teaching/controller/TeachingEvent.lua

module("modules.logic.teaching.controller.TeachingEvent", package.seeall)

local TeachingEvent = _M
local _get = GameUtil.getUniqueTb()

TeachingEvent.OnTeachingInfoUpdate = _get()
TeachingEvent.OnTeachingBonusUpdate = _get()
TeachingEvent.OnSelectTeachingId = _get()

return TeachingEvent
