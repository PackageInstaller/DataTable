-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/equippoptitlecell1.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EquipPopTitleCell1 = class("EquipPopTitleCell1", Dialog)
EquipPopTitleCell1.AssetBundleName = "ui/layouts.equip"
EquipPopTitleCell1.AssetName = "EquipPopTitleCell1"
EquipPopTitleCell1.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipPopTitleCell1
  ((EquipPopTitleCell1.super).Ctor)(self, ...)
end

EquipPopTitleCell1.OnCreate = function(self)
  -- function num : 0_1
end

EquipPopTitleCell1.OnDestroy = function(self)
  -- function num : 0_2
end

EquipPopTitleCell1.RefreshCell = function(self, data)
  -- function num : 0_3
end

return EquipPopTitleCell1

