local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local EquipListGemPropCell = class("EquipListGemPropCell", Dialog)
EquipListGemPropCell.AssetBundleName = "ui/layouts.equip"
EquipListGemPropCell.AssetName = "EquipTipsNewCell5"

function EquipListGemPropCell:Ctor(...)
  EquipListGemPropCell.super.Ctor(self, ...)
end

function EquipListGemPropCell:OnCreate()
  self._name = self:GetChild("Txt")
  self._num = self:GetChild("Num")
end

function EquipListGemPropCell:OnDestroy()
end

function EquipListGemPropCell:RefreshCell(data)
  local record = CAttrNameTable:GetRecorder(data.attrId)
  if record then
    self._name:SetText(TextManager.GetText(record.classnameTextID))
    self._num:SetText("+" .. math.ceil(data.value))
  end
end

return EquipListGemPropCell
