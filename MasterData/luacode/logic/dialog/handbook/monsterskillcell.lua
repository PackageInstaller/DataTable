local MonsterSkillCell = class("MonsterSkillCell", Dialog)
MonsterSkillCell.AssetBundleName = "ui/layouts.tujian"
MonsterSkillCell.AssetName = "MonsterBookSkillCell"
local CSkillShow_Common = BeanManager.GetTableByName("skill.cskillshow_common")

function MonsterSkillCell:Ctor(...)
  MonsterSkillCell.super.Ctor(self, ...)
end

function MonsterSkillCell:OnCreate()
  self._name = self:GetChild("Title")
  self._text = self:GetChild("Detail")
  self._text:SetText("")
  self._width, self._height = self._text:GetRectSize()
  local _ = 0
  _, self._oneline = self._text:GetPreferredSize()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._text:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._text:GetPosition()
  self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y = self:GetRootWindow():GetSize()
  self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y = self:GetRootWindow():GetPosition()
end

function MonsterSkillCell:OnDestroy()
end

function MonsterSkillCell:RefreshCell(skillid)
  local skillcfg = CSkillShow_Common:GetRecorder(skillid)
  if skillcfg then
    self._name:SetText(TextManager.GetText(skillcfg.nameTextID))
    self._text:SetText(TextManager.GetText(skillcfg.exDiscribeTextID))
  else
    self._name:SetText("")
    self._text:SetText("")
  end
  local _, textheight = self._text:GetPreferredSize()
  if textheight > self._height then
    local line = math.ceil((textheight - self._height) / self._oneline)
    local delta = line * self._oneline
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

return MonsterSkillCell
