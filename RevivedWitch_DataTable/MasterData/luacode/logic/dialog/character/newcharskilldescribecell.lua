-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/newcharskilldescribecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NewCharSkillDescribeCell = class("NewCharSkillDescribeCell", Dialog)
NewCharSkillDescribeCell.AssetBundleName = "ui/layouts.basecharacterinfo"
NewCharSkillDescribeCell.AssetName = "CharSkillDescribe"
NewCharSkillDescribeCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewCharSkillDescribeCell
  ((NewCharSkillDescribeCell.super).Ctor)(self, ...)
end

NewCharSkillDescribeCell.OnCreate = function(self)
  -- function num : 0_1
  self._describe = self:GetChild("SkillDescribe")
  ;
  (self._describe):SetText("")
  self._width = (self._describe):GetRectSize()
  local _ = 0
  _ = (self._describe):GetPreferredSize()
  self._talk_size_x = (self:GetRootWindow()):GetSize()
  self._talk_pos_x = (self:GetRootWindow()):GetPosition()
end

NewCharSkillDescribeCell.OnDestroy = function(self)
  -- function num : 0_2
end

NewCharSkillDescribeCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._describe):SetText(data)
  local _, textheight = (self._describe):GetPreferredSize()
  local fontsize = (self._describe):GetFontSize()
  if self._height < textheight then
    local line = (math.ceil)((textheight - self._height) / self._oneline)
    local delta = line * fontsize
    ;
    (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
    ;
    (self:GetRootWindow()):SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y - delta)
  else
    do
      ;
      (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
      ;
      (self:GetRootWindow()):SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y)
    end
  end
end

return NewCharSkillDescribeCell

