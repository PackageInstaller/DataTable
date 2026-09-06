local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local EquipBookAttrCell = class("EquipBookAttrCell", Dialog)
EquipBookAttrCell.AssetBundleName = "ui/layouts.tujian"
EquipBookAttrCell.AssetName = "EquipBookPropertyCell"

function EquipBookAttrCell:Ctor(...)
  EquipBookAttrCell.super.Ctor(self, ...)
end

function EquipBookAttrCell:OnCreate()
  self._image = self:GetChild("Image")
  self._name = self:GetChild("Name")
  self._num = self:GetChild("Num")
end

function EquipBookAttrCell:OnDestroy()
end

function EquipBookAttrCell:RefreshCell(data)
  local record = CAttrNameTable:GetRecorder(data.attrId)
  local imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.attrValue then
    self._name:SetText(TextManager.GetText(record.classnameTextID))
    self._num:SetText(data.attrValue)
  elseif data.attrGrowthValue then
    self._name:SetText(TextManager.GetText(record.classgrowthnameTextID))
    self._num:SetText(data.attrGrowthValue)
  end
end

return EquipBookAttrCell
