local TableFrame = require("framework.ui.frame.table.tableframe")
local CDormFurnitureType = BeanManager.GetTableByName("courtyard.cdormfurnituretype")
local ThemeFurnitureTypeCell = class("ThemeFurnitureTypeCell", Dialog)
ThemeFurnitureTypeCell.AssetBundleName = "ui/layouts.yard"
ThemeFurnitureTypeCell.AssetName = "FurnitureThemeBuyFrame"

function ThemeFurnitureTypeCell:Ctor(...)
  ThemeFurnitureTypeCell.super.Ctor(self, ...)
end

function ThemeFurnitureTypeCell:OnCreate()
  self._typeTxt = self:GetChild("TitleBack/Txt")
  self._panel = self:GetChild("Frame")
  self._anchorX, self._offsetX, self._anchorY, self._offsetY = self._rootWindow:GetSize()
  self._panel_anchorX, self._panel_offsetX, self._panel_anchorY, self._panel_offsetY = self._panel:GetSize()
  self._panel_pos_anchorY, self._panel_pos_offsetY = self._panel:GetYPosition()
  self._frame = TableFrame.Create(self._panel, self, true, false, true)
end

function ThemeFurnitureTypeCell:OnDestroy()
  self._frame:Destroy()
end

function ThemeFurnitureTypeCell:RefreshCell(data)
  if data.type == self._delegate._haveFurnitureType then
    self._typeTxt:SetText(TextManager.GetText(700834))
  else
    local recorder = CDormFurnitureType:GetRecorder(data.type)
    self._typeTxt:SetText(TextManager.GetText(recorder.nameTextID))
  end
  self._frame:ReloadAllCell()
  local len = self._frame:GetTotalLength()
  self._panel:SetSize(self._anchorX, self._offsetX, self._anchorY, len)
  self._panel:SetYPosition(self._panel_pos_anchorY, self._panel_pos_offsetY - (len - self._panel_offsetY) / 2)
  self._rootWindow:SetSize(self._anchorX, self._offsetX, self._anchorY, self._offsetY + (len - self._panel_offsetY))
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function ThemeFurnitureTypeCell:NumberOfCell(frame)
  return #self._cellData.data
end

function ThemeFurnitureTypeCell:CellAtIndex(frame, index)
  return "courtcabin.shop.themefurniturecell"
end

function ThemeFurnitureTypeCell:DataAtIndex(frame, index)
  return self._cellData.data[index]
end

return ThemeFurnitureTypeCell
