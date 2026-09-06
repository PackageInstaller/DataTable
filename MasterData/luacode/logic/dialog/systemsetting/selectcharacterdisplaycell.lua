local SelectCharacterDisplayCell = class("SelectCharacterDisplayCell", Dialog)
SelectCharacterDisplayCell.AssetBundleName = "ui/layouts.setting"
SelectCharacterDisplayCell.AssetName = "SettingLanguageCell"

function SelectCharacterDisplayCell:Ctor(...)
  SelectCharacterDisplayCell.super.Ctor(self, ...)
end

function SelectCharacterDisplayCell:OnCreate()
  self._characterDisplayName = self:GetChild("GroupBtn4/Text")
  self._selectIcon = self:GetChild("GroupBtn4/Select")
  self._downLoadIcon = self:GetChild("GroupBtn4/Download")
  self._blackBack = self:GetChild("GroupBtn4/Image")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function SelectCharacterDisplayCell:OnDestroy()
end

function SelectCharacterDisplayCell:RefreshCell(data)
  self._characterDisplayName:SetText(data.name)
  self._selectIcon:SetActive(false)
  self._downLoadIcon:SetActive(false)
  if data.index then
    self._blackBack:SetActive(data.index % 2 == 1)
  end
  if data.state == 0 then
    self._downLoadIcon:SetActive(true)
  elseif data.state == 2 then
    self._selectIcon:SetActive(true)
  elseif data.state == 3 then
    self._downLoadIcon:SetActive(true)
  end
end

function SelectCharacterDisplayCell:OnCellClicked()
  self._delegate:OnSelectCharacterDisplay(self._cellData)
end

return SelectCharacterDisplayCell
