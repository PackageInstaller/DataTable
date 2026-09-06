local ItemTipsUniqueEquipSkillCell = class("ItemTipsUniqueEquipSkillCell", Dialog)
ItemTipsUniqueEquipSkillCell.AssetBundleName = "ui/layouts.bag"
ItemTipsUniqueEquipSkillCell.AssetName = "ItemTipsNewEquip"

function ItemTipsUniqueEquipSkillCell:Ctor(...)
  ItemTipsUniqueEquipSkillCell.super.Ctor(self, ...)
end

function ItemTipsUniqueEquipSkillCell:OnCreate()
  self._text = self:GetChild("Skill/Equiptips")
  self._text:SetText("")
  self._width, self._height = self._text:GetRectSize()
  local _ = 0
  _, self._oneline = self._text:GetPreferredSize()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._text:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._text:GetPosition()
  self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y = self:GetRootWindow():GetSize()
  self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y = self:GetRootWindow():GetPosition()
end

function ItemTipsUniqueEquipSkillCell:OnDestroy()
end

function ItemTipsUniqueEquipSkillCell:RefreshCell(data)
  self._text:SetText(data.value)
  local fontsize = self._text:GetFontSize()
  local _, textheight = self._text:GetPreferredSize()
  if textheight > self._height then
    local line = (textheight - self._height) / fontsize
    local delta = line * fontsize
    self._text:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    self._text:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
    self:GetRootWindow():SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y - delta)
  else
    self._text:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y)
    self._text:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y)
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
    self:GetRootWindow():SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y)
  end
end

return ItemTipsUniqueEquipSkillCell
