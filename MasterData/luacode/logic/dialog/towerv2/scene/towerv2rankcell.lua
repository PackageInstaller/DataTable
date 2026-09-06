local TowerV2RankCellHelper = require("logic.dialog.towerv2.scene.towerv2rankcellhelper")
local TowerV2RankCell = class("TowerV2RankCell", Dialog)
TowerV2RankCell.AssetBundleName = "ui/layouts.stair"
TowerV2RankCell.AssetName = "StairRankCell"

function TowerV2RankCell:Ctor(...)
  TowerV2RankCell.super.Ctor(self, ...)
end

function TowerV2RankCell:OnCreate()
  self._TowerV2RankCellHelper = TowerV2RankCellHelper.Create(self:GetRootWindow())
end

function TowerV2RankCell:OnDestroy()
  if self._TowerV2RankCellHelper then
    self._TowerV2RankCellHelper:OnDestroy()
  end
end

function TowerV2RankCell:RefreshCell(data)
  if self._TowerV2RankCellHelper then
    self._TowerV2RankCellHelper:RefreshCell(data)
  end
end

return TowerV2RankCell
