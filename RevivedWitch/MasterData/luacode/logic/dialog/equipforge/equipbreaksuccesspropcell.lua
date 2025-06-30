-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipforge/equipbreaksuccesspropcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local EquipBreakSuccessPropCell = class("EquipBreakSuccessPropCell", Dialog)
EquipBreakSuccessPropCell.AssetBundleName = "ui/layouts.equip"
EquipBreakSuccessPropCell.AssetName = "EquipTPSuccessProp"
EquipBreakSuccessPropCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipBreakSuccessPropCell
  ((EquipBreakSuccessPropCell.super).Ctor)(self, ...)
end

EquipBreakSuccessPropCell.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("Name")
  self._numLast = self:GetChild("Num")
  self._numCurrent = self:GetChild("Num2")
end

EquipBreakSuccessPropCell.OnDestroy = function(self)
  -- function num : 0_2
end

EquipBreakSuccessPropCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CAttrNameTable, _ENV
  local record = CAttrNameTable:GetRecorder(data.attrId)
  ;
  (self._name):SetText((TextManager.GetText)(record.classnameTextID))
  ;
  (self._numLast):SetText((math.ceil)(data.lastValue))
  ;
  (self._numCurrent):SetText((math.ceil)(data.currentValue))
end

return EquipBreakSuccessPropCell

