-- chunkname: @modules/versionactivitybase/fixed/dungeon/define/VersionActivityFixedDungeonEvent.lua

module("modules.versionactivitybase.fixed.dungeon.define.VersionActivityFixedDungeonEvent", package.seeall)

local VersionActivityFixedDungeonEvent = _M

VersionActivityFixedDungeonEvent.OnMapPosChanged = 1
VersionActivityFixedDungeonEvent.OnClickElement = 2
VersionActivityFixedDungeonEvent.FocusElement = 3
VersionActivityFixedDungeonEvent.OnHideInteractUI = 4
VersionActivityFixedDungeonEvent.OnAddOneElement = 5
VersionActivityFixedDungeonEvent.OnRemoveElement = 6
VersionActivityFixedDungeonEvent.OnRecycleAllElement = 7
VersionActivityFixedDungeonEvent.ManualClickElement = 8
VersionActivityFixedDungeonEvent.GuideShowElement = 9
VersionActivityFixedDungeonEvent.OnClickAllTaskFinish = 101
VersionActivityFixedDungeonEvent.SwitchBGM = 2701
VersionActivityFixedDungeonEvent.OpenFinishMapLevelView = 2702

return VersionActivityFixedDungeonEvent
