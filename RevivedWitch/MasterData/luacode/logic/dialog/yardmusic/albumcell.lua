-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/yardmusic/albumcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local MusicWorldCell = class("MusicWorldCell", Dialog)
MusicWorldCell.AssetBundleName = "ui/layouts.yard"
MusicWorldCell.AssetName = "MusicPlayerMainCell"
MusicWorldCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MusicWorldCell
  ((MusicWorldCell.super).Ctor)(self, ...)
end

MusicWorldCell.OnCreate = function(self)
  -- function num : 0_1
  self._img = self:GetChild("AldumImage")
  self._name = self:GetChild("NameBack/Text")
  self._new = self:GetChild("Dot")
  self._progress = self:GetChild("GetBack/Text")
  self._progress_max = self:GetChild("GetBack/Max")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellMouseClicked, self)
end

MusicWorldCell.OnDestroy = function(self)
  -- function num : 0_2
end

MusicWorldCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV
  local albumRecord = data.record
  if not CImagePathTable:GetRecorder(albumRecord.album) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._name):SetText((TextManager.GetText)(albumRecord.albumName))
  ;
  (self._new):SetActive(data.showNew)
  local unlockNum = ((NekoData.BehaviorManager).BM_YardMusic):GetUnlockMusicNum(albumRecord.id)
  local maxNum = ((NekoData.BehaviorManager).BM_YardMusic):GetAlbumMusicTotalNum(albumRecord.id)
  if unlockNum < maxNum then
    (self._progress):SetActive(true)
    ;
    (self._progress_max):SetActive(false)
    ;
    (self._progress):SetText(unlockNum .. "/" .. maxNum)
  else
    ;
    (self._progress):SetActive(false)
    ;
    (self._progress_max):SetActive(true)
    ;
    (self._progress_max):SetText(maxNum .. "/" .. maxNum)
  end
end

MusicWorldCell.OnCellMouseClicked = function(self)
  -- function num : 0_4
  (self._delegate):CheckedAlbum(self._cellData)
end

return MusicWorldCell

