-- chunkname: @modules/logic/versionactivity4_0/concertlimit/define/MusicGameEvent.lua

module("modules.logic.versionactivity4_0.concertlimit.define.MusicGameEvent", package.seeall)

local MusicGameEvent = _M
local _get = GameUtil.getUniqueTb()

MusicGameEvent.BlockItemConnect = _get()
MusicGameEvent.CancelGame = _get()
MusicGameEvent.BlockLongPress = _get()
MusicGameEvent.BlockPressEnd = _get()

return MusicGameEvent
