local HeadTable = BeanManager.GetTableByName("chat.cchatphoto")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CChatFrameConfig = BeanManager.GetTableByName("headphoto.cchatframeconfig")
local FriendChatSelCell = class("FriendChatSelCell", Dialog)
FriendChatSelCell.AssetBundleName = "ui/layouts.friends"
FriendChatSelCell.AssetName = "FriendsChatCellRight"

function FriendChatSelCell:Ctor(...)
  FriendChatSelCell.super.Ctor(self, ...)
end

function FriendChatSelCell:OnCreate()
  self._icon = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._frame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  self._level = self:GetChild("PlayerInfo/LvBack/Level")
  self._name = self:GetChild("PlayerInfo/HeadPhoto/Name")
  self._nameLight = self:GetChild("PlayerInfo/HeadPhoto/NameLight")
  self._time = self:GetChild("Time")
  self._bubble = self:GetChild("Bubble")
  self._text = self:GetChild("Bubble/Text")
  self._imageColor = self._bubble:GetColor()
  self._text:SetText("")
  self._width, self._height = self._text:GetRectSize()
  local _ = 0
  _, self._oneline = self._text:GetPreferredSize()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._bubble:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._bubble:GetPosition()
  self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y = self:GetRootWindow():GetSize()
  self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y = self:GetRootWindow():GetPosition()
end

function FriendChatSelCell:OnDestroy()
end

function FriendChatSelCell:RefreshCell(data)
  self._data = data
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(1)
  local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  local headPhotoRecord = HeadPhotoTable:GetRecorder(userInfo.avatarId)
  local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
  imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
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
  local color = ""
  if data._bubbleID >= 0 then
    local record = CChatFrameConfig:GetRecorder(data._bubbleID)
    if record then
      color = record.color or ""
      local spriteRecord = CImagePath:GetRecorder(record.photoid)
      if spriteRecord then
        self._bubble:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
      end
    end
  end
  self._level:SetText(role:GetLevel())
  self._text:SetText(self._data:GetChatMsg(), color)
  self._time:SetText(self._data:GetChatTimeStr())
  self._bubble:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y)
  local textWidth, textheight = self._text:GetPreferredSize()
  if textheight > self._height then
    local line = math.ceil((textheight - self._height) / self._oneline)
    local delta = line * self._oneline
    self._bubble:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    self._bubble:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
  elseif textWidth > self._width then
    local line = math.floor(textWidth / self._width)
    local delta = line * self._oneline
    self._bubble:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    self._bubble:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
  else
    local delta = self._width - textWidth
    self._bubble:SetSize(self._text_size_x, self._text_size_offset_x - delta, self._text_size_y, self._text_size_offset_y)
    self._bubble:SetPosition(self._text_pos_x, self._text_pos_offset_x + delta, self._text_pos_y, self._text_pos_offset_y)
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
  end
end

return FriendChatSelCell
