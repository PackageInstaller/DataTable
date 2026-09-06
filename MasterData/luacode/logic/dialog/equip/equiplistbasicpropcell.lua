local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local EquipListBasicPropCell = class("EquipListBasicPropCell", Dialog)
EquipListBasicPropCell.AssetBundleName = "ui/layouts.equip"
EquipListBasicPropCell.AssetName = "EquipListBasicProp"

function EquipListBasicPropCell:Ctor(...)
  EquipListBasicPropCell.super.Ctor(self, ...)
end

function EquipListBasicPropCell:OnCreate()
  self._name = self:GetChild("Name")
  self._num = self:GetChild("Num")
end

function EquipListBasicPropCell:OnDestroy()
end

function EquipListBasicPropCell:RefreshCell(data)
  local record = CAttrNameTable:GetRecorder(data.attrId)
  if record then
    self._name:SetText(TextManager.GetText(record.classnameTextID))
    self._num:SetText(math.ceil(data.value))
  end
end

return EquipListBasicPropCell
