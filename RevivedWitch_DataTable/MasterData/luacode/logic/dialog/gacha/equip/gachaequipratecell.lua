-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/equip/gachaequipratecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CEquipCardPoolDetails = (BeanManager.GetTableByName)("item.cequipcardpooldetails")
local GachaEquipRateCell = class("GachaEquipRateCell", Dialog)
GachaEquipRateCell.AssetBundleName = "ui/layouts.baseshop"
GachaEquipRateCell.AssetName = "TowerLegendDetailCell"
GachaEquipRateCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaEquipRateCell
  ((GachaEquipRateCell.super).Ctor)(self, ...)
  self._data = {}
end

GachaEquipRateCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._back = self:GetChild("Panel")
  self._panel = self:GetChild("Panel/Frame")
  self._title = self:GetChild("Panel/Title")
  self._totalRate = self:GetChild("Panel/TotalRate")
  self._panel_scaleX = (self._panel):GetLocalScale()
  self._frame = (GridFrame.Create)(self._panel, self, true, 8, false)
  self._x = (self._panel):GetSize()
  self._pos_x = (self._panel):GetPosition()
  self._back_x = (self._back):GetSize()
  self._back_pos_x = (self._back):GetPosition()
  self._rootX = (self:GetRootWindow()):GetSize()
end

GachaEquipRateCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

GachaEquipRateCell.RefreshCell = function(self, equipShowId)
  -- function num : 0_3 , upvalues : CEquipCardPoolDetails, _ENV
  local recorder = CEquipCardPoolDetails:GetRecorder(equipShowId)
  ;
  (self._title):SetText((TextManager.GetText)(recorder.TypeName))
  ;
  (self._totalRate):SetText((TextManager.GetText)(recorder.WeightText))
  self._data = recorder.Equip
  ;
  (self._frame):ReloadAllCell()
  local totallength = (self._frame):GetTotalLength()
  local delta = totallength - self._oy
  ;
  (self._back):SetSize(self._back_x, self._back_ox, self._back_y, self._back_oy + delta * self._panel_scaleY)
  ;
  (self._back):SetPosition(self._back_pos_x, self._back_pos_offset_x, self._back_pos_y, self._back_pos_offset_y - delta / 2 * self._panel_scaleY)
  ;
  (self._panel):SetSize(self._x, self._ox, self._y, totallength)
  ;
  (self._panel):SetPosition(self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y - delta / 2)
  ;
  (self:GetRootWindow()):SetSize(self._rootX, self._rootOX, self._rooty, self._rootOY + delta * self._panel_scaleY)
  ;
  (self._frame):ReloadAllCell()
end

GachaEquipRateCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

GachaEquipRateCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "gacha.equip.gachaequiprateitemcell"
end

GachaEquipRateCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

return GachaEquipRateCell

