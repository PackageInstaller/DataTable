-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/equipbookworddescribeframe.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local EquipBookWordDescribeFrame = class("EquipBookWordDescribeFrame", Dialog)
EquipBookWordDescribeFrame.AssetBundleName = "ui/layouts.tujian"
EquipBookWordDescribeFrame.AssetName = "EquipBookRandomPropertyFrame"
EquipBookWordDescribeFrame.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipBookWordDescribeFrame
  ((EquipBookWordDescribeFrame.super).Ctor)(self, ...)
  self._data = {}
end

EquipBookWordDescribeFrame.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._panel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, false)
end

EquipBookWordDescribeFrame.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

EquipBookWordDescribeFrame.RefreshCell = function(self, data)
  -- function num : 0_3
  self._data = data.value
  ;
  (self._frame):ReloadAllCell()
end

EquipBookWordDescribeFrame.NumberOfCell = function(self, frame, index)
  -- function num : 0_4
  return #self._data
end

EquipBookWordDescribeFrame.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "handbook.equipbookworddescribecell"
end

EquipBookWordDescribeFrame.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

return EquipBookWordDescribeFrame

