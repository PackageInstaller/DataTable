-- chunkname: @modules/logic/versionactivity2_5/dungeon/define/VersionActivity2_5DungeonEvent.lua

module("modules.logic.versionactivity2_5.dungeon.define.VersionActivity2_5DungeonEvent", package.seeall)

local VersionActivity2_5DungeonEvent = _M

VersionActivity2_5DungeonEvent.OnMapPosChanged = 1
VersionActivity2_5DungeonEvent.OnClickElement = 2
VersionActivity2_5DungeonEvent.FocusElement = 3
VersionActivity2_5DungeonEvent.OnHideInteractUI = 4
VersionActivity2_5DungeonEvent.OnAddOneElement = 5
VersionActivity2_5DungeonEvent.OnRemoveElement = 6
VersionActivity2_5DungeonEvent.OnRecycleAllElement = 7
VersionActivity2_5DungeonEvent.ManualClickElement = 8
VersionActivity2_5DungeonEvent.GuideShowElement = 9
VersionActivity2_5DungeonEvent.OnClickAllTaskFinish = 101

return VersionActivity2_5DungeonEvent
