-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/equipbagjobcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EquipBagJobCell = class("EquipBagJobCell", Dialog)
EquipBagJobCell.AssetBundleName = "ui/layouts.equip"
EquipBagJobCell.AssetName = "EquipListJobCell"
EquipBagJobCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipBagJobCell
  ((EquipBagJobCell.super).Ctor)(self, ...)
end

EquipBagJobCell.OnCreate = function(self)
  -- function num : 0_1
  self._jobName = self:GetChild("JobName")
end

EquipBagJobCell.OnDestroy = function(self)
  -- function num : 0_2
end

EquipBagJobCell.RefreshCell = function(self, str)
  -- function num : 0_3
  (self._jobName):SetText(str)
end

return EquipBagJobCell

