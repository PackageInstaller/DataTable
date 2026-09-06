local GridFrame = require("framework.ui.frame.grid.gridframe")
local FilterFrame = class("FilterFrame", Dialog)
FilterFrame.AssetBundleName = "ui/layouts.basecharacterinfo"
FilterFrame.AssetName = "BaseCharacterListFliterNewFrame"

function FilterFrame:Ctor(...)
  FilterFrame.super.Ctor(self, ...)
end

function FilterFrame:OnCreate()
  self._panel = self:GetRootWindow()
  self._field = self:GetChild("Frame")
  self._title = self:GetChild("Txt")
  self._frame = GridFrame.Create(self._field, self, true, 3, false)
  self._x, self._ox, self._y, self._oy = self._field:GetSize()
  self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y = self._field:GetPosition()
  self._rootX, self._rootOX, self._rooty, self._rootOY = self:GetRootWindow():GetSize()
end

function FilterFrame:OnDestroy()
  self._frame:Destroy()
end

function FilterFrame:RefreshCell(data)
  self._frame:ReloadAllCell()
  if not data.target or data.target == "Role" or data.target == "Equip" or data.target == "Monster" or data.target == "EquipBook" or data.target == "EquipChange" or data.target == "RoleHandBook" or data.target == "SkinHandBook" then
    self._title:SetActive(true)
    self._title:SetText(TextManager.GetText(data.TypeNameId))
  else
    self._title:SetActive(false)
  end
  local totallength = self._frame:GetTotalLength()
  local delta = totallength - self._oy
  self._field:SetSize(self._x, self._ox, self._y, self._oy + delta)
  self._field:SetPosition(self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y - delta)
  self:GetRootWindow():SetSize(self._rootX, self._rootOX, self._rooty, self._rootOY + delta)
  self._frame:ReloadAllCell()
end

function FilterFrame:NumberOfCell(frame)
  return #self._cellData.list
end

function FilterFrame:CellAtIndex(frame, index)
  return "common.filterframecell"
end

function FilterFrame:DataAtIndex(frame, index)
  return self._cellData.list[index]
end

function FilterFrame:OnEvent(eventName, arg)
  if eventName == "ChangeSelectNameId" then
    self._frame:FireEvent("ChangeSelectNameId")
  end
end

return FilterFrame
