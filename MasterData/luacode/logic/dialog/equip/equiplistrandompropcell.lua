local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CAttrEffectidNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CRandomAbilityTable = BeanManager.GetTableByName("equip.crandomability")
local Cequipbreakcfg = BeanManager.GetTableByName("equip.cequipbreakcfg")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CWordColor = BeanManager.GetTableByName("message.cwordcolor")
local EquipListRandomPropCell = class("EquipListRandomPropCell", Dialog)

local function ReplacePercent(str)
  str = string.gsub(str, "%%", "%%%%")
  return str
end

EquipListRandomPropCell.AssetBundleName = "ui/layouts.equip"
EquipListRandomPropCell.AssetName = "EquipListRandomProp"

function EquipListRandomPropCell:Ctor(...)
  EquipListRandomPropCell.super.Ctor(self, ...)
end

function EquipListRandomPropCell:OnCreate()
  self._image = self:GetChild("Image")
  self._name = self:GetChild("Name")
  self._num = self:GetChild("Num")
end

function EquipListRandomPropCell:OnDestroy()
end

function EquipListRandomPropCell:RefreshCell(data)
  local attrId = data.attrId - math.fmod(tonumber(data.attrId), 10)
  local attrRecord = CAttrEffectidNameTable:GetRecorder(attrId)
  local imageRecord, color
  if data.kind == 3 then
    imageRecord = CImagePathTable:GetRecorder(12124) or DataCommon.DefaultImageAsset
    color = CWordColor:GetRecorder(33).wordcolor
  else
    imageRecord = CImagePathTable:GetRecorder(11469) or DataCommon.DefaultImageAsset
    color = CWordColor:GetRecorder(32).wordcolor
  end
  self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local attrValue
  if attrRecord.isDecimal == 1 then
    attrValue = data.value / 1000 * 100
    local str = TextManager.GetText(CStringRes:GetRecorder(1286).msgTextID)
    attrValue = string.gsub(str, "%$parameter1%$", tostring(attrValue))
  else
    attrValue = data.value
  end
  local numText = TextManager.GetText(CStringRes:GetRecorder(1079).msgTextID)
  numText = string.gsub(numText, "%$parameter1%$", ReplacePercent(attrValue))
  self._name:SetText("<color=#" .. color .. ">" .. TextManager.GetText(attrRecord.classnameTextID) .. "</color>")
  self._num:SetText("<color=#" .. color .. ">" .. numText .. "</color>")
end

return EquipListRandomPropCell
