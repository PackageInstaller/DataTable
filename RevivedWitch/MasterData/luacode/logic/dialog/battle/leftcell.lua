-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/leftcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LeftCell = class("LeftCell", Dialog)
LeftCell.AssetBundleName = "ui/layouts.battle"
LeftCell.AssetName = "ATBEnemy"
LeftCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LeftCell
  ((LeftCell.super).Ctor)(self, ...)
  self._battler = nil
end

LeftCell.OnCreate = function(self)
  -- function num : 0_1
end

LeftCell.OnDestroy = function(self)
  -- function num : 0_2
end

LeftCell.SetBattler = function(self, battler)
  -- function num : 0_3
  self._battler = battler
end

LeftCell.GetBattler = function(self)
  -- function num : 0_4
  return self._battler
end

return LeftCell

