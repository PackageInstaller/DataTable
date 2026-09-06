local GridFrame = require("framework.ui.frame.grid.gridframe")
local FilterFrameCell = class("FilterFrameCell", Dialog)
FilterFrameCell.AssetBundleName = "ui/layouts.basecharacterinfo"
FilterFrameCell.AssetName = "BaseCharacterListFliterNewFrame"

function FilterFrameCell:Ctor(...)
  FilterFrameCell.super.Ctor(self, ...)
end

function FilterFrameCell:OnCreate()
  self._panel = self:GetRootWindow()
  self._field = self:GetChild("Frame")
  self._title = self:GetChild("Txt")
  self._frame = GridFrame.Create(self._field, self, true, 3, false)
  self._size_x, self._size_offset_x, self._size_y, self._size_offset_y = self._panel:GetSize()
  self.pos_x, self.pos_offset_x, self.pos_y, self.pos_offset_y = self._panel:GetPosition()
end

function FilterFrameCell:OnDestroy()
  self._frame:Destroy()
end

function FilterFrameCell:RefreshCell(data)
  self._frame:ReloadAllCell()
  if data.target == "Role" then
    self._title:SetActive(true)
    self._title:SetText(TextManager.GetText(data.TypeNameId))
  elseif not data.target or data.target == "Equip" or data.target == "EquipBook" then
    self._title:SetActive(true)
    self._title:SetText(TextManager.GetText(data.TypeNameId))
  elseif data.target == "Monster" then
    self._title:SetActive(true)
    self._title:SetText(TextManager.GetText(data.TypeNameId))
  else
    self._title:SetActive(false)
  end
end

function FilterFrameCell:NumberOfCell(frame)
  return #self._cellData.list
end

function FilterFrameCell:CellAtIndex(frame, index)
  return "equipstrengthen.filtersortcell"
end

function FilterFrameCell:DataAtIndex(frame, index)
  return self._cellData.list[index]
end

function FilterFrameCell:OnEvent(eventName, arg)
  if eventName == "ChangeSelectNameId" then
    self._frame:FireEvent("ChangeSelectNameId")
  end
end

return FilterFrameCell
