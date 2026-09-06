local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CFriendEmoji = BeanManager.GetTableByName("guild.cguildemoji")
local ChatEmojiCell = class("ChatEmojiCell", Dialog)
ChatEmojiCell.AssetBundleName = "ui/layouts.guild"
ChatEmojiCell.AssetName = "GuildChatEmojiCell"

function ChatEmojiCell:Ctor(...)
  ChatEmojiCell.super.Ctor(self, ...)
end

function ChatEmojiCell:OnCreate()
  self._image = self:GetChild("Image")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self.data = nil
end

function ChatEmojiCell:RefreshCell(data)
  self.data = data
  local imgId = CFriendEmoji:GetRecorder(data).EmojiId
  local spriteRecord = CImagePath:GetRecorder(imgId) or DataCommon.DefaultImageAsset
  self._image:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
end

function ChatEmojiCell:OnCellClicked()
  if self.data ~= nil then
    self._delegate:OnSendEmojiMsg(self.data)
  end
  self._delegate:HideEmojiFrame()
end

return ChatEmojiCell
