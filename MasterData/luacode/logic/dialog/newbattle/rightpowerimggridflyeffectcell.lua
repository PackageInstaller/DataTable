local RightPowerImgGridFlyEffectCell = class("RightPowerImgGridFlyEffectCell", Dialog)
RightPowerImgGridFlyEffectCell.AssetBundleName = "ui/layouts.battlenew"
RightPowerImgGridFlyEffectCell.AssetName = "BattleEffect2"

function RightPowerImgGridFlyEffectCell:Ctor(...)
  RightPowerImgGridFlyEffectCell.super.Ctor(self, ...)
end

function RightPowerImgGridFlyEffectCell:OnCreate()
end

function RightPowerImgGridFlyEffectCell:OnDestroy()
end

return RightPowerImgGridFlyEffectCell
