local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ItemTipsUniqueEquipAttrCell = class("ItemTipsUniqueEquipAttrCell", Dialog)
ItemTipsUniqueEquipAttrCell.AssetBundleName = "ui/layouts.bag"
ItemTipsUniqueEquipAttrCell.AssetName = "ItemTipsNewEquipAttributeCell"

function ItemTipsUniqueEquipAttrCell:Ctor(...)
  ItemTipsUniqueEquipAttrCell.super.Ctor(self, ...)
end

function ItemTipsUniqueEquipAttrCell:OnCreate()
  self._icon = self:GetChild("Image")
  self._name = self:GetChild("Txt")
  self._num = self:GetChild("Num")
end

function ItemTipsUniqueEquipAttrCell:OnDestroy()
end

function ItemTipsUniqueEquipAttrCell:RefreshCell(data)
  local record = CAttrNameTable:GetRecorder(data.attrId)
  local imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._name:SetText(TextManager.GetText(record.classnameTextID))
  self._num:SetText(data.attrValue)
end

return ItemTipsUniqueEquipAttrCell
