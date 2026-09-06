local BossRushPanelStageCell = class("BossRushPanelStageCell", Dialog)
BossRushPanelStageCell.AssetBundleName = "ui/layouts.mainline"
BossRushPanelStageCell.AssetName = "BossRushPanelCellStageCell"

function BossRushPanelStageCell:Ctor(...)
  BossRushPanelStageCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function BossRushPanelStageCell:OnCreate()
  self._noPass = self:GetChild("No")
  self._pass = self:GetChild("Yes")
end

function BossRushPanelStageCell:OnDestroy()
end

function BossRushPanelStageCell:RefreshCell()
  self._pass:SetActive(self._cellData.pass)
  self._noPass:SetActive(not self._cellData.pass)
end

return BossRushPanelStageCell
