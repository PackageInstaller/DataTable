-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/battlepauseskilldetailcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattlePauseSkillDetailCell = class("BattlePauseSkillDetailCell", Dialog)
BattlePauseSkillDetailCell.AssetBundleName = "ui/layouts.battlenew"
BattlePauseSkillDetailCell.AssetName = "BattlePauseSkillCell"
BattlePauseSkillDetailCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattlePauseSkillDetailCell
  ((BattlePauseSkillDetailCell.super).Ctor)(self, ...)
end

BattlePauseSkillDetailCell.OnCreate = function(self)
  -- function num : 0_1
  self._describe = self:GetChild("Detail")
  self._width = (self._describe):GetRectSize()
  local _ = 0
  self._talk_size_x = (self:GetRootWindow()):GetSize()
  self._talk_pos_x = (self:GetRootWindow()):GetPosition()
end

BattlePauseSkillDetailCell.OnDestroy = function(self)
  -- function num : 0_2
end

BattlePauseSkillDetailCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._describe):SetText(data.describe)
  local _, textheight = (self._describe):GetPreferredSize()
  local fontsize = (self._describe):GetFontSize()
  if self._height < textheight then
    local line = (math.ceil)((textheight - self._height) / fontsize)
    local delta = line * fontsize
    ;
    (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
    ;
    (self:GetRootWindow()):SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y - delta)
    ;
    (self._delegate):SetFrameSlide(true, data.skillIndex)
  else
    do
      ;
      (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
      ;
      (self:GetRootWindow()):SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y)
      ;
      (self._delegate):SetFrameSlide(false, data.skillIndex)
    end
  end
end

return BattlePauseSkillDetailCell

