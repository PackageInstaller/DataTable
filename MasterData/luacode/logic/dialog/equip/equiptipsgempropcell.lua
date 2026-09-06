local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local EquipTipsGemPropCell = class("EquipTipsGemPropCell", Dialog)
EquipTipsGemPropCell.AssetBundleName = "ui/layouts.equip"
EquipTipsGemPropCell.AssetName = "EquipTipsNewCell6"

function EquipTipsGemPropCell:Ctor(...)
  EquipTipsGemPropCell.super.Ctor(self, ...)
end

function EquipTipsGemPropCell:OnCreate()
  self._name = self:GetChild("Txt")
  self._num = self:GetChild("Num")
end

function EquipTipsGemPropCell:OnDestroy()
end

function EquipTipsGemPropCell:RefreshCell(data)
  local record = CAttrNameTable:GetRecorder(data.attrId)
  if record then
    self._name:SetText(TextManager.GetText(record.classnameTextID))
    self._num:SetText("+" .. math.ceil(data.value))
  end
end

return EquipTipsGemPropCell
