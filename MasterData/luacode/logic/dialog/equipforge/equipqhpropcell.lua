local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local EquipQHPropCell = class("EquipQHPropCell", Dialog)
EquipQHPropCell.AssetBundleName = "ui/layouts.equip"
EquipQHPropCell.AssetName = "EquipQHProp"

function EquipQHPropCell:Ctor(...)
  EquipQHPropCell.super.Ctor(self, ...)
end

function EquipQHPropCell:OnCreate()
  self._back = self:GetChild("Back")
  self._name = self:GetChild("Txt1")
  self._num = self:GetChild("Num")
  self._addNum = self:GetChild("Txt2")
  self._addNum:SetText("")
end

function EquipQHPropCell:OnDestroy()
end

function EquipQHPropCell:RefreshCell(data)
  if data.noData then
    self._name:SetActive(false)
    self._num:SetActive(false)
    self._back:SetActive(false)
    return
  else
    self._name:SetActive(true)
    self._num:SetActive(true)
    self._back:SetActive(true)
  end
  local record = CAttrNameTable:GetRecorder(data.attrId)
  self._name:SetText(TextManager.GetText(record.classnameTextID))
  if data.param1 then
    local newValue = math.ceil(data.param1 * (data.param2 + self._delegate.addLv + data.curLv - 1))
    local addValue = newValue - math.ceil(data.value)
    local str = TextManager.GetText(CStringRes:GetRecorder(1079).msgTextID)
    str = string.gsub(str, "%$parameter1%$", tostring(addValue))
    self._addNum:SetText(str)
  else
    self._addNum:SetText("")
  end
  local num = data.value
  self._num:SetText(math.ceil(num))
end

return EquipQHPropCell
