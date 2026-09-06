local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local EquipBreakSuccessPropCell = class("EquipBreakSuccessPropCell", Dialog)
EquipBreakSuccessPropCell.AssetBundleName = "ui/layouts.equip"
EquipBreakSuccessPropCell.AssetName = "EquipTPSuccessProp"

function EquipBreakSuccessPropCell:Ctor(...)
  EquipBreakSuccessPropCell.super.Ctor(self, ...)
end

function EquipBreakSuccessPropCell:OnCreate()
  self._name = self:GetChild("Name")
  self._numLast = self:GetChild("Num")
  self._numCurrent = self:GetChild("Num2")
end

function EquipBreakSuccessPropCell:OnDestroy()
end

function EquipBreakSuccessPropCell:RefreshCell(data)
  local record = CAttrNameTable:GetRecorder(data.attrId)
  self._name:SetText(TextManager.GetText(record.classnameTextID))
  self._numLast:SetText(math.ceil(data.lastValue))
  self._numCurrent:SetText(math.ceil(data.currentValue))
end

return EquipBreakSuccessPropCell
