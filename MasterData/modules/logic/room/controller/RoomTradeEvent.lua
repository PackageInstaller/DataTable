-- chunkname: @modules/logic/room/controller/RoomTradeEvent.lua

module("modules.logic.room.controller.RoomTradeEvent", package.seeall)

local RoomTradeEvent = _M

RoomTradeEvent.OnGetTradeOrderInfo = 101
RoomTradeEvent.OnFinishOrder = 102
RoomTradeEvent.OnRefreshDailyOrder = 103
RoomTradeEvent.OnTracedDailyOrder = 104
RoomTradeEvent.PlayCloseTVAnim = 105
RoomTradeEvent.OnLockedDailyOrder = 106
RoomTradeEvent.OnCutOrderPage = 110
RoomTradeEvent.OnFlyCurrency = 120
RoomTradeEvent.OnGetTradeTaskInfo = 201
RoomTradeEvent.OnReadNewTradeTaskReply = 202
RoomTradeEvent.OnGetTradeSupportBonusReply = 203
RoomTradeEvent.OnTradeLevelUpReply = 204
RoomTradeEvent.OnGetTradeTaskExtraBonusReply = 205

return RoomTradeEvent
