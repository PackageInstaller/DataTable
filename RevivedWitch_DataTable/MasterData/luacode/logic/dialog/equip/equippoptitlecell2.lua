-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/equippoptitlecell2.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EquipPopTitleCell2 = class("EquipPopTitleCell2", Dialog)
EquipPopTitleCell2.AssetBundleName = "ui/layouts.equip"
EquipPopTitleCell2.AssetName = "EquipPopTitleCell2"
EquipPopTitleCell2.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipPopTitleCell2
  ((EquipPopTitleCell2.super).Ctor)(self, ...)
end

EquipPopTitleCell2.OnCreate = function(self)
  -- function num : 0_1
end

EquipPopTitleCell2.OnDestroy = function(self)
  -- function num : 0_2
end

EquipPopTitleCell2.RefreshCell = function(self, data)
  -- function num : 0_3
end

return EquipPopTitleCell2

