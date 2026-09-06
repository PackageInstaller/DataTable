local CSkillShow_Common = BeanManager.GetTableByName("skill.cskillshow_common")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CWordColor = BeanManager.GetTableByName("message.cwordcolor")
local EquipTipsSuitSkillCell = class("EquipTipsSuitSkillCell", Dialog)
EquipTipsSuitSkillCell.AssetBundleName = "ui/layouts.equip"
EquipTipsSuitSkillCell.AssetName = "EquipTipsNewCellSuit2"
local StrTextID = {
  [1] = 1494,
  [2] = 1495,
  [3] = 1496
}

function EquipTipsSuitSkillCell:Ctor(...)
  EquipTipsSuitSkillCell.super.Ctor(self, ...)
end

function EquipTipsSuitSkillCell:OnCreate()
  self._text = self:GetChild("Txt")
  self._width, self._height = self._text:GetRectSize()
  local _ = 0
  _, self._oneline = self._text:GetPreferredSize()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._text:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._text:GetPosition()
  self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y = self:GetRootWindow():GetSize()
  self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y = self:GetRootWindow():GetPosition()
end

function EquipTipsSuitSkillCell:OnDestroy()
end

function EquipTipsSuitSkillCell:RefreshCell(data)
  local color
  if data.takeEffect then
    color = CWordColor:GetRecorder(28).wordcolor
  else
    color = CWordColor:GetRecorder(27).wordcolor
  end
  local str
  local discribe = CSkillShow_Common:GetRecorder(data.skillID).exDiscribeTextID
  discribe = TextManager.GetText(discribe)
  discribe = string.gsub(discribe, "%%", "%%%%")
  str = TextManager.GetText(CStringRes:GetRecorder(StrTextID[data.count]).msgTextID)
  str = string.gsub(str, "%$parameter1%$", color)
  str = string.gsub(str, "%$parameter2%$", discribe)
  self._text:SetText(str)
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

return EquipTipsSuitSkillCell
