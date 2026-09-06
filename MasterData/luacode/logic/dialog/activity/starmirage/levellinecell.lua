local LevelLineCell = class("LevelLineCell", Dialog)
LevelLineCell.AssetBundleName = "ui/layouts.activitystar"
LevelLineCell.AssetName = "ActivityStarCellLine"

function LevelLineCell:Ctor(...)
  LevelLineCell.super.Ctor(self, ...)
end

function LevelLineCell:OnCreate()
end

function LevelLineCell:OnDestroy()
end

return LevelLineCell
