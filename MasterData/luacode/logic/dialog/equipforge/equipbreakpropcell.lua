local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local EquipBreakPropCell = class("EquipBreakPropCell", Dialog)
EquipBreakPropCell.AssetBundleName = "ui/layouts.equip"
EquipBreakPropCell.AssetName = "EquipTPPropCell"

function EquipBreakPropCell:Ctor(...)
  EquipBreakPropCell.super.Ctor(self, ...)
end

function EquipBreakPropCell:OnCreate()
  self._name = self:GetChild("Name")
  self._num = self:GetChild("Num")
end

function EquipBreakPropCell:OnDestroy()
end

function EquipBreakPropCell:RefreshCell(data)
  local record = CAttrNameTable:GetRecorder(data.attrId)
  self._name:SetText(TextManager.GetText(record.classnameTextID))
  local value = math.ceil((data.nextValue - data.currentValue) / data.currentValue * 100)
  local str = TextManager.GetText(CStringRes:GetRecorder(1205).msgTextID)
  self._num:SetText(string.gsub(str, "%$parameter1%$", value))
end

return EquipBreakPropCell
