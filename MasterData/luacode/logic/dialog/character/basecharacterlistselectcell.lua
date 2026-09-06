local BaseCharacterListSelectCell = class("BaseCharacterListSelectCell", Dialog)
BaseCharacterListSelectCell.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterListSelectCell.AssetName = "BaseCharacterListSelectCell"

function BaseCharacterListSelectCell:Ctor(...)
  BaseCharacterListSelectCell.super.Ctor(self, ...)
end

function BaseCharacterListSelectCell:OnCreate()
  self._select = self:GetChild("Select")
  self._text = self:GetChild("Text")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function BaseCharacterListSelectCell:OnDestroy()
end

function BaseCharacterListSelectCell:RefreshCell()
  self._text:SetText(TextManager.GetText(self._cellData))
  self._select:SetActive(false)
  for _, v in pairs(self._delegate._nameIdList) do
    if v == self._cellData then
      self._select:SetActive(true)
      break
    end
  end
end

function BaseCharacterListSelectCell:OnCellClick()
  self._delegate:OnVocationTabCellClick(self._cellData)
end

return BaseCharacterListSelectCell
