local CRankShow = BeanManager.GetTableByName("equip.crankshow")
local CAttrEffectidNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CRandomAbilityTable = BeanManager.GetTableByName("equip.crandomability")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local EquipFMResultTipDialog = class("EquipFMResultTipDialog", Dialog)
EquipFMResultTipDialog.AssetBundleName = "ui/layouts.equip"
EquipFMResultTipDialog.AssetName = "EquipFMTips"

function EquipFMResultTipDialog:Ctor(...)
  EquipFMResultTipDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._timer = 0
  self._totalTime = 2
end

function EquipFMResultTipDialog:OnCreate()
  self._rankImage = self:GetChild("BackImage/Back/LevelImg")
  self._propertyNameText = self:GetChild("BackImage/Back/Txt1")
  self._propertyValueText = self:GetChild("BackImage/Back/Num")
  self._tipText = self:GetChild("BackImage/Text")
  self._rootWindow:Subscribe_UpdateEvent(self.OnUpdate, self)
end

function EquipFMResultTipDialog:OnDestroy()
end

function EquipFMResultTipDialog:OnUpdate(deltaTime)
  self._timer = self._timer + deltaTime
  if self._timer > self._totalTime then
    self:Destroy()
  end
end

function EquipFMResultTipDialog:Refresh(data)
  local rankShowRecord = CRankShow:GetRecorder(data.newAttrRank)
  local imageRecord = CImagePathTable:GetRecorder(rankShowRecord.imgid)
  self._rankImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local attrId = data.newAttrId - math.fmod(tonumber(data.newAttrId), 10)
  local attrRecord = CAttrEffectidNameTable:GetRecorder(attrId)
  self._propertyNameText:SetText(TextManager.GetText(attrRecord.classnameTextID))
  local cRandomAbilityRecord = CRandomAbilityTable:GetRecorder(data.newRandomAbilityId)
  local num1, num2 = string.match(cRandomAbilityRecord.attrRange, "(%d+);(%d+)")
  local attrValue
  if attrRecord.isDecimal == 1 then
    attrValue = data.newValue / 1000 * 100
    num1 = num1 / 1000 * 100
    num2 = num2 / 1000 * 100
    local str = TextManager.GetText(CStringRes:GetRecorder(1286).msgTextID)
    attrValue = string.gsub(str, "%$parameter1%$", tostring(attrValue))
    num1 = string.gsub(str, "%$parameter1%$", tostring(num1))
    num2 = string.gsub(str, "%$parameter1%$", tostring(num2))
  else
    attrValue = data.newValue
  end
  self._propertyValueText:SetText(attrValue)
  local tip = TextManager.GetText(CStringRes:GetRecorder(1382).msgTextID)
  self._tipText:SetText(tip)
end

return EquipFMResultTipDialog
