-- chunkname: @modules/logic/versionactivity2_3/dungeon/define/VersionActivity2_3DungeonEvent.lua

module("modules.logic.versionactivity2_3.dungeon.define.VersionActivity2_3DungeonEvent", package.seeall)

local VersionActivity2_3DungeonEvent = _M

VersionActivity2_3DungeonEvent.OnMapPosChanged = 1
VersionActivity2_3DungeonEvent.OnClickElement = 2
VersionActivity2_3DungeonEvent.FocusElement = 3
VersionActivity2_3DungeonEvent.OnHideInteractUI = 4
VersionActivity2_3DungeonEvent.OnAddOneElement = 5
VersionActivity2_3DungeonEvent.OnRemoveElement = 6
VersionActivity2_3DungeonEvent.OnRecycleAllElement = 7
VersionActivity2_3DungeonEvent.ManualClickElement = 8
VersionActivity2_3DungeonEvent.GuideShowElement = 9
VersionActivity2_3DungeonEvent.OnClickAllTaskFinish = 101

return VersionActivity2_3DungeonEvent
