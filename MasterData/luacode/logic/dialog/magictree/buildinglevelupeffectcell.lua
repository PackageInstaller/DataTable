local CStringres = BeanManager.GetTableByName("message.cstringres")
local CCourtyardLvUpEffect = BeanManager.GetTableByName("courtyard.ccourtyardlvupeffect")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local BuildingLevelUpEffectCell = class("BuildingLevelUpEffectCell", Dialog)
BuildingLevelUpEffectCell.AssetBundleName = "ui/layouts.yard"
BuildingLevelUpEffectCell.AssetName = "MagicTreeLevelUpEffectCell"

function BuildingLevelUpEffectCell:Ctor(...)
  BuildingLevelUpEffectCell.super.Ctor(self, ...)
end

function BuildingLevelUpEffectCell:OnCreate()
  self._icon = self:GetChild("Image")
  self._normalTxt = self:GetChild("Txt")
  self._curEffectTxt = self:GetChild("Txt1")
  self._nextEffectTxt = self:GetChild("Txt1/Arrow/Txt2")
  self._curEffectWidth, self._curEffectHeight = self._curEffectTxt:GetDeltaSize()
  self._nextEffectWidth, self._nextEffectHeight = self._nextEffectTxt:GetDeltaSize()
end

function BuildingLevelUpEffectCell:OnDestroy()
end

function BuildingLevelUpEffectCell:RefreshCell(data)
  local record = CCourtyardLvUpEffect:GetRecorder(data)
  local imageRecord = CImagePathTable:GetRecorder(record.iconid) or DataCommon.DefaultImageAsset
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if record.effecttype == 1 then
    self._normalTxt:SetActive(false)
    self._curEffectTxt:SetActive(true)
    local str = TextManager.GetText(record.textid)
    local strList = string.split(str, ";")
    self._curEffectTxt:SetText(strList[1] .. strList[2])
    local textWidth, textHeight = self._curEffectTxt:GetPreferredSize()
    self._curEffectTxt:SetDeltaSize(textWidth, self._curEffectHeight)
    self._nextEffectTxt:SetText(strList[3])
    textWidth, textHeight = self._nextEffectTxt:GetPreferredSize()
    self._nextEffectTxt:SetDeltaSize(textWidth, self._nextEffectHeight)
  else
    self._normalTxt:SetActive(true)
    self._curEffectTxt:SetActive(false)
    self._normalTxt:SetText(TextManager.GetText(record.textid))
  end
end

return BuildingLevelUpEffectCell
