-- chunkname: @modules/logic/versionactivity2_1/dungeon/controller/VersionActivity2_1DungeonEvent.lua

module("modules.logic.versionactivity2_1.dungeon.controller.VersionActivity2_1DungeonEvent", package.seeall)

local VersionActivity2_1DungeonEvent = _M

VersionActivity2_1DungeonEvent.OnMapPosChanged = 1
VersionActivity2_1DungeonEvent.OnClickElement = 2
VersionActivity2_1DungeonEvent.FocusElement = 3
VersionActivity2_1DungeonEvent.OnHideInteractUI = 4
VersionActivity2_1DungeonEvent.OnAddOneElement = 5
VersionActivity2_1DungeonEvent.OnRemoveElement = 6
VersionActivity2_1DungeonEvent.OnRecycleAllElement = 7
VersionActivity2_1DungeonEvent.ManualClickElement = 8
VersionActivity2_1DungeonEvent.GuideShowElement = 9
VersionActivity2_1DungeonEvent.OnClickAllTaskFinish = 101

return VersionActivity2_1DungeonEvent
