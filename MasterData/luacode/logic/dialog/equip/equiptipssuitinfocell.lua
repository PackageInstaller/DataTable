local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local EquipTipsSuitInfoCell = class("EquipTipsSuitInfoCell", Dialog)
EquipTipsSuitInfoCell.AssetBundleName = "ui/layouts.equip"
EquipTipsSuitInfoCell.AssetName = "EquipTipsNewCellSuit1"

function EquipTipsSuitInfoCell:Ctor(...)
  EquipTipsSuitInfoCell.super.Ctor(self, ...)
end

function EquipTipsSuitInfoCell:OnCreate()
  self._image = self:GetChild("Suit")
  self._imageGrey = self:GetChild("SuitGrey")
  self._imageGrey:SetActive(false)
  self._text = self:GetChild("Txt")
end

function EquipTipsSuitInfoCell:OnDestroy()
end

function EquipTipsSuitInfoCell:RefreshCell(data)
  local imageRecord = CImagePathTable:GetRecorder(data.suitImg) or DataCommon.DefaultImageAsset
  self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local str
  str = TextManager.GetText(data.suitName)
  self._text:SetText(str)
end

return EquipTipsSuitInfoCell
