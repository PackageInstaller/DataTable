-- chunkname: @modules/logic/versionactivity2_4/act181/controller/Activity181Event.lua

module("modules.logic.versionactivity2_4.act181.controller.Activity181Event", package.seeall)

local Activity181Event = _M
local _get = GameUtil.getUniqueTb()

Activity181Event.OnGetInfo = _get()
Activity181Event.OnGetBonus = _get()
Activity181Event.OnGetSPBonus = _get()
Activity181Event.BonusTimesChange = _get()

return Activity181Event
