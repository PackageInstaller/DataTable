local CStringRes = BeanManager.GetTableByName("message.cstringres")
local EquipChangeNewPropCell = class("EquipChangeNewPropCell", Dialog)
EquipChangeNewPropCell.AssetBundleName = "ui/layouts.equip"
EquipChangeNewPropCell.AssetName = "EquipPopPropContrast"

function EquipChangeNewPropCell:Ctor(...)
  EquipChangeNewPropCell.super.Ctor(self, ...)
end

function EquipChangeNewPropCell:OnCreate()
  self._name = self:GetChild("Name")
  self._num = self:GetChild("Num")
end

function EquipChangeNewPropCell:OnDestroy()
end

function EquipChangeNewPropCell:RefreshCell(data)
  self._name:SetText(data.name)
  if data.value > 0 then
    data.value = math.ceil(data.value)
    local str = TextManager.GetText(CStringRes:GetRecorder(1205).msgTextID)
    str = string.gsub(str, "%$parameter1%$", tostring(data.value))
    self._num:SetText(str)
  elseif data.value < 0 then
    data.value = math.floor(data.value)
    local str = TextManager.GetText(CStringRes:GetRecorder(1206).msgTextID)
    str = string.gsub(str, "%$parameter1%$", tostring(data.value))
    self._num:SetText(str)
  elseif data.value == 0 then
    local str = TextManager.GetText(CStringRes:GetRecorder(1204).msgTextID)
    self._num:SetText(str)
  else
    self._num:SetText("")
  end
end

return EquipChangeNewPropCell
