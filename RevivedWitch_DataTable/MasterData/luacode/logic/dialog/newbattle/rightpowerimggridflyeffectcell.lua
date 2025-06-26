-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/rightpowerimggridflyeffectcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RightPowerImgGridFlyEffectCell = class("RightPowerImgGridFlyEffectCell", Dialog)
RightPowerImgGridFlyEffectCell.AssetBundleName = "ui/layouts.battlenew"
RightPowerImgGridFlyEffectCell.AssetName = "BattleEffect2"
RightPowerImgGridFlyEffectCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RightPowerImgGridFlyEffectCell
  ((RightPowerImgGridFlyEffectCell.super).Ctor)(self, ...)
end

RightPowerImgGridFlyEffectCell.OnCreate = function(self)
  -- function num : 0_1
end

RightPowerImgGridFlyEffectCell.OnDestroy = function(self)
  -- function num : 0_2
end

return RightPowerImgGridFlyEffectCell

