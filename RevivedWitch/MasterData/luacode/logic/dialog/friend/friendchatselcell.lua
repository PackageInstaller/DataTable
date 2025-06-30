-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/friend/friendchatselcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HeadTable = (BeanManager.GetTableByName)("chat.cchatphoto")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local FriendChatSelCell = class("FriendChatSelCell", Dialog)
FriendChatSelCell.AssetBundleName = "ui/layouts.friends"
FriendChatSelCell.AssetName = "FriendsChatCellRight"
FriendChatSelCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FriendChatSelCell
  ((FriendChatSelCell.super).Ctor)(self, ...)
end

FriendChatSelCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._frame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  self._level = self:GetChild("PlayerInfo/LvBack/Level")
  self._name = self:GetChild("PlayerInfo/HeadPhoto/Name")
  self._nameLight = self:GetChild("PlayerInfo/HeadPhoto/NameLight")
  self._time = self:GetChild("Time")
  self._bubble = self:GetChild("Bubble")
  self._text = self:GetChild("Bubble/Text")
  self._imageColor = (self._bubble):GetColor()
  ;
  (self._text):SetText("")
  self._width = (self._text):GetRectSize()
  local _ = 0
  _ = (self._text):GetPreferredSize()
  self._text_size_x = (self._bubble):GetSize()
  self._text_pos_x = (self._bubble):GetPosition()
  self._talk_size_x = (self:GetRootWindow()):GetSize()
  self._talk_pos_x = (self:GetRootWindow()):GetPosition()
end

FriendChatSelCell.OnDestroy = function(self)
  -- function num : 0_2
end

FriendChatSelCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, HeadPhotoTable, CImagePathTable, HeadPhotoFrameTable
  self._data = data
  local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(1)
  ;
  (self._level):SetText(role:GetLevel())
  ;
  (self._text):SetText((self._data):GetChatMsg())
  ;
  (self._time):SetText((self._data):GetChatTimeStr())
  local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
  local headPhotoRecord = HeadPhotoTable:GetRecorder(userInfo.avatarId)
  if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
  if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
    imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
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
  ;
  (self._bubble):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y)
  local textWidth, textheight = (self._text):GetPreferredSize()
  if self._height < textheight then
    local line = (math.ceil)((textheight - self._height) / self._oneline)
    local delta = line * self._oneline
    ;
    (self._bubble):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    ;
    (self._bubble):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
    ;
    (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
  else
    do
      if self._width < textWidth then
        local line = (math.floor)(textWidth / self._width)
        local delta = line * self._oneline
        ;
        (self._bubble):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
        ;
        (self._bubble):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
        ;
        (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
      else
        do
          local delta = self._width - textWidth
          ;
          (self._bubble):SetSize(self._text_size_x, self._text_size_offset_x - delta, self._text_size_y, self._text_size_offset_y)
          ;
          (self._bubble):SetPosition(self._text_pos_x, self._text_pos_offset_x + delta, self._text_pos_y, self._text_pos_offset_y)
          ;
          (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
        end
      end
    end
  end
end

return FriendChatSelCell

