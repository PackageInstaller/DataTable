local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CAttrEffectidNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local EquipChangeBasePropCell = class("EquipChangeBasePropCell", Dialog)

local function ReplacePercent(str)
  str = string.gsub(str, "%%", "%%%%")
  return str
end

EquipChangeBasePropCell.AssetBundleName = "ui/layouts.equip"
EquipChangeBasePropCell.AssetName = "EquipPopPropCell"

function EquipChangeBasePropCell:Ctor(...)
  EquipChangeBasePropCell.super.Ctor(self, ...)
end

function EquipChangeBasePropCell:OnCreate()
  self._image = self:GetChild("Image")
  self._name = self:GetChild("Name")
  self._num = self:GetChild("Num")
end

function EquipChangeBasePropCell:OnDestroy()
end

function EquipChangeBasePropCell:RefreshCell(data)
  local attrId = data.attrId - math.fmod(tonumber(data.attrId), 10)
  local attrRecord = CAttrEffectidNameTable:GetRecorder(attrId)
  local attrValue
  if attrRecord.isDecimal == 1 then
    attrValue = data.value / 1000 * 100
    local str = TextManager.GetText(CStringRes:GetRecorder(1286).msgTextID)
    attrValue = string.gsub(str, "%$parameter1%$", tostring(attrValue))
  else
    attrValue = data.value
  end
  self._name:SetText(TextManager.GetText(attrRecord.classnameTextID))
  self._num:SetText(math.ceil(attrValue))
end

return EquipChangeBasePropCell
