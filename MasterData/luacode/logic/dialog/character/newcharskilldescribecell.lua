local NewCharSkillDescribeCell = class("NewCharSkillDescribeCell", Dialog)
NewCharSkillDescribeCell.AssetBundleName = "ui/layouts.basecharacterinfo"
NewCharSkillDescribeCell.AssetName = "CharSkillDescribe"

function NewCharSkillDescribeCell:Ctor(...)
  NewCharSkillDescribeCell.super.Ctor(self, ...)
end

function NewCharSkillDescribeCell:OnCreate()
  self._describe = self:GetChild("SkillDescribe")
  self._describe:SetText("")
  self._width, self._height = self._describe:GetRectSize()
  local _ = 0
  _, self._oneline = self._describe:GetPreferredSize()
  self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y = self:GetRootWindow():GetSize()
  self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y = self:GetRootWindow():GetPosition()
end

function NewCharSkillDescribeCell:OnDestroy()
end

function NewCharSkillDescribeCell:RefreshCell(data)
  self._describe:SetText(data)
  local _, textheight = self._describe:GetPreferredSize()
  local fontsize = self._describe:GetFontSize()
  if textheight > self._height then
    local line = math.ceil((textheight - self._height) / self._oneline)
    local delta = line * fontsize
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
    self:GetRootWindow():SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y - delta)
  else
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
    self:GetRootWindow():SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y)
  end
end

return NewCharSkillDescribeCell
