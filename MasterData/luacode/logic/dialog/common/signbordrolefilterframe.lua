-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/common/signbordrolefilterframe.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local SignBordRoleFilterFrame = class("SignBordRoleFilterFrame", Dialog)
SignBordRoleFilterFrame.AssetBundleName = "ui/layouts.signboard"
SignBordRoleFilterFrame.AssetName = "SignboardMainFliterCell"
SignBordRoleFilterFrame.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SignBordRoleFilterFrame
  ((SignBordRoleFilterFrame.super).Ctor)(self, ...)
end

SignBordRoleFilterFrame.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._panel = self:GetRootWindow()
  self._field = self:GetChild("Frame")
  self._title = self:GetChild("Txt")
  self._frame = (GridFrame.Create)(self._field, self, true, 5, false)
  self._x = (self._field):GetSize()
  self._pos_x = (self._field):GetPosition()
  self._title_pos_x = (self._title):GetPosition()
  self._rootX = (self:GetRootWindow()):GetSize()
end

SignBordRoleFilterFrame.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

SignBordRoleFilterFrame.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._frame):ReloadAllCell()
  if not data.target or data.target == "Role" or data.target == "Equip" or data.target == "Monster" or data.target == "EquipBook" or data.target == "EquipChange" or data.target == "SignBordRole" then
    (self._title):SetActive(true)
    ;
    (self._title):SetText((TextManager.GetText)(data.TypeNameId))
  else
    ;
    (self._title):SetActive(false)
  end
  local totallength = (self._frame):GetTotalLength()
  local delta = totallength - self._oy
  ;
  (self._field):SetSize(self._x, self._ox, self._y, self._oy + delta)
  ;
  (self._field):SetPosition(self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y - delta / 2)
  ;
  (self._title):SetPosition(self._title_pos_x, self._title_pos_offset_x, self._title_pos_y, self._title_pos_offset_y + delta / 2)
  ;
  (self:GetRootWindow()):SetSize(self._rootX, self._rootOX, self._rooty, self._rootOY + delta)
  ;
  (self._frame):ReloadAllCell()
end

SignBordRoleFilterFrame.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #(self._cellData).list
end

SignBordRoleFilterFrame.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "common.filterframecell"
end

SignBordRoleFilterFrame.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return ((self._cellData).list)[index]
end

SignBordRoleFilterFrame.OnEvent = function(self, eventName, arg)
  -- function num : 0_7
  if eventName == "ChangeSelectNameId" then
    (self._frame):FireEvent("ChangeSelectNameId")
  end
end

return SignBordRoleFilterFrame

