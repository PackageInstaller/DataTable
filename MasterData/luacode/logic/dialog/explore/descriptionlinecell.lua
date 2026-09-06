local DescriptionLineCell = class("DescriptionLineCell", Dialog)
DescriptionLineCell.AssetBundleName = "ui/layouts.yard"
DescriptionLineCell.AssetName = "YardExploreDetailFrame"

function DescriptionLineCell:Ctor(...)
  DescriptionLineCell.super.Ctor(self, ...)
end

function DescriptionLineCell:OnCreate()
end

function DescriptionLineCell:OnDestroy()
end

function DescriptionLineCell:RefreshCell(data)
end

return DescriptionLineCell
