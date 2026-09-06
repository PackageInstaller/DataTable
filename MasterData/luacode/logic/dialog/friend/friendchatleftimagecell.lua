local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CFriendEmoji = BeanManager.GetTableByName("guild.cguildemoji")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local FriendChatLeftImageCell = class("FriendChatLeftImageCell", Dialog)
FriendChatLeftImageCell.AssetBundleName = "ui/layouts.friends"
FriendChatLeftImageCell.AssetName = "FriendsChatCellLeftImage"

function FriendChatLeftImageCell:Ctor(...)
  FriendChatLeftImageCell.super.Ctor(self, ...)
end

function FriendChatLeftImageCell:OnCreate()
  self._icon = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._frame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  self:GetChild("PlayerInfo/HeadPhoto/Grey"):SetActive(false)
  self._empji = self:GetChild("Emoji")
  self._time = self:GetChild("Time")
  self._name = self:GetChild("PlayerInfo/HeadPhoto/Name")
  self._nameLight = self:GetChild("PlayerInfo/HeadPhoto/NameLight")
end

function FriendChatLeftImageCell:RefreshCell(data)
  self._data = data
  local friend = NekoData.BehaviorManager.BM_Friends:GetFriend(self._delegate:GetSelectedFriend())
  if not friend then
    return
  end
  local imageinfo = friend:GetHeadImagePath()
  if imageinfo then
    self._icon:SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  end
  imageinfo = friend:GetFrameImagePath()
  if imageinfo then
    self._frame:SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  end
  if self._data._hyperlinks and #self._data._hyperlinks > 0 then
    local imgId = CFriendEmoji:GetRecorder(self._data._hyperlinks[1].linkText).EmojiId
    if imgId then
      local imageRecord = CImagePath:GetRecorder(imgId) or DataCommon.DefaultImageAsset
      self._empji:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  else
    LogErrorFormat("FriendChatLeftImageCell", "HyperLinks is Wrong")
  end
  local userNameStr
  if friend:GetSpiritVip() == 1 then
    userNameStr = NekoData.BehaviorManager.BM_Message:GetString(2090, {
      friend:GetName()
    })
  else
    userNameStr = friend:GetName()
  end
  self._name:SetText(userNameStr)
  self._nameLight:SetText(userNameStr)
  self._name:SetActive(friend:GetSpiritVip() ~= 1)
  self._nameLight:SetActive(friend:GetSpiritVip() == 1)
  self._time:SetText(data:GetChatTimeStr())
end

return FriendChatLeftImageCell
