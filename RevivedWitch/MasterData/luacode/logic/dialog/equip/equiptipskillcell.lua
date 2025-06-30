-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/equiptipskillcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkillShow_Common = (BeanManager.GetTableByName)("skill.cskillshow_common")
local CRandomAbilityTable = (BeanManager.GetTableByName)("equip.crandomability")
local Cequipbreakcfg = (BeanManager.GetTableByName)("equip.cequipbreakcfg")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local EquipTipSkillCell = class("EquipTipSkillCell", Dialog)
EquipTipSkillCell.AssetBundleName = "ui/layouts.equip"
EquipTipSkillCell.AssetName = "EquipTipsNewCell2"
EquipTipSkillCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipTipSkillCell
  ((EquipTipSkillCell.super).Ctor)(self, ...)
end

EquipTipSkillCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("Image")
  self._text = self:GetChild("Txt")
  self._width = (self._text):GetRectSize()
  local _ = 0
  _ = (self._text):GetPreferredSize()
  self._text_size_x = (self._text):GetSize()
  self._text_pos_x = (self._text):GetPosition()
  self._talk_size_x = (self:GetRootWindow()):GetSize()
  self._talk_pos_x = (self:GetRootWindow()):GetPosition()
end

EquipTipSkillCell.OnDestroy = function(self)
  -- function num : 0_2
end

EquipTipSkillCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV, CSkillShow_Common, CStringRes
  if not CImagePathTable:GetRecorder(11470) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local str = ""
  local name = (CSkillShow_Common:GetRecorder(data.skillId)).nameTextID
  name = (TextManager.GetText)(name)
  local discribe = (CSkillShow_Common:GetRecorder(data.skillId)).exDiscribeTextID
  discribe = (TextManager.GetText)(discribe)
  discribe = (string.gsub)(discribe, "%%", "%%%%")
  str = (TextManager.GetText)((CStringRes:GetRecorder(1208)).msgTextID)
  str = (string.gsub)(str, "%$parameter1%$", name)
  str = (string.gsub)(str, "%$parameter2%$", discribe)
  ;
  (self._text):SetText(str)
  local fontsize = (self._text):GetFontSize()
  local _, textheight = (self._text):GetPreferredSize()
  if self._height < textheight then
    local line = (math.ceil)((textheight - self._height) / self._oneline)
    local delta = line * fontsize
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

return EquipTipSkillCell

