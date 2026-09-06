local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local EquipBookSuitInfoCell = class("EquipBookSuitInfoCell", Dialog)
EquipBookSuitInfoCell.AssetBundleName = "ui/layouts.tujian"
EquipBookSuitInfoCell.AssetName = "EquipBookSuitTitle"

function EquipBookSuitInfoCell:Ctor(...)
  EquipBookSuitInfoCell.super.Ctor(self, ...)
end

function EquipBookSuitInfoCell:OnCreate()
  self._image = self:GetChild("Suit")
  self._imageGrey = self:GetChild("SuitGrey")
  self._imageGrey:SetActive(false)
  self._text = self:GetChild("Txt")
end

function EquipBookSuitInfoCell:OnDestroy()
end

function EquipBookSuitInfoCell:RefreshCell(data)
  local imageRecord = CImagePathTable:GetRecorder(data.suitImg) or DataCommon.DefaultImageAsset
  self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local str
  str = TextManager.GetText(data.suitName)
  self._text:SetText(str)
end

return EquipBookSuitInfoCell
