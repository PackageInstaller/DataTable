local HeadTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local FrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
local CFriendEmoji = BeanManager.GetTableByName("guild.cguildemoji")
local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CChatFrameConfig = BeanManager.GetTableByName("headphoto.cchatframeconfig")
local Friend = require("logic.manager.experimental.types.friend")
local ChatInfoTimeCell = class("ChatInfoTimeCell", Dialog)
ChatInfoTimeCell.AssetBundleName = "ui/layouts.chat"
ChatInfoTimeCell.AssetName = "ChatNewCharCellLeftTime"

function ChatInfoTimeCell:Ctor(...)
  ChatInfoTimeCell.super.Ctor(self, ...)
  self._name = nil
  self._photo = nil
  self._info = nil
end

function ChatInfoTimeCell:OnCreate()
  self._time = self:GetChild("Time")
  self._photo = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._name = self:GetChild("PlayerInfo/Name")
  self._frame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  self._level = self:GetChild("PlayerInfo/LvBack/Level")
  self._info = self:GetChild("Bubble/Text")
  self._talk = self:GetChild("Bubble")
  self._empji = self:GetChild("Emoji")
  self._info:Subscribe_BeginLongPressEvent(self.OnBeginLongPress, self)
  self._imageColor = self._talk:GetColor()
  self._photo:Subscribe_PointerClickEvent(self.OnIconClicked, self)
  self._talk:SetActive(false)
  self._empji:SetActive(false)
  local _ = 0
  self._info:SetText("")
  self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y = self._talk:GetSize()
  self._cell_size_x, self._cell_size_offset_x, self._cell_size_y, self._cell_size_offset_y = self:GetRootWindow():GetSize()
  self._info_size_x, self._info_size_offset_x, self._info_size_y, self._info_size_offset_y = self._info:GetSize()
  self._talkHeight = self._talk_size_y * self._cell_size_offset_y + self._talk_size_offset_y
  self._infoHeight = self._info_size_y * self._talkHeight + self._info_size_offset_y
end

function ChatInfoTimeCell:OnDestroy()
end

function ChatInfoTimeCell:RefreshCell(data)
  local temp = HeadTable:GetRecorder(data.headid)
  if temp then
    local gamerInfo = ImageTable:GetRecorder(temp.photoid) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(gamerInfo.assetBundle, gamerInfo.assetName)
  end
  temp = FrameTable:GetRecorder(data.frameid)
  if temp then
    local gamerInfo = ImageTable:GetRecorder(temp.photoid) or DataCommon.DefaultImageAsset
    self._frame:SetSprite(gamerInfo.assetBundle, gamerInfo.assetName)
  end
  if data.username == "" then
    local str = TextManager.GetText(BeanManager.GetTableByName("message.cstringres"):GetRecorder(1217).msgTextID)
    data.username = str
  end
  self._level:SetText(data.level)
  self._name:SetText(data.username)
  self._info:SetText("")
  self._time:SetText(ServerGameTimer.GetTimeHourMinStr(data.receiveTime))
  self._data = data
  local useEmoji = false
  if data.msg == "" then
    if data.hyperlinks and #data.hyperlinks > 0 then
      local imgId = CFriendEmoji:GetRecorder(data.hyperlinks[1].linkText).EmojiId
      if imgId then
        self._empji:SetActive(true)
        self._talk:SetActive(false)
        local imageRecord = CImagePath:GetRecorder(imgId) or DataCommon.DefaultImageAsset
        self._empji:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        useEmoji = true
      end
    end
  else
    self._talk:SetActive(true)
    local color = ""
    if 0 < data.bubbleID then
      local record = CChatFrameConfig:GetRecorder(data.bubbleID)
      if record then
        color = record.color or ""
        local spriteRecord = CImagePath:GetRecorder(record.leftphotoid)
        if spriteRecord then
          self._talk:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
        end
      end
    end
    self._empji:SetActive(false)
    self._info:SetText(data.msg, color)
  end
  if useEmoji then
    local extheight = 48
    self:GetRootWindow():SetSize(self._cell_size_x, self._cell_size_offset_x, self._cell_size_y, self._cell_size_offset_y + extheight)
  else
    local _, textheight = self._info:GetPreferredSize()
    if textheight > self._infoHeight then
      local delta = textheight - self._infoHeight + 10
      self:GetRootWindow():SetSize(self._cell_size_x, self._cell_size_offset_x, self._cell_size_y, self._cell_size_offset_y + delta)
    else
      self:GetRootWindow():SetSize(self._cell_size_x, self._cell_size_offset_x, self._cell_size_y, self._cell_size_offset_y)
    end
  end
end

function ChatInfoTimeCell:OnBeginLongPress(args)
  self._delegate:SetColorInCell(self._talk, self._imageColor)
  local _1, x, _2, y = self:GetRootWindow():GetPosition()
  self._delegate:CopyCellInfo(x, y, true, self._info:GetText())
end

function ChatInfoTimeCell:OnIconClicked()
  local friend = Friend.Create()
  friend:SetDataFromChatMsg(self._data)
  local dialog = DialogManager.CreateSingletonDialog("friend.playinfotipsdialog")
  if dialog then
    dialog:Init(friend, friend:IsFriend())
    dialog:UpdatePosition(self._photo)
  end
end

return ChatInfoTimeCell
