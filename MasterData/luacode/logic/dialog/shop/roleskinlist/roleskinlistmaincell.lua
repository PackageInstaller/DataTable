local GridFrame = require("framework.ui.frame.grid.gridframe")
local UIManager = CS.PixelNeko.UI.UIManager
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local RoleSkinListMainCell = class("RoleSkinListMainCell", Dialog)
RoleSkinListMainCell.AssetBundleName = "ui/layouts.baseshop"
RoleSkinListMainCell.AssetName = "FashionShopListCell"

function RoleSkinListMainCell:Ctor(...)
  RoleSkinListMainCell.super.Ctor(self, ...)
  self._cellNum = 5
end

function RoleSkinListMainCell:OnCreate()
  self._panel = self:GetChild("ClothesFrame")
  self._yearText = self:GetChild("Year/YearText")
  local ratio = UIManager.GetScreenWHRatio()
  if 2.0 < ratio then
    local wAnchor, wWidth = self._panel:GetWidth()
    local px, pox, py, poy = self._panel:GetPosition()
    local cellDialog = DialogManager.CreateDialog("shop.roleskinlist.roleskinlistmaincellcell", nil)
    local rootWindow = cellDialog:GetRootWindow()
    local cellWidth = rootWindow:GetRectSize()
    cellDialog:RootWindowDestroy()
    self._panel:SetWidth(wAnchor, wWidth + cellWidth)
    self._panel:SetPosition(px, pox - cellWidth / 2, py, poy)
    local wAnchor, wWidth = self:GetRootWindow():GetWidth()
    local px, pox, py, poy = self:GetRootWindow():GetPosition()
    self:GetRootWindow():SetWidth(wAnchor, wWidth + cellWidth)
    self._cellNum = 6
  end
  self._w, self._oneline = self._panel:GetRectSize()
  self._main_anchorMinX, self._main_anchorMinY, self._main_anchorMaxX, self._main_anchorMaxY, self._main_offsetMinX, self._main_offsetMinY, self._main_offsetMaxX, self._main_offsetMaxY = self._panel:GetAnchorAndOffset()
  self._panel_x, self._panel_offset_x, self._panel_y, self._panel_offset_y = self._panel:GetSize()
  self._rootsize_x, self._rootsize_offset_x, self._rootsize_y, self._rootsize_offset_y = self:GetRootWindow():GetSize()
end

function RoleSkinListMainCell:OnDestroy()
  self._frame:Destroy()
end

function RoleSkinListMainCell:RefreshCell(data)
  self._data = data
  self._yearText:SetText(self._data.title)
  local line = math.ceil(#self._data.skinlist / self._cellNum) - 1
  if self._frame then
    self._frame:Destroy()
  end
  local delta = line * self._oneline
  self._panel:SetAnchorAndOffset(self._main_anchorMinX, self._main_anchorMinY, self._main_anchorMaxX, self._main_anchorMaxY, self._main_offsetMinX, self._main_offsetMinY - delta, self._main_offsetMaxX, self._main_offsetMaxY)
  self:GetRootWindow():SetSize(self._rootsize_x, self._rootsize_offset_x, self._rootsize_y, self._rootsize_offset_y + delta)
  self._frame = GridFrame.Create(self._panel, self, true, self._cellNum, false)
  self._frame:ReloadAllCell()
end

function RoleSkinListMainCell:NumberOfCell(frame)
  return #self._data.skinlist
end

function RoleSkinListMainCell:CellAtIndex(frame)
  return "shop.roleskinlist.roleskinlistmaincellcell"
end

function RoleSkinListMainCell:DataAtIndex(frame, index)
  return self._data.skinlist[index]
end

function RoleSkinListMainCell:OnEvent(name, args)
  if name == "UnLock" then
    self._frame:FireEvent("UnLock", args)
  end
end

return RoleSkinListMainCell
