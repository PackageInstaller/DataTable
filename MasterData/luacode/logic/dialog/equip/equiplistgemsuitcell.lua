local EquipListGemSuitCell = class("EquipListGemSuitCell", Dialog)
EquipListGemSuitCell.AssetBundleName = "ui/layouts.equip"
EquipListGemSuitCell.AssetName = "EquipListSuit2"

function EquipListGemSuitCell:Ctor(...)
  EquipListGemSuitCell.super.Ctor(self, ...)
end

function EquipListGemSuitCell:OnCreate()
  self._text = self:GetChild("Txt")
  self._width, self._height = self._text:GetRectSize()
  local _ = 0
  _, self._oneline = self._text:GetPreferredSize()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._text:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._text:GetPosition()
  self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y = self:GetRootWindow():GetSize()
  self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y = self:GetRootWindow():GetPosition()
end

function EquipListGemSuitCell:OnDestroy()
end

function EquipListGemSuitCell:RefreshCell(data)
  self._text:SetText("<color=#" .. data.color .. ">" .. data.showText .. "</color>")
  local _, textheight = self._text:GetPreferredSize()
  if textheight > self._height then
    local line = math.ceil((textheight - self._height) / self._oneline)
    local delta = line * self._oneline
    self._text:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    self._text:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
  else
    self._text:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y)
    self._text:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y)
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
  end
end

return EquipListGemSuitCell
