-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/friend/friendchatemojicell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local CFriendEmoji = (BeanManager.GetTableByName)("guild.cguildemoji")
local FriendChatEmojiCell = class("FriendChatEmojiCell", Dialog)
FriendChatEmojiCell.AssetBundleName = "ui/layouts.guild"
FriendChatEmojiCell.AssetName = "GuildChatEmojiCell"
FriendChatEmojiCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FriendChatEmojiCell
  ((FriendChatEmojiCell.super).Ctor)(self, ...)
end

FriendChatEmojiCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("Image")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

FriendChatEmojiCell.RefreshCell = function(self, data)
  -- function num : 0_2 , upvalues : CFriendEmoji, CImagePath, _ENV
  local imgId = (CFriendEmoji:GetRecorder(data)).EmojiId
  if not CImagePath:GetRecorder(imgId) then
    local spriteRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._image):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
end

FriendChatEmojiCell.OnCellClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local friend = ((NekoData.BehaviorManager).BM_Friends):GetFriend((self._delegate):GetSelectedFriend())
  if not friend then
    return 
  end
  local csend = (LuaNetManager.CreateProtocol)("protocol.chat.csendfriendmsg")
  if csend then
    csend.userId = friend:GetID()
    local hyperlink = (LuaNetManager.GetBeanDef)("protocol.chat.hyperlink")
    local hyperlinks = {}
    hyperlinks[1] = hyperlink
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (hyperlinks[1]).linkType = hyperlink.EMOJI
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

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

return FriendChatEmojiCell

