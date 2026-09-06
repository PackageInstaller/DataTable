local ResourceFloorLineCell = class("ResourceFloorLineCell", Dialog)
ResourceFloorLineCell.AssetBundleName = "ui/layouts.mainline"
ResourceFloorLineCell.AssetName = "ResourceSelectCellLine"

function ResourceFloorLineCell:Ctor(...)
  ResourceFloorLineCell.super.Ctor(self, ...)
end

function ResourceFloorLineCell:OnCreate()
end

function ResourceFloorLineCell:OnDestroy()
end

function ResourceFloorLineCell:RefreshCell(data)
  self._data = data
end

function ResourceFloorLineCell:SetPosition(ax, x, ay, y)
  self:GetRootWindow():SetPosition(ax, x, ay, y)
end

function ResourceFloorLineCell:SetZRotation(bx, by, ex, ey)
  self:GetRootWindow():SetZRotation(bx, by, ex, ey)
end

function ResourceFloorLineCell:SetWidth(width)
  self:GetRootWindow():SetWidth(0, width)
end

return ResourceFloorLineCell
