-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/leftpowerimggridflyeffectcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LeftPowerImgGridFlyEffectCell = class("LeftPowerImgGridFlyEffectCell", Dialog)
LeftPowerImgGridFlyEffectCell.AssetBundleName = "ui/layouts.battlenew"
LeftPowerImgGridFlyEffectCell.AssetName = "BattleEffect1"
LeftPowerImgGridFlyEffectCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LeftPowerImgGridFlyEffectCell
  ((LeftPowerImgGridFlyEffectCell.super).Ctor)(self, ...)
end

LeftPowerImgGridFlyEffectCell.OnCreate = function(self)
  -- function num : 0_1
end

LeftPowerImgGridFlyEffectCell.OnDestroy = function(self)
  -- function num : 0_2
end

return LeftPowerImgGridFlyEffectCell

