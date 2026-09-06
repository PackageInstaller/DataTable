local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local EquipPropertyCell = class("EquipPropertyCell", Dialog)
EquipPropertyCell.AssetBundleName = "ui/layouts.basecharacterinfo"
EquipPropertyCell.AssetName = "BaseCharacterInfoEquipPropertyCell"

function EquipPropertyCell:Ctor(...)
  EquipPropertyCell.super.Ctor(self, ...)
end

function EquipPropertyCell:OnCreate()
  self._name = self:GetChild("PropertyName")
  self._num = self:GetChild("PropertyNum")
end

function EquipPropertyCell:RefreshCell(data)
  local record = CAttrNameTable:GetRecorder(data.attrKey)
  self._name:SetText(TextManager.GetText(record.classnameTextID))
  if record.isDecimal == 1 then
    self._num:SetText(tostring(data.value / 10) .. "%")
  else
    self._num:SetText(data.value)
  end
end

return EquipPropertyCell
