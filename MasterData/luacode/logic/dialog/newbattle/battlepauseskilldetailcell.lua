local BattlePauseSkillDetailCell = class("BattlePauseSkillDetailCell", Dialog)
BattlePauseSkillDetailCell.AssetBundleName = "ui/layouts.battlenew"
BattlePauseSkillDetailCell.AssetName = "BattlePauseSkillCell"

function BattlePauseSkillDetailCell:Ctor(...)
  BattlePauseSkillDetailCell.super.Ctor(self, ...)
end

function BattlePauseSkillDetailCell:OnCreate()
  self._describe = self:GetChild("Detail")
  self._width, self._height = self._describe:GetRectSize()
  local _ = 0
  self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y = self:GetRootWindow():GetSize()
  self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y = self:GetRootWindow():GetPosition()
end

function BattlePauseSkillDetailCell:OnDestroy()
end

function BattlePauseSkillDetailCell:RefreshCell(data)
  self._describe:SetText(data.describe)
  local _, textheight = self._describe:GetPreferredSize()
  local fontsize = self._describe:GetFontSize()
  if textheight > self._height then
    local line = math.ceil((textheight - self._height) / fontsize)
    local delta = line * fontsize
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
    self:GetRootWindow():SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y - delta)
    self._delegate:SetFrameSlide(true, data.skillIndex)
  else
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
    self:GetRootWindow():SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y)
    self._delegate:SetFrameSlide(false, data.skillIndex)
  end
end

return BattlePauseSkillDetailCell
