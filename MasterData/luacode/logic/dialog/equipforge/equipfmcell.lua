-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipforge/equipfmcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CAttrEffectidNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CRandomAbilityTable = (BeanManager.GetTableByName)("equip.crandomability")
local Cequipbreakcfg = (BeanManager.GetTableByName)("equip.cequipbreakcfg")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CRankShow = (BeanManager.GetTableByName)("equip.crankshow")
local EquipFMCell = class("EquipFMCell", Dialog)
local ReplacePercent = function(str)
  -- function num : 0_0 , upvalues : _ENV
  str = (string.gsub)(str, "%%", "%%%%")
  return str
end

EquipFMCell.AssetBundleName = "ui/layouts.equip"
EquipFMCell.AssetName = "EquipFMCell"
EquipFMCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : EquipFMCell
  ((EquipFMCell.super).Ctor)(self, ...)
  self.canClick = true
  self._superWordEffectHandler = nil
end

EquipFMCell.OnCreate = function(self)
  -- function num : 0_2
  self._backNode = self:GetChild("Back")
  self._rankImage = self:GetChild("Back/LevelImg")
  self._propertyNameText = self:GetChild("Back/Txt1")
  self._propertyValueText = self:GetChild("Back/Num")
  self._lockNode = self:GetChild("Lock")
  self._superWordEffect = self:GetChild("Effect")
  self._specialBackNode = self:GetChild("Special")
  self._specialRankText = self:GetChild("Special/Level")
  self._specialRankImage = self:GetChild("Special/LevelImg")
  self._specialPropertyNameText = self:GetChild("Special/Txt1")
  self._specialPropertyValueText = self:GetChild("Special/Num")
end

EquipFMCell.OnDestroy = function(self)
  -- function num : 0_3
end

EquipFMCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : CRandomAbilityTable, CRankShow, _ENV, CAttrEffectidNameTable, CStringRes, CImagePathTable
  if data.unlock == false then
    (self._lockNode):SetActive(true)
    ;
    (self._backNode):SetActive(false)
    ;
    (self._specialBackNode):SetActive(false)
    return 
  end
  ;
  (self._lockNode):SetActive(false)
  local randomAbilityRecord = CRandomAbilityTable:GetRecorder(data.randomAbilityId)
  local rankShowRecord = CRankShow:GetRecorder(data.attrRank)
  local attrId = data.attrId - (math.fmod)(tonumber(data.attrId), 10)
  local attrRecord = CAttrEffectidNameTable:GetRecorder(attrId)
  local attrRangeRecord = randomAbilityRecord.attrRange
  local num1, num2 = (string.match)(attrRangeRecord, "(%d+);(%d+)")
  local attrValue = nil
  if attrRecord.isDecimal == 1 then
    attrValue = data.value / 1000 * 100
    num1 = num1 / 1000 * 100
    num2 = num2 / 1000 * 100
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1286)).msgTextID)
    attrValue = (string.gsub)(str, "%$parameter1%$", tostring(attrValue))
    num1 = (string.gsub)(str, "%$parameter1%$", tostring(num1))
    num2 = (string.gsub)(str, "%$parameter1%$", tostring(num2))
  else
    do
      attrValue = data.value
      local imageRecord = CImagePathTable:GetRecorder(rankShowRecord.imgid)
      if data.kind == 1 then
        (self._backNode):SetActive(true)
        ;
        (self._specialBackNode):SetActive(false)
        ;
        (self._rankImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        ;
        (self._propertyNameText):SetText((TextManager.GetText)(attrRecord.classnameTextID))
        ;
        (self._propertyValueText):SetText(attrValue)
      else
        ;
        (self._backNode):SetActive(false)
        ;
        (self._specialBackNode):SetActive(true)
        ;
        (self._specialRankImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        ;
        (self._specialPropertyNameText):SetText((TextManager.GetText)(attrRecord.classnameTextID))
        ;
        (self._specialPropertyValueText):SetText(attrValue)
      end
      -- DECOMPILER ERROR at PC166: Unhandled construct in 'MakeBoolean' P1

      if (self._delegate)._superWordRank <= data.attrRank and self._superWordEffectHandler == nil then
        self._superWordEffectHandler = (self._superWordEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1103))
      end
      if self._superWordEffectHandler then
        (self._superWordEffect):ReleaseEffect(self._superWordEffectHandler)
        self._superWordEffectHandler = nil
      end
    end
  end
end

return EquipFMCell

