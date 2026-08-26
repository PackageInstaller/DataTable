-- chunkname: @modules/versionactivitybase/dungeon/define/VersionActivityDungeonEvent.lua

module("modules.versionactivitybase.dungeon.define.VersionActivityDungeonEvent", package.seeall)

local VersionActivityDungeonEvent = _M

VersionActivityDungeonEvent.OnModeChange = 1
VersionActivityDungeonEvent.OnHardUnlockAnimDone = 2
VersionActivityDungeonEvent.OnActivityDungeonMoChange = 3

return VersionActivityDungeonEvent
