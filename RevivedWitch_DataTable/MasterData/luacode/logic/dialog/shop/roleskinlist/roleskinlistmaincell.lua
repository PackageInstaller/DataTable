-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/roleskinlist/roleskinlistmaincell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local UIManager = ((CS.PixelNeko).UI).UIManager
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local RoleSkinListMainCell = class("RoleSkinListMainCell", Dialog)
RoleSkinListMainCell.AssetBundleName = "ui/layouts.baseshop"
RoleSkinListMainCell.AssetName = "FashionShopListCell"
RoleSkinListMainCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleSkinListMainCell
  ((RoleSkinListMainCell.super).Ctor)(self, ...)
  self._cellNum = 5
end

RoleSkinListMainCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : UIManager, _ENV
  self._panel = self:GetChild("ClothesFrame")
  self._yearText = self:GetChild("Year/YearText")
  local ratio = (UIManager.GetScreenWHRatio)()
  if ratio > 2 then
    local wAnchor, wWidth = (self._panel):GetWidth()
    local px, pox, py, poy = (self._panel):GetPosition()
    local cellDialog = (DialogManager.CreateDialog)("shop.roleskinlist.roleskinlistmaincellcell", nil)
    local rootWindow = cellDialog:GetRootWindow()
    local cellWidth = rootWindow:GetRectSize()
    cellDialog:RootWindowDestroy()
    ;
    (self._panel):SetWidth(wAnchor, wWidth + cellWidth)
    ;
    (self._panel):SetPosition(px, pox - cellWidth / 2, py, poy)
    local wAnchor, wWidth = (self:GetRootWindow()):GetWidth()
    local px, pox, py, poy = (self:GetRootWindow()):GetPosition()
    ;
    (self:GetRootWindow()):SetWidth(wAnchor, wWidth + cellWidth)
    self._cellNum = 6
  end
  do
    self._w = (self._panel):GetRectSize()
    self._main_anchorMinX = (self._panel):GetAnchorAndOffset()
    self._panel_x = (self._panel):GetSize()
    self._rootsize_x = (self:GetRootWindow()):GetSize()
  end
end

RoleSkinListMainCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

RoleSkinListMainCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, GridFrame
  self._data = data
  ;
  (self._yearText):SetText((self._data).title)
  local line = (math.ceil)(#(self._data).skinlist / self._cellNum) - 1
  if self._frame then
    (self._frame):Destroy()
  end
  local delta = line * self._oneline
  ;
  (self._panel):SetAnchorAndOffset(self._main_anchorMinX, self._main_anchorMinY, self._main_anchorMaxX, self._main_anchorMaxY, self._main_offsetMinX, self._main_offsetMinY - delta, self._main_offsetMaxX, self._main_offsetMaxY)
  ;
  (self:GetRootWindow()):SetSize(self._rootsize_x, self._rootsize_offset_x, self._rootsize_y, self._rootsize_offset_y + delta)
  self._frame = (GridFrame.Create)(self._panel, self, true, self._cellNum, false)
  ;
  (self._frame):ReloadAllCell()
end

RoleSkinListMainCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #(self._data).skinlist
end

RoleSkinListMainCell.CellAtIndex = function(self, frame)
  -- function num : 0_5
  return "shop.roleskinlist.roleskinlistmaincellcell"
end

RoleSkinListMainCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return ((self._data).skinlist)[index]
end

RoleSkinListMainCell.OnEvent = function(self, name, args)
  -- function num : 0_7
  if name == "UnLock" then
    (self._frame):FireEvent("UnLock", args)
  end
end

return RoleSkinListMainCell

