-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/friend/friendchatleftimagecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local CFriendEmoji = (BeanManager.GetTableByName)("guild.cguildemoji")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local FriendChatLeftImageCell = class("FriendChatLeftImageCell", Dialog)
FriendChatLeftImageCell.AssetBundleName = "ui/layouts.friends"
FriendChatLeftImageCell.AssetName = "FriendsChatCellLeftImage"
FriendChatLeftImageCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FriendChatLeftImageCell
  ((FriendChatLeftImageCell.super).Ctor)(self, ...)
end

FriendChatLeftImageCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._frame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  ;
  (self:GetChild("PlayerInfo/HeadPhoto/Grey")):SetActive(false)
  self._empji = self:GetChild("Emoji")
  self._time = self:GetChild("Time")
  self._name = self:GetChild("PlayerInfo/HeadPhoto/Name")
  self._nameLight = self:GetChild("PlayerInfo/HeadPhoto/NameLight")
end

FriendChatLeftImageCell.RefreshCell = function(self, data)
  -- function num : 0_2 , upvalues : _ENV, CFriendEmoji, CImagePath
  self._data = data
  local friend = ((NekoData.BehaviorManager).BM_Friends):GetFriend((self._delegate):GetSelectedFriend())
  if not friend then
    return 
  end
  local imageinfo = friend:GetHeadImagePath()
  if imageinfo then
    (self._icon):SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  end
  imageinfo = friend:GetFrameImagePath()
  if imageinfo then
    (self._frame):SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  end
  if (self._data)._hyperlinks and #(self._data)._hyperlinks > 0 then
    local imgId = (CFriendEmoji:GetRecorder((((self._data)._hyperlinks)[1]).linkText)).EmojiId
    if imgId then
      if not CImagePath:GetRecorder(imgId) then
        local imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._empji):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  else
    do
      LogErrorFormat("FriendChatLeftImageCell", "HyperLinks is Wrong")
      local userNameStr = nil
      if friend:GetSpiritVip() == 1 then
        userNameStr = ((NekoData.BehaviorManager).BM_Message):GetString(2090, {friend:GetName()})
      else
        userNameStr = friend:GetName()
      end
      ;
      (self._name):SetText(userNameStr)
      ;
      (self._nameLight):SetText(userNameStr)
      ;
      (self._name):SetActive(friend:GetSpiritVip() ~= 1)
      ;
      (self._nameLight):SetActive(friend:GetSpiritVip() == 1)
      ;
      (self._time):SetText(data:GetChatTimeStr())
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end
end

return FriendChatLeftImageCell

