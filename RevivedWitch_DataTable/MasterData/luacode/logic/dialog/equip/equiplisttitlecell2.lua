-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/equiplisttitlecell2.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EquipListTitleCell2 = class("EquipListTitleCell2", Dialog)
EquipListTitleCell2.AssetBundleName = "ui/layouts.equip"
EquipListTitleCell2.AssetName = "EquipListTitleCell2"
EquipListTitleCell2.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipListTitleCell2
  ((EquipListTitleCell2.super).Ctor)(self, ...)
end

EquipListTitleCell2.OnCreate = function(self)
  -- function num : 0_1
end

EquipListTitleCell2.OnDestroy = function(self)
  -- function num : 0_2
end

EquipListTitleCell2.RefreshCell = function(self, data)
  -- function num : 0_3
end

return EquipListTitleCell2

