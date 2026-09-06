local RightCell = class("RightCell", Dialog)
RightCell.AssetBundleName = "ui/layouts.battle"
RightCell.AssetName = "ATBSelf"

function RightCell:Ctor(...)
  RightCell.super.Ctor(self, ...)
  self._battler = nil
end

function RightCell:OnCreate()
end

function RightCell:OnDestroy()
end

function RightCell:SetBattler(battler)
  self._battler = battler
end

function RightCell:GetBattler()
  return self._battler
end

return RightCell
