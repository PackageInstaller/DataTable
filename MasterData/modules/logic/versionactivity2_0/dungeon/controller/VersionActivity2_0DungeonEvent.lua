-- chunkname: @modules/logic/versionactivity2_0/dungeon/controller/VersionActivity2_0DungeonEvent.lua

module("modules.logic.versionactivity2_0.dungeon.controller.VersionActivity2_0DungeonEvent", package.seeall)

local VersionActivity2_0DungeonEvent = _M

VersionActivity2_0DungeonEvent.OnMapPosChanged = 1
VersionActivity2_0DungeonEvent.OnClickElement = 2
VersionActivity2_0DungeonEvent.FocusElement = 3
VersionActivity2_0DungeonEvent.OnHideInteractUI = 4
VersionActivity2_0DungeonEvent.OnAddOneElement = 5
VersionActivity2_0DungeonEvent.OnRemoveElement = 6
VersionActivity2_0DungeonEvent.OnRecycleAllElement = 7
VersionActivity2_0DungeonEvent.ManualClickElement = 8

return VersionActivity2_0DungeonEvent
