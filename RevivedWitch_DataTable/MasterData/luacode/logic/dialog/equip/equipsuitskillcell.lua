-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/equipsuitskillcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkillShow_Common = (BeanManager.GetTableByName)("skill.cskillshow_common")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CWordColor = (BeanManager.GetTableByName)("message.cwordcolor")
local EquipSuitSkillCell = class("EquipSuitSkillCell", Dialog)
EquipSuitSkillCell.AssetBundleName = "ui/layouts.equip"
EquipSuitSkillCell.AssetName = "EquipListSuit2"
local StrTextID = {[1] = 1494, [2] = 1495, [3] = 1496}
EquipSuitSkillCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipSuitSkillCell
  ((EquipSuitSkillCell.super).Ctor)(self, ...)
end

EquipSuitSkillCell.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Txt")
  self._width = (self._text):GetRectSize()
  local _ = 0
  _ = (self._text):GetPreferredSize()
  self._text_size_x = (self._text):GetSize()
  self._text_pos_x = (self._text):GetPosition()
  self._talk_size_x = (self:GetRootWindow()):GetSize()
  self._talk_pos_x = (self:GetRootWindow()):GetPosition()
end

EquipSuitSkillCell.OnDestroy = function(self)
  -- function num : 0_2
end

EquipSuitSkillCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CWordColor, CSkillShow_Common, _ENV, CStringRes, StrTextID
  local color = nil
  if data.takeEffect then
    color = (CWordColor:GetRecorder(28)).wordcolor
  else
    color = (CWordColor:GetRecorder(27)).wordcolor
  end
  local str = nil
  local discribe = (CSkillShow_Common:GetRecorder(data.skillID)).exDiscribeTextID
  discribe = (TextManager.GetText)(discribe)
  discribe = (string.gsub)(discribe, "%%", "%%%%")
  str = (TextManager.GetText)((CStringRes:GetRecorder(StrTextID[data.count])).msgTextID)
  str = (string.gsub)(str, "%$parameter1%$", color)
  str = (string.gsub)(str, "%$parameter2%$", discribe)
  ;
  (self._text):SetText(str)
  local _, textheight = (self._text):GetPreferredSize()
  if self._height < textheight then
    local line = (math.ceil)((textheight - self._height) / self._oneline)
    local delta = line * self._oneline
    ;
    (self._text):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    ;
    (self._text):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
    ;
    (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
  else
    do
      ;
      (self._text):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y)
      ;
      (self._text):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y)
      ;
      (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
    end
  end
end

return EquipSuitSkillCell

