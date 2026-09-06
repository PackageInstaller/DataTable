local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CFriendEmoji = BeanManager.GetTableByName("guild.cguildemoji")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local FriendChatRightImageCell = class("FriendChatRightImageCell", Dialog)
FriendChatRightImageCell.AssetBundleName = "ui/layouts.friends"
FriendChatRightImageCell.AssetName = "FriendsChatCellRightImage"

function FriendChatRightImageCell:Ctor(...)
  FriendChatRightImageCell.super.Ctor(self, ...)
end

function FriendChatRightImageCell:OnCreate()
  self._icon = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._frame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  self._empji = self:GetChild("Emoji")
  self._time = self:GetChild("Time")
  self._name = self:GetChild("PlayerInfo/HeadPhoto/Name")
  self._nameLight = self:GetChild("PlayerInfo/HeadPhoto/NameLight")
end

function FriendChatRightImageCell:RefreshCell(data)
  self._data = data
  local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  local headPhotoRecord = HeadPhotoTable:GetRecorder(userInfo.avatarId)
  local imageRecord = CImagePath:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
  imageRecord = CImagePath:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local imgId = CFriendEmoji:GetRecorder(self._data._hyperlinks[1].linkText).EmojiId
  if imgId then
    local imageRecord = CImagePath:GetRecorder(imgId) or DataCommon.DefaultImageAsset
    self._empji:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  self._time:SetText(self._data:GetChatTimeStr())
  local haveSpriteEvidence = NekoData.BehaviorManager.BM_Currency:GetSpiritRecoverTimes()[DataCommon.SpriteEvidence]
  local userNameStr
  if haveSpriteEvidence then
    userNameStr = NekoData.BehaviorManager.BM_Message:GetString(2090, {
      userInfo.username
    })
  else
    userNameStr = userInfo.username
  end
  self._name:SetText(userNameStr)
  self._nameLight:SetText(userNameStr)
  self._name:SetActive(not haveSpriteEvidence)
  self._nameLight:SetActive(haveSpriteEvidence)
end

return FriendChatRightImageCell
