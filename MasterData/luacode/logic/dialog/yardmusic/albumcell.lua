local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local MusicWorldCell = class("MusicWorldCell", Dialog)
MusicWorldCell.AssetBundleName = "ui/layouts.yard"
MusicWorldCell.AssetName = "MusicPlayerMainCell"

function MusicWorldCell:Ctor(...)
  MusicWorldCell.super.Ctor(self, ...)
end

function MusicWorldCell:OnCreate()
  self._img = self:GetChild("AldumImage")
  self._name = self:GetChild("NameBack/Text")
  self._new = self:GetChild("Dot")
  self._progress = self:GetChild("GetBack/Text")
  self._progress_max = self:GetChild("GetBack/Max")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellMouseClicked, self)
end

function MusicWorldCell:OnDestroy()
end

function MusicWorldCell:RefreshCell(data)
  local albumRecord = data.record
  local imageRecord = CImagePathTable:GetRecorder(albumRecord.album) or DataCommon.DefaultImageAsset
  self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._name:SetText(TextManager.GetText(albumRecord.albumName))
  self._new:SetActive(data.showNew)
  local unlockNum = NekoData.BehaviorManager.BM_YardMusic:GetUnlockMusicNum(albumRecord.id)
  local maxNum = NekoData.BehaviorManager.BM_YardMusic:GetAlbumMusicTotalNum(albumRecord.id)
  if unlockNum < maxNum then
    self._progress:SetActive(true)
    self._progress_max:SetActive(false)
    self._progress:SetText(unlockNum .. "/" .. maxNum)
  else
    self._progress:SetActive(false)
    self._progress_max:SetActive(true)
    self._progress_max:SetText(maxNum .. "/" .. maxNum)
  end
end

function MusicWorldCell:OnCellMouseClicked()
  self._delegate:CheckedAlbum(self._cellData)
end

return MusicWorldCell
