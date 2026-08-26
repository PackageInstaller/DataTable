-- chunkname: @modules/logic/versionactivity3_9/naxisuosi/define/NaxisuosiPipeEvent.lua

module("modules.logic.versionactivity3_9.naxisuosi.define.NaxisuosiPipeEvent", package.seeall)

local NaxisuosiPipeEvent = _M
local _get = GameUtil.getUniqueTb()

NaxisuosiPipeEvent.PipeGameClear = _get()
NaxisuosiPipeEvent.GuideClickGrid = _get()
NaxisuosiPipeEvent.ResetGameRefresh = _get()
NaxisuosiPipeEvent.ForceRefresh = _get()
NaxisuosiPipeEvent.GuideOpenGameView = _get()

return NaxisuosiPipeEvent
