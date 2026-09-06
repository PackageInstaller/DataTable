local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CAttrEffectidNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CRandomAbilityTable = BeanManager.GetTableByName("equip.crandomability")
local Cequipbreakcfg = BeanManager.GetTableByName("equip.cequipbreakcfg")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CRankShow = BeanManager.GetTableByName("equip.crankshow")
local EquipFMResultCell = class("EquipFMResultCell", Dialog)

local function ReplacePercent(str)
  str = string.gsub(str, "%%", "%%%%")
  return str
end

EquipFMResultCell.AssetBundleName = "ui/layouts.equip"
EquipFMResultCell.AssetName = "EquipFMResultCell"

function EquipFMResultCell:Ctor(...)
  EquipFMResultCell.super.Ctor(self, ...)
  self._superWordEffectHandler = nil
end

function EquipFMResultCell:OnCreate()
  self._oldLockNode = self:GetChild("Cell1/Lock")
  self._oldBackNode = self:GetChild("Cell1/Back")
  self._oldRankImage = self:GetChild("Cell1/Back/LevelImg")
  self._oldNameText = self:GetChild("Cell1/Back/Txt1")
  self._oldValueText = self:GetChild("Cell1/Back/Num")
  self._newRankImage = self:GetChild("Cell2/Back/LevelImg")
  self._newNameText = self:GetChild("Cell2/Back/Txt1")
  self._newValueText = self:GetChild("Cell2/Back/Num")
  self._superWordEffect = self:GetChild("Cell2/Effect")
end

function EquipFMResultCell:OnDestroy()
end

function EquipFMResultCell:RefreshCell(data)
  local rankShowRecord, attrId, attrRecord, randomAbilityRecord, num1, num2, attrValue, imageRecord
  if data.isNew then
    self._oldLockNode:SetActive(true)
    self._oldBackNode:SetActive(false)
  else
    self._oldLockNode:SetActive(false)
    self._oldBackNode:SetActive(true)
    randomAbilityRecord = CRandomAbilityTable:GetRecorder(data.oldRandomAbilityId)
    rankShowRecord = CRankShow:GetRecorder(data.oldAttrRank)
    imageRecord = CImagePathTable:GetRecorder(rankShowRecord.imgid)
    self._oldRankImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    attrId = data.oldAttrId - math.fmod(tonumber(data.oldAttrId), 10)
    attrRecord = CAttrEffectidNameTable:GetRecorder(attrId)
    self._oldNameText:SetText(TextManager.GetText(attrRecord.classnameTextID))
    num1, num2 = string.match(randomAbilityRecord.attrRange, "(%d+);(%d+)")
    if attrRecord.isDecimal == 1 then
      attrValue = data.oldValue / 1000 * 100
      num1 = num1 / 1000 * 100
      num2 = num2 / 1000 * 100
      local str = TextManager.GetText(CStringRes:GetRecorder(1286).msgTextID)
      attrValue = string.gsub(str, "%$parameter1%$", tostring(attrValue))
      num1 = string.gsub(str, "%$parameter1%$", tostring(num1))
      num2 = string.gsub(str, "%$parameter1%$", tostring(num2))
    else
      attrValue = data.oldValue
    end
    self._oldValueText:SetText(attrValue)
  end
  randomAbilityRecord = CRandomAbilityTable:GetRecorder(data.newRandomAbilityId)
  rankShowRecord = CRankShow:GetRecorder(data.newAttrRank)
  imageRecord = CImagePathTable:GetRecorder(rankShowRecord.imgid)
  self._newRankImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  attrId = data.newAttrId - math.fmod(tonumber(data.newAttrId), 10)
  attrRecord = CAttrEffectidNameTable:GetRecorder(attrId)
  self._newNameText:SetText(TextManager.GetText(attrRecord.classnameTextID))
  if attrRecord.isDecimal == 1 then
    attrValue = data.newValue / 1000 * 100
    local str = TextManager.GetText(CStringRes:GetRecorder(1286).msgTextID)
    attrValue = string.gsub(str, "%$parameter1%$", tostring(attrValue))
  else
    attrValue = data.newValue
  end
  self._newValueText:SetText(attrValue)
  if data.newAttrRank >= self._delegate._superWordRank then
    if self._superWordEffectHandler == nil then
      self._superWordEffectHandler = self._superWordEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1105))
    end
  elseif self._superWordEffectHandler then
    self._superWordEffect:ReleaseEffect(self._superWordEffectHandler)
    self._superWordEffectHandler = nil
  end
end

return EquipFMResultCell
