local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CAttrEffectidNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CRandomAbilityTable = BeanManager.GetTableByName("equip.crandomability")
local Cequipbreakcfg = BeanManager.GetTableByName("equip.cequipbreakcfg")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local EquipFMPropCell = class("EquipFMPropCell", Dialog)

local function ReplacePercent(str)
  str = string.gsub(str, "%%", "%%%%")
  return str
end

EquipFMPropCell.AssetBundleName = "ui/layouts.equip"
EquipFMPropCell.AssetName = "EquipFMProp"

function EquipFMPropCell:Ctor(...)
  EquipFMPropCell.super.Ctor(self, ...)
  self.canClick = true
end

function EquipFMPropCell:OnCreate()
  self._num = self:GetChild("Num")
  self._name = self:GetChild("Txt1")
  self._range = self:GetChild("Txt2")
  self._toggle = self:GetChild("_Toggle_0")
  self._back = self:GetChild("Back")
  self._backSelect = self:GetChild("BackSelect")
  self._toggle:SetInteractable(false)
  self._toggle:Subscribe_PointerClickEvent(self.OnToggleClicked, self)
end

function EquipFMPropCell:OnDestroy()
end

function EquipFMPropCell:RefreshCell(data)
  local attrId = data.attrId - math.fmod(tonumber(data.attrId), 10)
  local attrRecord = CAttrEffectidNameTable:GetRecorder(attrId)
  self._name:SetText(TextManager.GetText(attrRecord.classnameTextID))
  local attrRangeRecord = CRandomAbilityTable:GetRecorder(data.randomAbilityId).attrRange
  local num1, num2 = string.match(attrRangeRecord, "(%d+);(%d+)")
  local attrValue
  if attrRecord.isDecimal == 1 then
    attrValue = data.value / 1000 * 100
    num1 = num1 / 1000 * 100
    num2 = num2 / 1000 * 100
    local str = TextManager.GetText(CStringRes:GetRecorder(1286).msgTextID)
    attrValue = string.gsub(str, "%$parameter1%$", tostring(attrValue))
    num1 = string.gsub(str, "%$parameter1%$", tostring(num1))
    num2 = string.gsub(str, "%$parameter1%$", tostring(num2))
  else
    attrValue = data.value
  end
  self._num:SetText(attrValue)
  if data.unLock then
    local str1 = TextManager.GetText(CStringRes:GetRecorder(1200).msgTextID)
    str1 = string.gsub(str1, "%$parameter1%$", ReplacePercent(num1))
    str1 = string.gsub(str1, "%$parameter2%$", ReplacePercent(num2))
    self._range:SetText(str1)
  else
    local cequipbreakcfgAll = Cequipbreakcfg:GetAllIds()
    local unlockStage
    for i, id in pairs(cequipbreakcfgAll) do
      local record = Cequipbreakcfg:GetRecorder(id)
      if self._delegate._equip:GetPinJiID() == record.pinJi and data.randomIndex == record.unlockAbilityNum then
        unlockStage = record.breaklv
        break
      end
    end
    if unlockStage then
      local str1 = TextManager.GetText(CStringRes:GetRecorder(1209).msgTextID)
      str1 = string.gsub(str1, "%$parameter1%$", ReplacePercent(num1))
      str1 = string.gsub(str1, "%$parameter2%$", ReplacePercent(num2))
      str1 = string.gsub(str1, "%$parameter3%$", tostring(unlockStage))
      self._range:SetText(str1)
    else
      local str1 = TextManager.GetText(CStringRes:GetRecorder(1200).msgTextID)
      str1 = string.gsub(str1, "%$parameter1%$", ReplacePercent(num1))
      str1 = string.gsub(str1, "%$parameter2%$", ReplacePercent(num2))
      self._range:SetText(str1)
      LogError("EquipFMPropCell:", "Reading table Cequipbreakcfg failed")
    end
  end
  if self._delegate._equip:GetRandomIndex() == 0 then
    self.canClick = true
  else
    self.canClick = false
    if data.randomIndex == self._delegate._equip:GetRandomIndex() then
      self._delegate:DisabledAllToggle()
      self._delegate._selectedWordId = self._cellData.randomIndex
      self._toggle:SetIsOnType(true)
      self._backSelect:SetActive(true)
    else
      self._toggle:SetIsOnType(false)
      self._backSelect:SetActive(false)
    end
  end
end

function EquipFMPropCell:OnToggleClicked()
  if self.canClick then
    self._delegate:OnToggleClicked(self._cellData.randomIndex)
  end
end

function EquipFMPropCell:OnEvent(eventName, arg)
  if eventName == "OffAllToggle" then
    if arg == self._cellData.randomIndex then
      self._toggle:SetIsOnType(true)
      self._backSelect:SetActive(true)
    else
      self._toggle:SetIsOnType(false)
      self._backSelect:SetActive(false)
    end
  elseif eventName == "DisabledAllToggle" then
    self._toggle:SetInteractable(false)
  end
end

return EquipFMPropCell
