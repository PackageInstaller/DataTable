local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local UniqueEquipUnlockAttrCell = class("UniqueEquipUnlockAttrCell", Dialog)
UniqueEquipUnlockAttrCell.AssetBundleName = "ui/layouts.baseshop"
UniqueEquipUnlockAttrCell.AssetName = "ExclusiveEquipGetCell"

function UniqueEquipUnlockAttrCell:Ctor(...)
  UniqueEquipUnlockAttrCell.super.Ctor(self, ...)
end

function UniqueEquipUnlockAttrCell:OnCreate()
  self._icon = self:GetChild("Prop/Image")
  self._name = self:GetChild("Prop/Name")
  self._num = self:GetChild("Prop/Num")
end

function UniqueEquipUnlockAttrCell:OnDestroy()
end

function UniqueEquipUnlockAttrCell:RefreshCell(data)
  local record = CAttrNameTable:GetRecorder(data.attrId)
  local imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._name:SetText(TextManager.GetText(record.classnameTextID))
  if record.isDecimal == 1 then
    local str = data.attrValue / 1000 * 100
    self._num:SetText(NekoData.BehaviorManager.BM_Message:GetString(1286, {str}))
  else
    self._num:SetText(data.attrValue)
  end
end

return UniqueEquipUnlockAttrCell
