local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CFriendEmoji = BeanManager.GetTableByName("guild.cguildemoji")
local BaseMainChatCell = class("BaseMainChatCell", Dialog)
BaseMainChatCell.AssetBundleName = "ui/layouts.basemainhud"
BaseMainChatCell.AssetName = "BaseMainChatCell"

function BaseMainChatCell:Ctor(...)
  BaseMainChatCell.super.Ctor(self, ...)
end

function BaseMainChatCell:OnCreate()
  self._talk = self:GetChild("Bubble")
  self._emoji = self:GetChild("Bubble/Emoji")
  self._name = self:GetChild("Bubble/PlayerName")
  self._info = self:GetChild("Bubble/Text")
  self._info:SetText("")
  self._name:SetText("")
  self._emoji:SetActive(false)
  self._info:SetActive(false)
  self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y = self._talk:GetSize()
  self._cell_size_x, self._cell_size_offset_x, self._cell_size_y, self._cell_size_offset_y = self:GetRootWindow():GetSize()
  self._info_size_x, self._info_size_offset_x, self._info_size_y, self._info_size_offset_y = self._info:GetSize()
  self._cell_size_offset_x = self._cell_size_offset_x - 25
  self._talkHeight = self._talk_size_y * self._cell_size_offset_y + self._talk_size_offset_y
  self._infoHeight = self._info_size_y * self._talkHeight + self._info_size_offset_y
end

function BaseMainChatCell:RefreshCell(data)
  if data.username == "" then
    local str = TextManager.GetText(BeanManager.GetTableByName("message.cstringres"):GetRecorder(1217).msgTextID)
    data.username = str
  end
  local finalname = TextManager.GetText(BeanManager.GetTableByName("message.cstringres"):GetRecorder(2295).msgTextID)
  finalname = string.gsub(finalname, "%$parameter1%$", data.username)
  self._name:SetText(finalname)
  self._info:SetText("")
  local useEmoji = false
  if data.msg == "" then
    if data.hyperlinks and #data.hyperlinks > 0 then
      local imgId = CFriendEmoji:GetRecorder(data.hyperlinks[1].linkText).EmojiId
      if imgId then
        self._emoji:SetActive(true)
        self._info:SetActive(false)
        local imageRecord = CImagePath:GetRecorder(imgId) or DataCommon.DefaultImageAsset
        self._emoji:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        useEmoji = true
      end
    end
  else
    self._info:SetActive(true)
    self._emoji:SetActive(false)
    self._info:SetText(data.msg)
  end
  self:UpdatePosition(useEmoji)
end

function BaseMainChatCell:UpdatePosition(useEmoji)
  local namewAnchor, _ = self._name:GetWidth()
  local info_anchor, _ = self._info:GetXPosition()
  local emoji_anchor, _ = self._emoji:GetXPosition()
  local nameWith, _ = self._name:GetPreferredSize()
  self._name:SetWidth(namewAnchor, nameWith + 10)
  self._info:SetXPosition(info_anchor, nameWith + 10)
  self._emoji:SetXPosition(emoji_anchor, nameWith + 10)
  if useEmoji then
    self:GetRootWindow():SetSize(self._cell_size_x, self._cell_size_offset_x, self._cell_size_y, self._cell_size_offset_y)
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

return BaseMainChatCell
