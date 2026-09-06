local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CGuildEmoji = BeanManager.GetTableByName("guild.cguildemoji")
local CVarconfig = BeanManager.GetTableByName("var.cvarconfig")
local GuildChatEmojiCell = class("GuildChatEmojiCell", Dialog)
GuildChatEmojiCell.AssetBundleName = "ui/layouts.guild"
GuildChatEmojiCell.AssetName = "GuildChatEmojiCell"

function GuildChatEmojiCell:Ctor(...)
  GuildChatEmojiCell.super.Ctor(self, ...)
end

function GuildChatEmojiCell:OnCreate()
  self._image = self:GetChild("Image")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function GuildChatEmojiCell:RefreshCell(data)
  local imgId = CGuildEmoji:GetRecorder(data).EmojiId
  local spriteRecord = CImagePath:GetRecorder(imgId) or DataCommon.DefaultImageAsset
  self._image:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
end

function GuildChatEmojiCell:OnCellClicked()
  if NekoData.BehaviorManager.BM_Game:IsGuest() and CVarconfig:GetRecorder(95).Value == "0" then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100339)
    return
  end
  local csend = LuaNetManager.CreateProtocol("protocol.chat.csendpartymsg")
  if csend then
    csend.partyId = NekoData.BehaviorManager.BM_Guild:GetGuildID()
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

return GuildChatEmojiCell
