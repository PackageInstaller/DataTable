local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local FlowerRankCellHelper = class("FlowerRankCellHelper")

function FlowerRankCellHelper:Ctor(rootElement)
  self._rankIcon = {}
  self._cellBack = {}
  for i = 1, 3 do
    self._rankIcon[i] = rootElement:FindChild("Panel/Rank" .. i)
    self._cellBack[i] = rootElement:FindChild("Back" .. i)
  end
  self._selfBack = rootElement:FindChild("BackPlayer")
  self._commonBack = rootElement:FindChild("Back")
  self._rank = rootElement:FindChild("Panel/Rank")
  self._score = rootElement:FindChild("Panel/Num")
  self._photo = rootElement:FindChild("Panel/PlayerInfo/HeadPhoto/Photo")
  self._photoFrame = rootElement:FindChild("Panel/PlayerInfo/HeadPhoto/Frame")
  self._name = rootElement:FindChild("Panel/PlayerInfo/NameBack/Name")
  self._selfName = rootElement:FindChild("Panel/PlayerInfo/NameBack/NamePlayer")
  self._level = rootElement:FindChild("Panel/PlayerInfo/LvBack/Level")
end

function FlowerRankCellHelper:RefreshCell(data)
  local rank = data.simpleRankData.rank
  if 3 < rank then
    self._rank:SetText(rank)
  elseif rank == -1 then
    self._rank:SetText(TextManager.GetText(CStringRes:GetRecorder(1681).msgTextID))
  end
  local bSelf = data.isMySelf
  local userName = data.simpleRankData.baseUserData.userName
  local userLv = data.simpleRankData.baseUserData.userLv
  local score = data.simpleRankData.score
  local frameId = data.simpleRankData.baseUserData.frameId
  local avatarId = data.simpleRankData.baseUserData.avatarId
  self._rank:SetActive(3 < rank or rank == -1)
  for i = 1, 3 do
    self._rankIcon[i]:SetActive(i == rank)
    self._rankIcon[i]:SetActive(i == rank)
    self._cellBack[i]:SetActive(i == rank)
  end
  self._selfBack:SetActive((3 < rank or rank == -1) and bSelf)
  self._commonBack:SetActive(3 < rank and not bSelf)
  self._selfName:SetActive(bSelf)
  self._name:SetActive(not bSelf)
  self._selfName:SetText(userName)
  self._name:SetText(userName)
  self._level:SetText(userLv)
  self._score:SetText(score)
  local headPhotoRecord = HeadPhotoTable:GetRecorder(avatarId)
  if headPhotoRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._photo:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("BossRushRankCell", "headPhotoRecord not found. avatarId = %s", avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(frameId)
  if headPhotoFrameRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._photoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._photoFrame:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("BossRushRankCell", "headPhotoFrameRecord not found. frameId = %s", frameId)
  end
end

return FlowerRankCellHelper
