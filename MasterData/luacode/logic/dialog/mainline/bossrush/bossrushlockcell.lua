local BossRushPanelLockCell = class("BossRushPanelLockCell", Dialog)
BossRushPanelLockCell.AssetBundleName = "ui/layouts.mainline"
BossRushPanelLockCell.AssetName = "BossRushPanelCellLocked"

function BossRushPanelLockCell:Ctor(...)
  BossRushPanelLockCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function BossRushPanelLockCell:OnCreate()
end

function BossRushPanelLockCell:OnDestroy()
end

function BossRushPanelLockCell:RefreshCell()
end

return BossRushPanelLockCell
