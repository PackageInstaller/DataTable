local GridFrame = require("framework.ui.frame.grid.gridframe")
local EquipFilterFrame = class("EquipFilterFrame", Dialog)
EquipFilterFrame.AssetBundleName = "ui/layouts.equip"
EquipFilterFrame.AssetName = "EquipPopFliterFrame"

function EquipFilterFrame:Ctor(...)
  EquipFilterFrame.super.Ctor(self, ...)
end

function EquipFilterFrame:OnCreate()
  self._panel = self:GetRootWindow()
  self._field = self:GetChild("Frame")
  self._title = self:GetChild("Txt")
  self._frame = GridFrame.Create(self._field, self, true, 3, false)
  self._x, self._ox, self._y, self._oy = self._field:GetSize()
  self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y = self._field:GetPosition()
  self._title_pos_x, self._title_pos_offset_x, self._title_pos_y, self._title_pos_offset_y = self._title:GetPosition()
  self._rootX, self._rootOX, self._rooty, self._rootOY = self:GetRootWindow():GetSize()
end

function EquipFilterFrame:OnDestroy()
  self._frame:Destroy()
end

function EquipFilterFrame:RefreshCell(data)
  self._frame:ReloadAllCell()
  if not data.target or data.target == "Role" or data.target == "Equip" or data.target == "Monster" or data.target == "EquipBook" or data.target == "EquipChange" or data.target == "SignBordRole" then
    self._title:SetActive(true)
    self._title:SetText(TextManager.GetText(data.TypeNameId))
  else
    self._title:SetActive(false)
  end
  local totallength = self._frame:GetTotalLength()
  local delta = totallength - self._oy
  self._field:SetSize(self._x, self._ox, self._y, self._oy + delta)
  self._field:SetPosition(self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y - delta / 2)
  self._title:SetPosition(self._title_pos_x, self._title_pos_offset_x, self._title_pos_y, self._title_pos_offset_y + delta / 2)
  self:GetRootWindow():SetSize(self._rootX, self._rootOX, self._rooty, self._rootOY + delta)
  self._frame:ReloadAllCell()
end

function EquipFilterFrame:NumberOfCell(frame)
  return #self._cellData.list
end

function EquipFilterFrame:CellAtIndex(frame, index)
  return "common.equipfilterframecell"
end

function EquipFilterFrame:DataAtIndex(frame, index)
  return self._cellData.list[index]
end

function EquipFilterFrame:OnEvent(eventName, arg)
  if eventName == "ChangeSelectNameId" then
    self._frame:FireEvent("ChangeSelectNameId")
  end
end

return EquipFilterFrame
