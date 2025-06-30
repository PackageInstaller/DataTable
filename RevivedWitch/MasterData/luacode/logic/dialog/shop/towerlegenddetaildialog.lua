-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/towerlegenddetaildialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CEquipBox = (BeanManager.GetTableByName)("recharge.cequipbox")
local TowerLegendDetailDialog = class("TowerLegendDetailDialog", Dialog)
TowerLegendDetailDialog.AssetBundleName = "ui/layouts.baseshop"
TowerLegendDetailDialog.AssetName = "TowerLegendDetail"
TowerLegendDetailDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerLegendDetailDialog
  ((TowerLegendDetailDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._data = {}
end

TowerLegendDetailDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._panel = self:GetChild("Announcement/Frame")
  self._backBtn = self:GetChild("Announcement/CloseBtn")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

TowerLegendDetailDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

TowerLegendDetailDialog.SetData = function(self, boxId)
  -- function num : 0_3 , upvalues : CEquipBox
  local recorder = CEquipBox:GetRecorder(boxId)
  self._data = recorder.EquipShowID
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

TowerLegendDetailDialog.OnBackBtnClicked = function(self, args)
  -- function num : 0_4
  self:Destroy()
end

TowerLegendDetailDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._data
end

TowerLegendDetailDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "shop.towerlegenddetailcell"
end

TowerLegendDetailDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._data)[index]
end

TowerLegendDetailDialog.ShouldLengthChange = function(self)
  -- function num : 0_8
  return true
end

return TowerLegendDetailDialog

