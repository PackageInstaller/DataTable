local SelectAudioCell = class("SelectAudioCell", Dialog)
SelectAudioCell.AssetBundleName = "ui/layouts.setting"
SelectAudioCell.AssetName = "SettingLanguageCell"

function SelectAudioCell:Ctor(...)
  SelectAudioCell.super.Ctor(self, ...)
end

function SelectAudioCell:OnCreate()
  self._audioName = self:GetChild("GroupBtn4/Text")
  self._selectIcon = self:GetChild("GroupBtn4/Select")
  self._downLoadIcon = self:GetChild("GroupBtn4/Download")
  self._blackBack = self:GetChild("GroupBtn4/Image")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function SelectAudioCell:OnDestroy()
end

function SelectAudioCell:RefreshCell(data)
  self._audioName:SetText(data.audioName)
  if data.index then
    self._blackBack:SetActive(data.index % 2 == 1)
  end
  self._selectIcon:SetActive(false)
  self._downLoadIcon:SetActive(false)
  if data.state == 0 then
    self._downLoadIcon:SetActive(true)
  elseif data.state == 2 then
    self._selectIcon:SetActive(true)
  elseif data.state == 3 then
    self._downLoadIcon:SetActive(true)
  end
end

function SelectAudioCell:OnCellClicked()
  self._delegate:OnSelectAudio(self._cellData)
end

return SelectAudioCell
