-- chunkname: @modules/logic/sp02/atomic/define/AtomicEvent.lua

module("modules.logic.sp02.atomic.define.AtomicEvent", package.seeall)

local AtomicEvent = _M
local _get = GameUtil.getUniqueTb()

AtomicEvent.TalentUpdate = _get()
AtomicEvent.TalentBranchChange = _get()
AtomicEvent.DataBaseUpdate = _get()
AtomicEvent.DailyRefresh = _get()
AtomicEvent.DataBaseInfoUpdate = _get()
AtomicEvent.DataBaseShowLocked = _get()
AtomicEvent.DataBaseTabChange = _get()
AtomicEvent.AvgPlayUpdate = _get()

return AtomicEvent
