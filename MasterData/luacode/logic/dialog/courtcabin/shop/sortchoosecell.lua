local SortChooseCell = class("SortChooseCell", Dialog)
SortChooseCell.AssetBundleName = "ui/layouts.yard"
SortChooseCell.AssetName = "FurnitureSortListCell"

function SortChooseCell:Ctor(...)
  SortChooseCell.super.Ctor(self, ...)
end

function SortChooseCell:OnCreate()
  self._text = self:GetChild("Btn/Txt")
  self._rootWindow:Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function SortChooseCell:OnDestroy()
end

function SortChooseCell:RefreshCell(data)
  self._text:SetText(TextManager.GetText(data.nameid))
end

function SortChooseCell:OnCellClicked()
  self._delegate:SetSortId(self._cellData.id)
end

return SortChooseCell
