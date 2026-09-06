local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local UniqueEquipBuyAttrCell = class("UniqueEquipBuyAttrCell", Dialog)
UniqueEquipBuyAttrCell.AssetBundleName = "ui/layouts.baseshop"
UniqueEquipBuyAttrCell.AssetName = "ExclusiveEquipBuyCell"

function UniqueEquipBuyAttrCell:Ctor(...)
  UniqueEquipBuyAttrCell.super.Ctor(self, ...)
end

function UniqueEquipBuyAttrCell:OnCreate()
  self._icon = self:GetChild("Prop/Image")
  self._name = self:GetChild("Prop/Name")
  self._num = self:GetChild("Prop/Num")
end

function UniqueEquipBuyAttrCell:OnDestroy()
end

function UniqueEquipBuyAttrCell:RefreshCell(data)
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

return UniqueEquipBuyAttrCell
