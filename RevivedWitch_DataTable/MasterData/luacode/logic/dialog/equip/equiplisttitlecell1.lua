-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/equiplisttitlecell1.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EquipListTitleCell1 = class("EquipListTitleCell1", Dialog)
EquipListTitleCell1.AssetBundleName = "ui/layouts.equip"
EquipListTitleCell1.AssetName = "EquipListTitleCell1"
EquipListTitleCell1.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipListTitleCell1
  ((EquipListTitleCell1.super).Ctor)(self, ...)
end

EquipListTitleCell1.OnCreate = function(self)
  -- function num : 0_1
end

EquipListTitleCell1.OnDestroy = function(self)
  -- function num : 0_2
end

EquipListTitleCell1.RefreshCell = function(self, data)
  -- function num : 0_3
end

return EquipListTitleCell1

