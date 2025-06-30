-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/chargingmarkcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ChargingMarkCell = class("ChargingMarkCell", Dialog)
ChargingMarkCell.AssetBundleName = "ui/layouts.basecharacterinfo"
ChargingMarkCell.AssetName = "CharSkillNewSkillMark"
ChargingMarkCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChargingMarkCell
  ((ChargingMarkCell.super).Ctor)(self, ...)
end

ChargingMarkCell.OnCreate = function(self)
  -- function num : 0_1
end

ChargingMarkCell.OnDestroy = function(self)
  -- function num : 0_2
end

ChargingMarkCell.RefreshCell = function(self)
  -- function num : 0_3
end

return ChargingMarkCell

