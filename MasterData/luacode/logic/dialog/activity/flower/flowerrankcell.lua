local FlowerRankCellHelper = require("logic.dialog.activity.flower.flowerrankcellhelper")
local FlowerRankCell = class("FlowerRankCell", Dialog)
FlowerRankCell.AssetBundleName = "ui/layouts.flower"
FlowerRankCell.AssetName = "FlowerRankCell"

function FlowerRankCell:Ctor(...)
  FlowerRankCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function FlowerRankCell:OnDestroy()
end

function FlowerRankCell:OnCreate()
  self._FlowerRankCellHelper = FlowerRankCellHelper.Create(self:GetRootWindow())
end

function FlowerRankCell:RefreshCell(data)
  if self._FlowerRankCellHelper then
    self._FlowerRankCellHelper:RefreshCell(data)
  end
end

return FlowerRankCell
