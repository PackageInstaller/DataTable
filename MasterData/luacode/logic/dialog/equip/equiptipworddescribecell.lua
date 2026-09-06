local CSkillShow_Common = BeanManager.GetTableByName("skill.cskillshow_common")
local CRandomAbilityTable = BeanManager.GetTableByName("equip.crandomability")
local Cequipbreakcfg = BeanManager.GetTableByName("equip.cequipbreakcfg")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CAttrEffectidNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local EquipTipWordDescribeCell = class("EquipTipWordDescribeCell", Dialog)
EquipTipWordDescribeCell.AssetBundleName = "ui/layouts.equip"
EquipTipWordDescribeCell.AssetName = "EquipTipsNewCell4"

function EquipTipWordDescribeCell:Ctor(...)
  EquipTipWordDescribeCell.super.Ctor(self, ...)
end

function EquipTipWordDescribeCell:OnCreate()
  self._image = self:GetChild("Image")
  self._text = self:GetChild("Txt")
  self._width, self._height = self._text:GetRectSize()
  local _ = 0
  _, self._oneline = self._text:GetPreferredSize()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._text:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._text:GetPosition()
  self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y = self:GetRootWindow():GetSize()
  self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y = self:GetRootWindow():GetPosition()
end

function EquipTipWordDescribeCell:OnDestroy()
end

function EquipTipWordDescribeCell:RefreshCell(data)
  local imageRecord = CImagePathTable:GetRecorder(11469) or DataCommon.DefaultImageAsset
  self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.value == -1 then
    local str = TextManager.GetText(700787)
    self._text:SetText(str)
  else
    local recorde = CRandomAbilityTable:GetRecorder(data.value)
    if recorde.type == 1 then
      local attrRecord = CAttrEffectidNameTable:GetRecorder(data.value)
      local attrRangeRecord = CRandomAbilityTable:GetRecorder(data.randomAbilityId).attrRange
      local num1, num2 = string.match(attrRangeRecord, "(%d+);(%d+)")
      if attrRecord.isDecimal == 1 then
        num1 = num1 / 1000 * 100
        num2 = num2 / 1000 * 100
      end
      local str = TextManager.GetText(CStringRes:GetRecorder(1358).msgTextID)
      str = string.gsub(str, "%$parameter1%$", ReplacePercent(attrRecord.classnameTextID))
      str = string.gsub(str, "%$parameter2%$", tostring(num1))
      str = string.gsub(str, "%$parameter3%$", tostring(num2))
      self._text:SetText(str)
    elseif recorde.type == 2 then
      local skillId = CRandomAbilityTable:GetRecorder(data.value).skillID
      local str = ""
      local name = CSkillShow_Common:GetRecorder(skillId).nameTextID
      name = TextManager.GetText(name)
      local discribe = CSkillShow_Common:GetRecorder(skillId).exDiscribeTextID
      discribe = TextManager.GetText(discribe)
      discribe = string.gsub(discribe, "%%", "%%%%")
      str = TextManager.GetText(CStringRes:GetRecorder(1208).msgTextID)
      str = string.gsub(str, "%$parameter1%$", name)
      str = string.gsub(str, "%$parameter2%$", discribe)
      self._text:SetText(str)
    end
  end
end

return EquipTipWordDescribeCell
