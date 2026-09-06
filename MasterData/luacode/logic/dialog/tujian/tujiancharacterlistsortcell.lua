local TuJianCharacterListSortCell = class("TuJianCharacterListSortCell", Dialog)
TuJianCharacterListSortCell.AssetBundleName = "ui/layouts.tujian"
TuJianCharacterListSortCell.AssetName = "TuJianCharListSortCell"

function TuJianCharacterListSortCell:Ctor(...)
  TuJianCharacterListSortCell.super.Ctor(self, ...)
  self._filter = true
end

function TuJianCharacterListSortCell:OnCreate()
  self._btn = self:GetChild("SelectBtn")
  self._text = self:GetChild("SelectBtn/Txt")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function TuJianCharacterListSortCell:OnDestroy()
end

function TuJianCharacterListSortCell:RefreshCell()
  self._text:SetText(tostring(TextManager.GetText(self._cellData)))
  self._filter = false
  for _, v in pairs(self._delegate._filterList1) do
    if v == self._cellData then
      self._filter = true
      break
    end
  end
  for _, v in pairs(self._delegate._filterList2) do
    if v == self._cellData then
      self._filter = true
      break
    end
  end
  self._btn:SetSelected(self._filter)
end

function TuJianCharacterListSortCell:OnCellClick()
  self._filter = not self._filter
  self._btn:SetSelected(self._filter)
  self._delegate:OnFilterCellClick(self._cellData)
end

return TuJianCharacterListSortCell
