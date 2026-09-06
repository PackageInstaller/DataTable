local GridFrame = require("framework.ui.frame.grid.gridframe")
local CEquipCardPoolDetails = BeanManager.GetTableByName("item.cequipcardpooldetails")
local GachaEquipRateCell = class("GachaEquipRateCell", Dialog)
GachaEquipRateCell.AssetBundleName = "ui/layouts.baseshop"
GachaEquipRateCell.AssetName = "TowerLegendDetailCell"

function GachaEquipRateCell:Ctor(...)
  GachaEquipRateCell.super.Ctor(self, ...)
  self._data = {}
end

function GachaEquipRateCell:OnCreate()
  self._back = self:GetChild("Panel")
  self._panel = self:GetChild("Panel/Frame")
  self._title = self:GetChild("Panel/Title")
  self._totalRate = self:GetChild("Panel/TotalRate")
  self._panel_scaleX, self._panel_scaleY, self._panel_scaleZ = self._panel:GetLocalScale()
  self._frame = GridFrame.Create(self._panel, self, true, 8, false)
  self._x, self._ox, self._y, self._oy = self._panel:GetSize()
  self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y = self._panel:GetPosition()
  self._back_x, self._back_ox, self._back_y, self._back_oy = self._back:GetSize()
  self._back_pos_x, self._back_pos_offset_x, self._back_pos_y, self._back_pos_offset_y = self._back:GetPosition()
  self._rootX, self._rootOX, self._rooty, self._rootOY = self:GetRootWindow():GetSize()
end

function GachaEquipRateCell:OnDestroy()
  self._frame:Destroy()
end

function GachaEquipRateCell:RefreshCell(equipShowId)
  local recorder = CEquipCardPoolDetails:GetRecorder(equipShowId)
  self._title:SetText(TextManager.GetText(recorder.TypeName))
  self._totalRate:SetText(TextManager.GetText(recorder.WeightText))
  self._data = recorder.Equip
  self._frame:ReloadAllCell()
  local totallength = self._frame:GetTotalLength()
  local delta = totallength - self._oy
  self._back:SetSize(self._back_x, self._back_ox, self._back_y, self._back_oy + delta * self._panel_scaleY)
  self._back:SetPosition(self._back_pos_x, self._back_pos_offset_x, self._back_pos_y, self._back_pos_offset_y - delta / 2 * self._panel_scaleY)
  self._panel:SetSize(self._x, self._ox, self._y, totallength)
  self._panel:SetPosition(self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y - delta / 2)
  self:GetRootWindow():SetSize(self._rootX, self._rootOX, self._rooty, self._rootOY + delta * self._panel_scaleY)
  self._frame:ReloadAllCell()
end

function GachaEquipRateCell:NumberOfCell(frame)
  return #self._data
end

function GachaEquipRateCell:CellAtIndex(frame, index)
  return "gacha.equip.gachaequiprateitemcell"
end

function GachaEquipRateCell:DataAtIndex(frame, index)
  return self._data[index]
end

return GachaEquipRateCell
