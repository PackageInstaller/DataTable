-- chunkname: @modules/logic/versionactivity2_4/dungeon/define/VersionActivity2_4DungeonEvent.lua

module("modules.logic.versionactivity2_4.dungeon.define.VersionActivity2_4DungeonEvent", package.seeall)

local VersionActivity2_4DungeonEvent = _M
local _get = GameUtil.getUniqueTb()

VersionActivity2_4DungeonEvent.OnMapPosChanged = _get()
VersionActivity2_4DungeonEvent.OnClickElement = _get()
VersionActivity2_4DungeonEvent.FocusElement = _get()
VersionActivity2_4DungeonEvent.OnHideInteractUI = _get()
VersionActivity2_4DungeonEvent.OnAddOneElement = _get()
VersionActivity2_4DungeonEvent.OnRemoveElement = _get()
VersionActivity2_4DungeonEvent.OnRecycleAllElement = _get()
VersionActivity2_4DungeonEvent.ManualClickElement = _get()
VersionActivity2_4DungeonEvent.GuideShowElement = _get()
VersionActivity2_4DungeonEvent.SudokuSelectItem = _get()
VersionActivity2_4DungeonEvent.SudokuSelectKeyboard = _get()
VersionActivity2_4DungeonEvent.DoSudokuCmd = _get()
VersionActivity2_4DungeonEvent.SudokuReset = _get()
VersionActivity2_4DungeonEvent.SudokuViewAni = _get()
VersionActivity2_4DungeonEvent.SudokuCompleted = _get()

return VersionActivity2_4DungeonEvent
