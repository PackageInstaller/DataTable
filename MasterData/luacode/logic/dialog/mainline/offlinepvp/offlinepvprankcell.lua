local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local OfflinePvpRankCell = class("OfflinePvpRankCell", Dialog)
OfflinePvpRankCell.AssetBundleName = "ui/layouts.offlinepvp"
OfflinePvpRankCell.AssetName = "OffLinePVPRankCell"

function OfflinePvpRankCell:Ctor(...)
  OfflinePvpRankCell.super.Ctor(self, ...)
end

function OfflinePvpRankCell:OnCreate()
  self._namePlayer = self:GetChild("Panel/PlayerInfo/NameBack/NamePlayer")
  self._name = self:GetChild("Panel/PlayerInfo/NameBack/Name")
  self._headPhoto = self:GetChild("Panel/PlayerInfo/HeadPhoto/Photo")
  self._headPhotoFrame = self:GetChild("Panel/PlayerInfo/HeadPhoto/Frame")
  self._level = self:GetChild("Panel/PlayerInfo/LvBack/Level")
  self._score = self:GetChild("Panel/Num")
  self._back1 = self:GetChild("Back1")
  self._back2 = self:GetChild("Back2")
  self._back3 = self:GetChild("Back3")
  self._backPlayer = self:GetChild("BackPlayer")
  self._backNormal = self:GetChild("Back")
  self._rank = self:GetChild("Panel/Rank")
  self._rank1 = self:GetChild("Panel/Rank1")
  self._rank2 = self:GetChild("Panel/Rank2")
  self._rank3 = self:GetChild("Panel/Rank3")
end

function OfflinePvpRankCell:OnDestroy()
end

function OfflinePvpRankCell:SetBack(rank)
  self._back1:SetActive(rank == 1)
  self._back2:SetActive(rank == 2)
  self._back3:SetActive(rank == 3)
  self._backNormal:SetActive(3 < rank)
  self._rank1:SetActive(rank == 1)
  self._rank2:SetActive(rank == 2)
  self._rank3:SetActive(rank == 3)
  self._rank:SetActive(3 < rank)
  self._backPlayer:SetActive(false)
end

function OfflinePvpRankCell:RefreshCell(data)
  self._data = data.data
  self._rank:SetText(self._data.rank)
  self._score:SetText(self._data.pithy)
  self:SetBack(self._data.rank)
  local userInfo = self._data.baseUserData
  self._level:SetText(userInfo.userLv)
  if userInfo.userId == NekoData.BehaviorManager.BM_Game:GetUserId() then
    self._name:SetActive(false)
    self._namePlayer:SetActive(true)
    self._namePlayer:SetText(userInfo.userName)
  else
    self._name:SetActive(true)
    self._namePlayer:SetActive(false)
    self._name:SetText(userInfo.userName)
  end
  local headPhotoRecord = HeadPhotoTable:GetRecorder(userInfo.avatarId)
  local imageRecord
  if headPhotoRecord then
    imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._headPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("OfflinePvpRankCell", "userInfo.avatarId %s is wrong", userInfo.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
  if headPhotoFrameRecord then
    imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._headPhotoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("OfflinePvpRankCell", "userInfo.frameId %s is wrong", userInfo.frameId)
  end
end

return OfflinePvpRankCell
