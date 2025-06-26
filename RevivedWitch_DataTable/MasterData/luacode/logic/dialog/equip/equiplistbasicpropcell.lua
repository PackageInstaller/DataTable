-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/equiplistbasicpropcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local EquipListBasicPropCell = class("EquipListBasicPropCell", Dialog)
EquipListBasicPropCell.AssetBundleName = "ui/layouts.equip"
EquipListBasicPropCell.AssetName = "EquipListBasicProp"
EquipListBasicPropCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipListBasicPropCell
  ((EquipListBasicPropCell.super).Ctor)(self, ...)
end

EquipListBasicPropCell.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("Name")
  self._num = self:GetChild("Num")
end

EquipListBasicPropCell.OnDestroy = function(self)
  -- function num : 0_2
end

EquipListBasicPropCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CAttrNameTable, _ENV
  local record = CAttrNameTable:GetRecorder(data.attrId)
  if record then
    (self._name):SetText((TextManager.GetText)(record.classnameTextID))
    ;
    (self._num):SetText((math.ceil)(data.value))
  end
end

return EquipListBasicPropCell

