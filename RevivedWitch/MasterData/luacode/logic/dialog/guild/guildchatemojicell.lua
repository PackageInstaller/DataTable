-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildchatemojicell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local CGuildEmoji = (BeanManager.GetTableByName)("guild.cguildemoji")
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local GuildChatEmojiCell = class("GuildChatEmojiCell", Dialog)
GuildChatEmojiCell.AssetBundleName = "ui/layouts.guild"
GuildChatEmojiCell.AssetName = "GuildChatEmojiCell"
GuildChatEmojiCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildChatEmojiCell
  ((GuildChatEmojiCell.super).Ctor)(self, ...)
end

GuildChatEmojiCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("Image")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

GuildChatEmojiCell.RefreshCell = function(self, data)
  -- function num : 0_2 , upvalues : CGuildEmoji, CImagePath, _ENV
  local imgId = (CGuildEmoji:GetRecorder(data)).EmojiId
  if not CImagePath:GetRecorder(imgId) then
    local spriteRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._image):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
end

GuildChatEmojiCell.OnCellClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV, CVarconfig
  if ((NekoData.BehaviorManager).BM_Game):IsGuest() and (CVarconfig:GetRecorder(95)).Value == "0" then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100339)
    return 
  end
  local csend = (LuaNetManager.CreateProtocol)("protocol.chat.csendpartymsg")
  if csend then
    csend.partyId = ((NekoData.BehaviorManager).BM_Guild):GetGuildID()
    local hyperlink = (LuaNetManager.GetBeanDef)("protocol.chat.hyperlink")
    local hyperlinks = {}
    hyperlinks[1] = hyperlink
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (hyperlinks[1]).linkType = hyperlink.EMOJI
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (hyperlinks[1]).linkText = self._cellData
    csend.hyperlinks = hyperlinks
    csend:Send()
  end
  do
    ;
    (self._delegate):HideEmojiFrame()
  end
end

return GuildChatEmojiCell

