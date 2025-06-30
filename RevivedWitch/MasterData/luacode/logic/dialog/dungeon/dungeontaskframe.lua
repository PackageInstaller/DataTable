-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeontaskframe.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonTaskFrame = class("DungeonTaskFrame", Dialog)
DungeonTaskFrame.AssetBundleName = "ui/layouts.dungeon"
DungeonTaskFrame.AssetName = "DungeonMenuTask1"
local TableFrame = require("framework.ui.frame.table.tableframe")
local tm = (NekoData.BehaviorManager).BM_Task
DungeonTaskFrame.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonTaskFrame
  ((DungeonTaskFrame.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

DungeonTaskFrame.OnCreate = function(self)
  -- function num : 0_1
  self._title = self:GetChild("Subtitle/Text")
  self._frame = self:GetChild("CellPanel")
  self._initialFrameAnchorX = (self._frame):GetHeight()
  self._initialAnchorX = (self:GetRootWindow()):GetHeight()
  self._anchoredX = (self._frame):GetAnchoredPosition()
end

DungeonTaskFrame.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._helper then
    (self._helper):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

DungeonTaskFrame.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : TableFrame, _ENV
  if not self._helper then
    self._helper = (TableFrame.Create)(self._frame, self, true, false, true)
    self._tasks = (self._cellData).data
    ;
    (self._helper):ReloadAllCell()
    ;
    (self._title):SetText((((BeanManager.GetTableByName)("mission.cmissiontypeconfig")):GetRecorder((self._cellData).id)).type)
    local length = (self._helper):GetTotalLength()
    ;
    (self._frame):SetHeight(self._initialFrameAnchorX, length)
    ;
    (self._frame):SetAnchoredPosition(self._anchoredX, self._anchoredY)
    ;
    (self:GetRootWindow()):SetHeight(self._initialAnchorX, self._initialOffsetX + (length - self._initialFrameOffsetX))
    ;
    (self._helper):ReloadAllCell()
  end
end

DungeonTaskFrame.NumberOfCell = function(self)
  -- function num : 0_4
  return #self._tasks
end

DungeonTaskFrame.CellAtIndex = function(self)
  -- function num : 0_5
  return "dungeon.dungeontaskcell"
end

DungeonTaskFrame.DataAtIndex = function(self, helper, index)
  -- function num : 0_6
  return (self._tasks)[index]
end

DungeonTaskFrame.ShouldLengthChange = function(self)
  -- function num : 0_7
  return true
end

DungeonTaskFrame.ShouldShowProgress = function(self)
  -- function num : 0_8
  if (self._cellData).progress == nil then
    return true
  end
  return (self._cellData).progress
end

return DungeonTaskFrame

