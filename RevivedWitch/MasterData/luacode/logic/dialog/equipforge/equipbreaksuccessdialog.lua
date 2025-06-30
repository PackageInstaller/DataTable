-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipforge/equipbreaksuccessdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CEquipItemTable = (BeanManager.GetTableByName)("item.cequipitem")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local EquipBreakSuccessDialog = class("EquipBreakSuccessDialog", Dialog)
EquipBreakSuccessDialog.AssetBundleName = "ui/layouts.equip"
EquipBreakSuccessDialog.AssetName = "EquipTPSuccess"
local SHOWTALKTYPE = {Evolve = 1, Break = 2}
local MillisecondToSecond = 1000
EquipBreakSuccessDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipBreakSuccessDialog
  ((EquipBreakSuccessDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._attrData = {}
end

EquipBreakSuccessDialog.OnCreate = function(self)
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
  self._breakPointPanel = self:GetChild("BreakPoint")
  self._breakPoint1 = self:GetChild("BreakPoint/BreakPoint1")
  self._breakPoint2 = self:GetChild("BreakPoint/BreakPoint2")
  ;
  (self._effect):Subscribe_UIEffectEndEvent(self.OnEffectEnd, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

EquipBreakSuccessDialog.OnDestroy = function(self)
  -- function num : 0_2
  if self._effectHandler then
    (self._effect):ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  ;
  (self._attrFrame):Destroy()
end

EquipBreakSuccessDialog.SetData = function(self, equip)
  -- function num : 0_3 , upvalues : _ENV, CEquipItemTable
  self._effectHandler = (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1080))
  ;
  (self._lvLeft):SetText(equip:GetStrengthenLevel())
  ;
  (self._lvLeftMax):SetText(equip:GetStrengthenLevel())
  ;
  (self._lvRight):SetText(equip:GetStrengthenLevel())
  ;
  (self._lvRightMax):SetText(equip:GetMaxLevel())
  local record = CEquipItemTable:GetRecorder(equip:GetID())
  for i,v in ipairs(record.abilityID) do
    local temp = {}
    temp.attrId = v
    temp.currentValue = (record.abilityValue)[i] * (record.initMagnify + (equip:GetStrengthenLevel() - 1) + equip:GetCurrentBreakMultiple())
    temp.lastValue = (record.abilityValue)[i] * (record.initMagnify + (equip:GetStrengthenLevel() - 1) + equip:GetLastBreakMultiple())
    ;
    (table.insert)(self._attrData, temp)
  end
  if equip:GetStage() == equip:GetBreaKLimitTimes() then
    (self._breakPoint1):SetText(equip:GetEquipNotFullStarStr())
    ;
    (self._breakPoint2):SetText(equip:GetEquipFullStarStr())
    ;
    (self._breakPointPanel):SetActive(true)
  else
    ;
    (self._breakPointPanel):SetActive(false)
  end
  ;
  (self._attrFrame):ReloadAllCell()
end

EquipBreakSuccessDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  if self._effectEnd then
    self:Destroy()
  end
end

EquipBreakSuccessDialog.OnEffectEnd = function(self)
  -- function num : 0_5
  self._effectEnd = true
end

EquipBreakSuccessDialog.NumberOfCell = function(self, frame)
  -- function num : 0_6
  if frame == self._attrFrame then
    return #self._attrData
  end
end

EquipBreakSuccessDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._attrFrame then
    return "equipforge.equipbreaksuccesspropcell"
  end
end

EquipBreakSuccessDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  if frame == self._attrFrame then
    return (self._attrData)[index]
  end
end

return EquipBreakSuccessDialog

