-- chunkname: @modules/logic/versionactivity4_0/concertlimit/define/CandyRoomEvent.lua

module("modules.logic.versionactivity4_0.concertlimit.define.CandyRoomEvent", package.seeall)

local CandyRoomEvent = _M
local _get = GameUtil.getUniqueTb()

CandyRoomEvent.OnGetAct245Info = _get()
CandyRoomEvent.OnAct245Summon = _get()
CandyRoomEvent.OnSummonResultGet = _get()
CandyRoomEvent.OnShowSummonSelectFinished = _get()
CandyRoomEvent.OnShowSummonGetRewardFinished = _get()
CandyRoomEvent.OnRewardDetailShowFinished = _get()
CandyRoomEvent.OnShowSummonAnimFinished = _get()

return CandyRoomEvent
