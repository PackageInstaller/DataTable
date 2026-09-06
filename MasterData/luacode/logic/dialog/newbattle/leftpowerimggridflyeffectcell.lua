local LeftPowerImgGridFlyEffectCell = class("LeftPowerImgGridFlyEffectCell", Dialog)
LeftPowerImgGridFlyEffectCell.AssetBundleName = "ui/layouts.battlenew"
LeftPowerImgGridFlyEffectCell.AssetName = "BattleEffect1"

function LeftPowerImgGridFlyEffectCell:Ctor(...)
  LeftPowerImgGridFlyEffectCell.super.Ctor(self, ...)
end

function LeftPowerImgGridFlyEffectCell:OnCreate()
end

function LeftPowerImgGridFlyEffectCell:OnDestroy()
end

return LeftPowerImgGridFlyEffectCell
