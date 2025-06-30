-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/friend/friendchatrightimagecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local CFriendEmoji = (BeanManager.GetTableByName)("guild.cguildemoji")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local FriendChatRightImageCell = class("FriendChatRightImageCell", Dialog)
FriendChatRightImageCell.AssetBundleName = "ui/layouts.friends"
FriendChatRightImageCell.AssetName = "FriendsChatCellRightImage"
FriendChatRightImageCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FriendChatRightImageCell
  ((FriendChatRightImageCell.super).Ctor)(self, ...)
end

FriendChatRightImageCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._frame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  self._empji = self:GetChild("Emoji")
  self._time = self:GetChild("Time")
  self._name = self:GetChild("PlayerInfo/HeadPhoto/Name")
  self._nameLight = self:GetChild("PlayerInfo/HeadPhoto/NameLight")
end

FriendChatRightImageCell.RefreshCell = function(self, data)
  -- function num : 0_2 , upvalues : _ENV, HeadPhotoTable, CImagePath, HeadPhotoFrameTable, CFriendEmoji
  self._data = data
  local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
  local headPhotoRecord = HeadPhotoTable:GetRecorder(userInfo.avatarId)
  if not CImagePath:GetRecorder(headPhotoRecord.photoid) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
  if not CImagePath:GetRecorder(headPhotoFrameRecord.photoid) then
    imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local imgId = (CFriendEmoji:GetRecorder((((self._data)._hyperlinks)[1]).linkText)).EmojiId
  do
    if imgId then
      if not CImagePath:GetRecorder(imgId) then
        local imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._empji):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
    ;
    (self._time):SetText((self._data):GetChatTimeStr())
    local haveSpriteEvidence = (((NekoData.BehaviorManager).BM_Currency):GetSpiritRecoverTimes())[DataCommon.SpriteEvidence]
    local userNameStr = nil
    if haveSpriteEvidence then
      userNameStr = ((NekoData.BehaviorManager).BM_Message):GetString(2090, {userInfo.username})
    else
      userNameStr = userInfo.username
    end
    ;
    (self._name):SetText(userNameStr)
    ;
    (self._nameLight):SetText(userNameStr)
    ;
    (self._name):SetActive(not haveSpriteEvidence)
    ;
    (self._nameLight):SetActive(haveSpriteEvidence)
  end
end

return FriendChatRightImageCell

