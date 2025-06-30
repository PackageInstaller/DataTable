-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/fragment/monsterskillcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MonsterSkillCell = class("MonsterSkillCell", Dialog)
MonsterSkillCell.AssetBundleName = "ui/layouts.fragment"
MonsterSkillCell.AssetName = "LevelInfoSkillCell"
local CSkillShow_Common = (BeanManager.GetTableByName)("skill.cskillshow_common")
MonsterSkillCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MonsterSkillCell
  ((MonsterSkillCell.super).Ctor)(self, ...)
end

MonsterSkillCell.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("Title")
  self._text = self:GetChild("Detail")
  ;
  (self._text):SetText("")
  self._width = (self._text):GetRectSize()
  local _ = 0
  _ = (self._text):GetPreferredSize()
  self._text_size_x = (self._text):GetSize()
  self._text_pos_x = (self._text):GetPosition()
  self._talk_size_x = (self:GetRootWindow()):GetSize()
  self._talk_pos_x = (self:GetRootWindow()):GetPosition()
end

MonsterSkillCell.OnDestroy = function(self)
  -- function num : 0_2
end

MonsterSkillCell.RefreshCell = function(self, skillid)
  -- function num : 0_3 , upvalues : CSkillShow_Common, _ENV
  local skillcfg = CSkillShow_Common:GetRecorder(skillid)
  ;
  (self._name):SetText((TextManager.GetText)(skillcfg.nameTextID))
  ;
  (self._text):SetText((TextManager.GetText)(skillcfg.exDiscribeTextID))
  local fontsize = (self._text):GetFontSize()
  local _, textheight = (self._text):GetPreferredSize()
  if self._height < textheight then
    local line = (math.ceil)((textheight - self._height) / self._oneline)
    local delta = line * fontsize + 10
    ;
    (self._text):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    ;
    (self._text):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
    ;
    (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
    ;
    (self:GetRootWindow()):SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y - delta)
  else
    do
      ;
      (self._text):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y)
      ;
      (self._text):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y)
      ;
      (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
      ;
      (self:GetRootWindow()):SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y)
    end
  end
end

return MonsterSkillCell

