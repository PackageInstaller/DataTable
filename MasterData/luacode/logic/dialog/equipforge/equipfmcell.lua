local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CAttrEffectidNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CRandomAbilityTable = BeanManager.GetTableByName("equip.crandomability")
local Cequipbreakcfg = BeanManager.GetTableByName("equip.cequipbreakcfg")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CRankShow = BeanManager.GetTableByName("equip.crankshow")
local EquipFMCell = class("EquipFMCell", Dialog)

local function ReplacePercent(str)
  str = string.gsub(str, "%%", "%%%%")
  return str
end

EquipFMCell.AssetBundleName = "ui/layouts.equip"
EquipFMCell.AssetName = "EquipFMCell"

function EquipFMCell:Ctor(...)
  EquipFMCell.super.Ctor(self, ...)
  self.canClick = true
  self._superWordEffectHandler = nil
end

function EquipFMCell:OnCreate()
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

function EquipFMCell:OnDestroy()
end

function EquipFMCell:RefreshCell(data)
  if data.unlock == false then
    self._lockNode:SetActive(true)
    self._backNode:SetActive(false)
    self._specialBackNode:SetActive(false)
    return
  end
  self._lockNode:SetActive(false)
  local randomAbilityRecord = CRandomAbilityTable:GetRecorder(data.randomAbilityId)
  local rankShowRecord = CRankShow:GetRecorder(data.attrRank)
  local attrId = data.attrId - math.fmod(tonumber(data.attrId), 10)
  local attrRecord = CAttrEffectidNameTable:GetRecorder(attrId)
  local attrRangeRecord = randomAbilityRecord.attrRange
  local num1, num2 = string.match(attrRangeRecord, "(%d+);(%d+)")
  local attrValue
  if attrRecord.isDecimal == 1 then
    attrValue = data.value / 1000 * 100
    num1 = num1 / 1000 * 100
    num2 = num2 / 1000 * 100
    local str = TextManager.GetText(CStringRes:GetRecorder(1286).msgTextID)
    attrValue = string.gsub(str, "%$parameter1%$", tostring(attrValue))
    num1 = string.gsub(str, "%$parameter1%$", tostring(num1))
    num2 = string.gsub(str, "%$parameter1%$", tostring(num2))
  else
    attrValue = data.value
  end
  local imageRecord = CImagePathTable:GetRecorder(rankShowRecord.imgid)
  if data.kind == 1 then
    self._backNode:SetActive(true)
    self._specialBackNode:SetActive(false)
    self._rankImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._propertyNameText:SetText(TextManager.GetText(attrRecord.classnameTextID))
    self._propertyValueText:SetText(attrValue)
  else
    self._backNode:SetActive(false)
    self._specialBackNode:SetActive(true)
    self._specialRankImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._specialPropertyNameText:SetText(TextManager.GetText(attrRecord.classnameTextID))
    self._specialPropertyValueText:SetText(attrValue)
  end
  if data.attrRank >= self._delegate._superWordRank then
    if self._superWordEffectHandler == nil then
      self._superWordEffectHandler = self._superWordEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1103))
    end
  elseif self._superWordEffectHandler then
    self._superWordEffect:ReleaseEffect(self._superWordEffectHandler)
    self._superWordEffectHandler = nil
  end
end

return EquipFMCell
