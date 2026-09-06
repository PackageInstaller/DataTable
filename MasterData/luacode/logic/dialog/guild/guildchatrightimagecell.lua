local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CGuildEmoji = BeanManager.GetTableByName("guild.cguildemoji")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CWordColor = BeanManager.GetTableByName("message.cwordcolor")
local GuildChatRightImageCell = class("GuildChatRightImageCell", Dialog)
GuildChatRightImageCell.AssetBundleName = "ui/layouts.guild"
GuildChatRightImageCell.AssetName = "GuildChatRightImage"
local SecToDay = 86400
local JobColor = {
  [1] = 29,
  [2] = 30,
  [3] = 31
}

local function GetTimeStr(ms)
  local interval = (ServerGameTimer.GetServerTime() - ms) // 1000
  local sec = ms // 1000
  if interval < SecToDay then
    local lt = os.date("*t", sec)
    return string.format("%02d:%02d", lt.hour, lt.min)
  elseif interval < SecToDay * 30 then
    local lt = os.date("*t", sec)
    return string.format("%02d-%02d %02d:%02d", lt.month, lt.day, lt.hour, lt.min)
  elseif interval < SecToDay * 30 * 12 then
    local lt = os.date("*t", sec)
    return string.format("%04d-%02d-%02d %02d:%02d", lt.year, lt.month, lt.day, lt.hour, lt.min)
  end
end

function GuildChatRightImageCell:Ctor(...)
  GuildChatRightImageCell.super.Ctor(self, ...)
end

function GuildChatRightImageCell:OnCreate()
  self._photo = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._photoFrame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  self._job = self:GetChild("PlayerInfo/Position")
  self._jobText = self:GetChild("PlayerInfo/Position/Txt")
  self._name = self:GetChild("PlayerInfo/Name")
  self._nameLight = self:GetChild("PlayerInfo/NameLight")
  self._lv = self:GetChild("LvBack/Level")
  self._photoFrame:Subscribe_PointerClickEvent(self.OnPhotoClicked, self)
  self._empji = self:GetChild("Emoji")
  self._time = self:GetChild("Time")
  self._name_width, self._name_height = self._name:GetRectSize()
  self._name_text_size_x, self._name_text_size_offset_x, self._name_text_size_y, self._name_text_size_offset_y = self._name:GetSize()
  self._name_pos_x, self._name_pos_offset_x, self._name_pos_y, self._name_pos_offset_y = self._name:GetPosition()
  self._job_pos_x, self._job_pos_offset_x, self._job_pos_y, self._job_pos_offset_y = self._job:GetPosition()
end

function GuildChatRightImageCell:RefreshCell(data)
  self._data = data.data
  local imageRecord
  local headPhotoRecord = HeadPhotoTable:GetRecorder(self._data.baseUserData.avatarId)
  if headPhotoRecord then
    imageRecord = CImagePath:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("GuildChatRightImageCell", "userInfo.avatarId %s is wrong", self._data.baseUserData.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(self._data.baseUserData.frameId)
  if headPhotoFrameRecord then
    imageRecord = CImagePath:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._photoFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("GuildChatRightImageCell", "userInfo.frameId %s is wrong", self._data.baseUserData.frameId)
  end
  self._job:SetActive(self._data.position ~= 4)
  local jobstr = NekoData.BehaviorManager.BM_Guild:GetJobStr(self._data.position)
  local colorId = JobColor[self._data.position]
  if colorId then
    jobstr = "<color=#" .. CWordColor:GetRecorder(colorId).wordcolor .. ">" .. jobstr .. "</color>"
    self._jobText:SetText(jobstr)
  else
    self._jobText:SetText(jobstr)
  end
  local userNameStr
  if self._data.baseUserData.spiritvip == 1 then
    userNameStr = NekoData.BehaviorManager.BM_Message:GetString(2090, {
      self._data.baseUserData.userName
    })
  else
    userNameStr = self._data.baseUserData.userName
  end
  self._name:SetText(userNameStr)
  self._nameLight:SetText(userNameStr)
  self._name:SetActive(self._data.baseUserData.spiritvip ~= 1)
  self._nameLight:SetActive(self._data.baseUserData.spiritvip == 1)
  local textWidth, textheight = self._name:GetPreferredSize()
  local delta = self._name_width - textWidth
  self._name:SetSize(self._name_text_size_x, self._name_text_size_offset_x - delta, self._name_text_size_y, self._name_text_size_offset_y)
  self._nameLight:SetSize(self._name_text_size_x, self._name_text_size_offset_x - delta, self._name_text_size_y, self._name_text_size_offset_y)
  self._name:SetPosition(self._name_pos_x, self._name_pos_offset_x + delta, self._name_pos_y, self._name_pos_offset_y)
  self._nameLight:SetPosition(self._name_pos_x, self._name_pos_offset_x + delta, self._name_pos_y, self._name_pos_offset_y)
  self._job:SetPosition(self._job_pos_x, self._job_pos_offset_x + delta, self._job_pos_y, self._job_pos_offset_y)
  self._lv:SetText(self._data.baseUserData.userLv)
  local imgId = CGuildEmoji:GetRecorder(self._data.hyperlinks[1].linkText).EmojiId
  local imageRecord = CImagePath:GetRecorder(imgId) or DataCommon.DefaultImageAsset
  self._empji:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._time:SetActive(data.showTime)
  if data.showTime then
    self._time:SetText(GetTimeStr(self._data.sendTime))
  end
end

function GuildChatRightImageCell:OnPhotoClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.clookotherinfo")
  protocol.userId = self._cellData.data.baseUserData.userId
  protocol:Send()
end

return GuildChatRightImageCell
