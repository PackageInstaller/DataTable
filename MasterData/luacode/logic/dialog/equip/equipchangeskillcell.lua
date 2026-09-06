local CSkillShow_Common = BeanManager.GetTableByName("skill.cskillshow_common")
local EquipChangeSkillCell = class("EquipChangeSkillCell", Dialog)
EquipChangeSkillCell.AssetBundleName = "ui/layouts.equip"
EquipChangeSkillCell.AssetName = "EquipChangeSkillCell"

function EquipChangeSkillCell:Ctor(...)
  EquipChangeSkillCell.super.Ctor(self, ...)
end

function EquipChangeSkillCell:OnCreate()
  self._name = self:GetChild("Txt1")
  self._text = self:GetChild("Txt2")
  self._text:SetText("")
  self._width, self._height = self._text:GetRectSize()
  local _ = 0
  _, self._oneline = self._text:GetPreferredSize()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._text:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._text:GetPosition()
  self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y = self:GetRootWindow():GetSize()
  self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y = self:GetRootWindow():GetPosition()
end

function EquipChangeSkillCell:OnDestroy()
end

function EquipChangeSkillCell:RefreshCell(data)
  local name = CSkillShow_Common:GetRecorder(data.value).nameTextID
  name = TextManager.GetText(name)
  self._name:SetText(name)
  local exDiscribe = CSkillShow_Common:GetRecorder(data.value).exDiscribeTextID
  exDiscribe = TextManager.GetText(exDiscribe)
  self._text:SetText(exDiscribe)
  local fontsize = self._text:GetFontSize()
  local _, textheight = self._text:GetPreferredSize()
  if textheight > self._height then
    local line = math.ceil((textheight - self._height) / self._oneline)
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

return EquipChangeSkillCell
