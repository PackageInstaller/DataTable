-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/rightcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RightCell = class("RightCell", Dialog)
RightCell.AssetBundleName = "ui/layouts.battle"
RightCell.AssetName = "ATBSelf"
RightCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RightCell
  ((RightCell.super).Ctor)(self, ...)
  self._battler = nil
end

RightCell.OnCreate = function(self)
  -- function num : 0_1
end

RightCell.OnDestroy = function(self)
  -- function num : 0_2
end

RightCell.SetBattler = function(self, battler)
  -- function num : 0_3
  self._battler = battler
end

RightCell.GetBattler = function(self)
  -- function num : 0_4
  return self._battler
end

return RightCell

