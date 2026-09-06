local LeftCell = class("LeftCell", Dialog)
LeftCell.AssetBundleName = "ui/layouts.battle"
LeftCell.AssetName = "ATBEnemy"

function LeftCell:Ctor(...)
  LeftCell.super.Ctor(self, ...)
  self._battler = nil
end

function LeftCell:OnCreate()
end

function LeftCell:OnDestroy()
end

function LeftCell:SetBattler(battler)
  self._battler = battler
end

function LeftCell:GetBattler()
  return self._battler
end

return LeftCell
