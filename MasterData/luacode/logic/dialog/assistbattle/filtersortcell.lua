local CStringRes = BeanManager.GetTableByName("message.cstringres")
local FilterSortCell = class("FilterSortCell", Dialog)
FilterSortCell.AssetBundleName = "ui/layouts.basecharacterinfo"
FilterSortCell.AssetName = "BaseCharacterListSortCell"

function FilterSortCell:Ctor(...)
  FilterSortCell.super.Ctor(self, ...)
end

function FilterSortCell:OnCreate()
  self._selectBtn = self:GetChild("SelectBtn")
  self._text = self:GetChild("SelectBtn/Txt")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function FilterSortCell:OnDestroy()
end

function FilterSortCell:RefreshCell(data)
  local str = TextManager.GetText(CStringRes:GetRecorder(self._cellData.nameid).msgTextID)
  self._text:SetText(str)
  if self._delegate:IsInSelectedList(data) then
    self._selectBtn:SetSelected(true)
  else
    self._selectBtn:SetSelected(false)
  end
end

function FilterSortCell:OnCellClick()
  self._delegate:SetSelectedList(self._cellData)
end

function FilterSortCell:OnEvent(eventName, arg)
  if eventName == "ChangeSelectNameId" then
    if self._delegate:IsInSelectedList(self._cellData) then
      self._selectBtn:SetSelected(true)
    else
      self._selectBtn:SetSelected(false)
    end
  end
end

return FilterSortCell
