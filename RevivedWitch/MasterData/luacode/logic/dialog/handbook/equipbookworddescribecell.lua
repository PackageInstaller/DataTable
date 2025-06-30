-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/equipbookworddescribecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkillShow_Common = (BeanManager.GetTableByName)("skill.cskillshow_common")
local CRandomAbilityTable = (BeanManager.GetTableByName)("equip.crandomability")
local Cequipbreakcfg = (BeanManager.GetTableByName)("equip.cequipbreakcfg")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CAttrEffectidNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local EquipBookWordDescribeCell = class("EquipBookWordDescribeCell", Dialog)
EquipBookWordDescribeCell.AssetBundleName = "ui/layouts.tujian"
EquipBookWordDescribeCell.AssetName = "EquipBookRandomPropertyCell"
EquipBookWordDescribeCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipBookWordDescribeCell
  ((EquipBookWordDescribeCell.super).Ctor)(self, ...)
end

EquipBookWordDescribeCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("Image")
  self._text = self:GetChild("Name")
  self._width = (self._text):GetRectSize()
  local _ = 0
  _ = (self._text):GetPreferredSize()
  self._text_size_x = (self._text):GetSize()
  self._text_pos_x = (self._text):GetPosition()
  self._talk_size_x = (self:GetRootWindow()):GetSize()
  self._talk_pos_x = (self:GetRootWindow()):GetPosition()
end

EquipBookWordDescribeCell.OnDestroy = function(self)
  -- function num : 0_2
end

EquipBookWordDescribeCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV, CRandomAbilityTable, CAttrEffectidNameTable, CStringRes, CSkillShow_Common
  if not CImagePathTable:GetRecorder(11469) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.value == -1 then
    local str = (TextManager.GetText)(700787)
    ;
    (self._text):SetText(str)
  else
    do
      local recorde = CRandomAbilityTable:GetRecorder(data.value)
      if recorde.type == 1 then
        local attrRecord = CAttrEffectidNameTable:GetRecorder(data.value)
        local attrRangeRecord = (CRandomAbilityTable:GetRecorder(data.randomAbilityId)).attrRange
        local num1, num2 = (string.match)(attrRangeRecord, "(%d+);(%d+)")
        if attrRecord.isDecimal == 1 then
          num1 = num1 / 1000 * 100
          num2 = num2 / 1000 * 100
        end
        local str = (TextManager.GetText)((CStringRes:GetRecorder(1358)).msgTextID)
        str = (string.gsub)(str, "%$parameter1%$", ReplacePercent(attrRecord.classnameTextID))
        str = (string.gsub)(str, "%$parameter2%$", tostring(num1))
        str = (string.gsub)(str, "%$parameter3%$", tostring(num2))
        ;
        (self._text):SetText(str)
      else
        do
          if recorde.type == 2 then
            local skillId = (CRandomAbilityTable:GetRecorder(data.value)).skillID
            local str = ""
            local name = (CSkillShow_Common:GetRecorder(skillId)).nameTextID
            name = (TextManager.GetText)(name)
            local discribe = (CSkillShow_Common:GetRecorder(skillId)).exDiscribeTextID
            discribe = (TextManager.GetText)(discribe)
            discribe = (string.gsub)(discribe, "%%", "%%%%")
            str = (TextManager.GetText)((CStringRes:GetRecorder(1208)).msgTextID)
            str = (string.gsub)(str, "%$parameter1%$", name)
            str = (string.gsub)(str, "%$parameter2%$", discribe)
            ;
            (self._text):SetText(str)
          end
        end
      end
    end
  end
end

return EquipBookWordDescribeCell

