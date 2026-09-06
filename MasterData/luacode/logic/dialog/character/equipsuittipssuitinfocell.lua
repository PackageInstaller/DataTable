local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local EquipSuitTipsSuitInfoCell = class("EquipSuitTipsSuitInfoCell", Dialog)
EquipSuitTipsSuitInfoCell.AssetBundleName = "ui/layouts.basecharacterinfo"
EquipSuitTipsSuitInfoCell.AssetName = "EquipSuitTipsCell1"

function EquipSuitTipsSuitInfoCell:Ctor(...)
  EquipSuitTipsSuitInfoCell.super.Ctor(self, ...)
end

function EquipSuitTipsSuitInfoCell:OnCreate()
  self._image = self:GetChild("Suit")
  self._imageGrey = self:GetChild("SuitGrey")
  self._imageGrey:SetActive(false)
  self._text = self:GetChild("Name")
end

function EquipSuitTipsSuitInfoCell:OnDestroy()
end

function EquipSuitTipsSuitInfoCell:RefreshCell(data)
  local imageRecord = CImagePathTable:GetRecorder(data.suitImg) or DataCommon.DefaultImageAsset
  self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local str
  str = TextManager.GetText(data.suitName)
  self._text:SetText(str)
end

return EquipSuitTipsSuitInfoCell
