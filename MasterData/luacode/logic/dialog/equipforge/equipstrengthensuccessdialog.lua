local TableFrame = require("framework.ui.frame.table.tableframe")
local CEquipItemTable = BeanManager.GetTableByName("item.cequipitem")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local EquipStrengthenSuccessDialog = class("EquipStrengthenSuccessDialog", Dialog)
EquipStrengthenSuccessDialog.AssetBundleName = "ui/layouts.equip"
EquipStrengthenSuccessDialog.AssetName = "EquipQHSuccess"
local SHOWTALKTYPE = {Evolve = 1, Break = 2}
local MillisecondToSecond = 1000

function EquipStrengthenSuccessDialog:Ctor(...)
  EquipStrengthenSuccessDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._attrData = {}
end

function EquipStrengthenSuccessDialog:OnCreate()
  self._title = self:GetChild("Title")
  self._lvLeft = self:GetChild("Level/LeftPanel/LevelNum")
  self._lvLeftMax = self:GetChild("Level/LeftPanel/LevelMax")
  self._lvRight = self:GetChild("Level/RightPanel/LevelNum")
  self._lvRightMax = self:GetChild("Level/RightPanel/LevelMax")
  self._nextText = self:GetChild("Next")
  self._panel = self:GetChild("Property")
  self._attrFrame = TableFrame.Create(self._panel, self, true, false)
  self._effect = self:GetChild("Effect")
  self._effect:Subscribe_UIEffectEndEvent(self.OnEffectEnd, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function EquipStrengthenSuccessDialog:OnDestroy()
  if self._effectHandler then
    self._effect:ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  self._attrFrame:Destroy()
end

function EquipStrengthenSuccessDialog:SetData(equip, preLv)
  self._effectHandler = self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1079))
  self._lvLeft:SetText(preLv)
  self._lvLeftMax:SetText(equip:GetMaxLevel())
  self._lvRight:SetText(equip:GetStrengthenLevel())
  self._lvRightMax:SetText(equip:GetMaxLevel())
  local record = CEquipItemTable:GetRecorder(equip:GetID())
  for i, v in ipairs(record.abilityID) do
    local temp = {}
    temp.attrId = v
    temp.currentValue = record.abilityValue[i] * (record.initMagnify + (equip:GetStrengthenLevel() - 1) + equip:GetCurrentBreakMultiple()) * (1 + equip:GetGemSuitAttrRate(v))
    temp.lastValue = record.abilityValue[i] * (record.initMagnify + (preLv - 1) + equip:GetCurrentBreakMultiple()) * (1 + equip:GetGemSuitAttrRate(v))
    table.insert(self._attrData, temp)
  end
  self._attrFrame:ReloadAllCell()
end

function EquipStrengthenSuccessDialog:OnBackBtnClicked()
  if self._effectEnd then
    self:Destroy()
  end
end

function EquipStrengthenSuccessDialog:OnEffectEnd()
  self._effectEnd = true
end

function EquipStrengthenSuccessDialog:NumberOfCell(frame)
  if frame == self._attrFrame then
    return #self._attrData
  end
end

function EquipStrengthenSuccessDialog:CellAtIndex(frame, index)
  if frame == self._attrFrame then
    return "equipforge.equipbreaksuccesspropcell"
  end
end

function EquipStrengthenSuccessDialog:DataAtIndex(frame, index)
  if frame == self._attrFrame then
    return self._attrData[index]
  end
end

return EquipStrengthenSuccessDialog
