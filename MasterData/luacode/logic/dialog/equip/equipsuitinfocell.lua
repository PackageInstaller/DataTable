local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local EquipSuitInfoCell = class("EquipSuitInfoCell", Dialog)
EquipSuitInfoCell.AssetBundleName = "ui/layouts.equip"
EquipSuitInfoCell.AssetName = "EquipListSuit1"

function EquipSuitInfoCell:Ctor(...)
  EquipSuitInfoCell.super.Ctor(self, ...)
end

function EquipSuitInfoCell:OnCreate()
  self._image = self:GetChild("Suit")
  self._imageGrey = self:GetChild("SuitGrey")
  self._imageGrey:SetActive(false)
  self._text = self:GetChild("Txt")
end

function EquipSuitInfoCell:OnDestroy()
end

function EquipSuitInfoCell:RefreshCell(data)
  local imageRecord = CImagePathTable:GetRecorder(data.suitImg) or DataCommon.DefaultImageAsset
  self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local str
  str = TextManager.GetText(data.suitName)
  self._text:SetText(str)
end

return EquipSuitInfoCell
