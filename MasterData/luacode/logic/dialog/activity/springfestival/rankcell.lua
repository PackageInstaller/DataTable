local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local RankCell = class("RankCell", Dialog)
RankCell.AssetBundleName = "ui/layouts.activitynewyear"
RankCell.AssetName = "ActivityNewYearRankCell"

function RankCell:Ctor(...)
  RankCell.super.Ctor(self, ...)
end

function RankCell:OnCreate()
  self._rankNum = self:GetChild("Panel/Rank")
  self._back = self:GetChild("Back")
  self._headFrame = self:GetChild("Panel/PlayerInfo/HeadPhoto/Frame")
  self._headPhoto = self:GetChild("Panel/PlayerInfo/HeadPhoto/Photo")
  self._userName = self:GetChild("Panel/PlayerInfo/NameBack/Name")
  self._callScoreNum = self:GetChild("Panel/Num")
  self._level = self:GetChild("Panel/PlayerInfo/LvBack/Level")
  self._headPhoto:Subscribe_PointerClickEvent(self.OnHeadPhotoClicked, self)
  self._top3Element = {}
  for i = 1, 3 do
    self._top3Element[i] = {}
    self._top3Element[i].rankIcon = self:GetChild("Panel/Rank" .. i)
    self._top3Element[i].back = self:GetChild("Back" .. i)
  end
  self._backPlayer = self:GetChild("BackPlayer")
  self._backPlayer:SetActive(false)
end

function RankCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function RankCell:RefreshCell(data)
  self._data = data
  local userName, score, rank, frameId, avatarId
  userName = self._data.baseUserData.userName
  score = self._data.score
  rank = self._data.rank
  frameId = self._data.baseUserData.frameId
  avatarId = self._data.baseUserData.avatarId
  for i, v in ipairs(self._top3Element) do
    v.rankIcon:SetActive(rank == i)
    v.back:SetActive(rank == i)
  end
  self._rankNum:SetActive(3 < rank)
  self._back:SetActive(3 < rank)
  self._rankNum:SetText(rank)
  self._callScoreNum:SetText(score)
  self._userName:SetText(userName)
  self._level:SetText(self._data.baseUserData.userLv)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(frameId)
  if headPhotoFrameRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._headFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._headFrame:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("CallRankCell", "headPhotoFrameRecord not found. frameId = %s", frameId)
  end
  local headPhotoRecord = HeadPhotoTable:GetRecorder(avatarId)
  if headPhotoRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._headPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._headPhoto:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("CallRankCell", "headPhotoRecord not found. avatarId = %s", avatarId)
  end
end

function RankCell:OnHeadPhotoClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.clookotherinfo")
  if protocol then
    protocol.userId = self._data.baseUserData.userId
    protocol:Send()
  end
end

return RankCell
