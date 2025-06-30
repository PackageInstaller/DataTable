-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipforge/equipstrengthensuccessdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CEquipItemTable = (BeanManager.GetTableByName)("item.cequipitem")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local EquipStrengthenSuccessDialog = class("EquipStrengthenSuccessDialog", Dialog)
EquipStrengthenSuccessDialog.AssetBundleName = "ui/layouts.equip"
EquipStrengthenSuccessDialog.AssetName = "EquipQHSuccess"
local SHOWTALKTYPE = {Evolve = 1, Break = 2}
local MillisecondToSecond = 1000
EquipStrengthenSuccessDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipStrengthenSuccessDialog
  ((EquipStrengthenSuccessDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._attrData = {}
end

EquipStrengthenSuccessDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._title = self:GetChild("Title")
  self._lvLeft = self:GetChild("Level/LeftPanel/LevelNum")
  self._lvLeftMax = self:GetChild("Level/LeftPanel/LevelMax")
  self._lvRight = self:GetChild("Level/RightPanel/LevelNum")
  self._lvRightMax = self:GetChild("Level/RightPanel/LevelMax")
  self._nextText = self:GetChild("Next")
  self._panel = self:GetChild("Property")
  self._attrFrame = (TableFrame.Create)(self._panel, self, true, false)
  self._effect = self:GetChild("Effect")
  ;
  (self._effect):Subscribe_UIEffectEndEvent(self.OnEffectEnd, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

EquipStrengthenSuccessDialog.OnDestroy = function(self)
  -- function num : 0_2
  if self._effectHandler then
    (self._effect):ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  ;
  (self._attrFrame):Destroy()
end

EquipStrengthenSuccessDialog.SetData = function(self, equip, preLv)
  -- function num : 0_3 , upvalues : _ENV, CEquipItemTable
  self._effectHandler = (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1079))
  ;
  (self._lvLeft):SetText(preLv)
  ;
  (self._lvLeftMax):SetText(equip:GetMaxLevel())
  ;
  (self._lvRight):SetText(equip:GetStrengthenLevel())
  ;
  (self._lvRightMax):SetText(equip:GetMaxLevel())
  local record = CEquipItemTable:GetRecorder(equip:GetID())
  for i,v in ipairs(record.abilityID) do
    local temp = {}
    temp.attrId = v
    temp.currentValue = (record.abilityValue)[i] * (record.initMagnify + (equip:GetStrengthenLevel() - 1) + equip:GetCurrentBreakMultiple())
    temp.lastValue = (record.abilityValue)[i] * (record.initMagnify + (preLv - 1) + equip:GetCurrentBreakMultiple())
    ;
    (table.insert)(self._attrData, temp)
  end
  ;
  (self._attrFrame):ReloadAllCell()
end

EquipStrengthenSuccessDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  if self._effectEnd then
    self:Destroy()
  end
end

EquipStrengthenSuccessDialog.OnEffectEnd = function(self)
  -- function num : 0_5
  self._effectEnd = true
end

EquipStrengthenSuccessDialog.NumberOfCell = function(self, frame)
  -- function num : 0_6
  if frame == self._attrFrame then
    return #self._attrData
  end
end

EquipStrengthenSuccessDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._attrFrame then
    return "equipforge.equipbreaksuccesspropcell"
  end
end

EquipStrengthenSuccessDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  if frame == self._attrFrame then
    return (self._attrData)[index]
  end
end

return EquipStrengthenSuccessDialog

