local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CFriendEmoji = BeanManager.GetTableByName("guild.cguildemoji")
local FriendChatEmojiCell = class("FriendChatEmojiCell", Dialog)
FriendChatEmojiCell.AssetBundleName = "ui/layouts.guild"
FriendChatEmojiCell.AssetName = "GuildChatEmojiCell"

function FriendChatEmojiCell:Ctor(...)
  FriendChatEmojiCell.super.Ctor(self, ...)
end

function FriendChatEmojiCell:OnCreate()
  self._image = self:GetChild("Image")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function FriendChatEmojiCell:RefreshCell(data)
  local imgId = CFriendEmoji:GetRecorder(data).EmojiId
  local spriteRecord = CImagePath:GetRecorder(imgId) or DataCommon.DefaultImageAsset
  self._image:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
end

function FriendChatEmojiCell:OnCellClicked()
  local friend = NekoData.BehaviorManager.BM_Friends:GetFriend(self._delegate:GetSelectedFriend())
  if not friend then
    return
  end
  local csend = LuaNetManager.CreateProtocol("protocol.chat.csendfriendmsg")
  if csend then
    csend.userId = friend:GetID()
    local hyperlink = LuaNetManager.GetBeanDef("protocol.chat.hyperlink")
    local hyperlinks = {}
    hyperlinks[1] = hyperlink
    hyperlinks[1].linkType = hyperlink.EMOJI
    hyperlinks[1].linkText = self._cellData
    csend.hyperlinks = hyperlinks
    csend:Send()
  end
  self._delegate:HideEmojiFrame()
end

return FriendChatEmojiCell
