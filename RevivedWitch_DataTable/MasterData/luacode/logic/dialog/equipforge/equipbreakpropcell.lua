-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipforge/equipbreakpropcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local EquipBreakPropCell = class("EquipBreakPropCell", Dialog)
EquipBreakPropCell.AssetBundleName = "ui/layouts.equip"
EquipBreakPropCell.AssetName = "EquipTPPropCell"
EquipBreakPropCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipBreakPropCell
  ((EquipBreakPropCell.super).Ctor)(self, ...)
end

EquipBreakPropCell.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("Name")
  self._num = self:GetChild("Num")
end

EquipBreakPropCell.OnDestroy = function(self)
  -- function num : 0_2
end

EquipBreakPropCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CAttrNameTable, _ENV, CStringRes
  local record = CAttrNameTable:GetRecorder(data.attrId)
  ;
  (self._name):SetText((TextManager.GetText)(record.classnameTextID))
  local value = (math.ceil)((data.nextValue - data.currentValue) / data.currentValue * 100)
  local str = (TextManager.GetText)((CStringRes:GetRecorder(1205)).msgTextID)
  ;
  (self._num):SetText((string.gsub)(str, "%$parameter1%$", value))
end

return EquipBreakPropCell

