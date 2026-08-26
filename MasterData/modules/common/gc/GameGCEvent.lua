-- chunkname: @modules/common/gc/GameGCEvent.lua

module("modules.common.gc.GameGCEvent", package.seeall)

local GameGCEvent = {}

GameGCEvent.FullGC = 1
GameGCEvent.DelayFullGC = 2
GameGCEvent.ResGC = 3
GameGCEvent.CancelDelayFullGC = 4
GameGCEvent.StoryGC = 5
GameGCEvent.AudioGC = 6
GameGCEvent.DelayAudioGC = 7
GameGCEvent.CancelDelayAudioGC = 8
GameGCEvent.OnFullGC = 11
GameGCEvent.SetBanGc = 21

return GameGCEvent
