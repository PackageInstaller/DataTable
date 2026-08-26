-- chunkname: @modules/logic/weekwalk_2/controller/WeekWalk_2Event.lua

module("modules.logic.weekwalk_2.controller.WeekWalk_2Event", package.seeall)

local WeekWalk_2Event = _M
local _get = GameUtil.getUniqueTb()

WeekWalk_2Event.OnGetInfo = _get()
WeekWalk_2Event.OnWeekwalkInfoUpdate = _get()
WeekWalk_2Event.OnWeekwalkInfoChange = _get()
WeekWalk_2Event.OnWeekwalkResetLayer = _get()
WeekWalk_2Event.OnBuffSelectedChange = _get()
WeekWalk_2Event.OnBuffSetup = _get()
WeekWalk_2Event.OnBuffSetupReply = _get()
WeekWalk_2Event.OnWeekwalkTaskUpdate = _get()
WeekWalk_2Event.OnGetTaskReward = _get()
WeekWalk_2Event.OnShowSkin = _get()

return WeekWalk_2Event
