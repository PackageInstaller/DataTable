-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/friendchat/sgetfriendchat.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SGetFriendChat = require("localprotocols.def.friendchat.sgetfriendchat")
SGetFriendChat.Process = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SGetFriendChat Process")
  end
  ;
  ((NekoData.DataManager).DM_FriendsChat):OnSGetFriendChat(self)
  ;
  ((NekoData.DataManager).DM_Friends):CheckFriendPageRedData()
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_FriendLocalChatReceive, nil, self)
end

return SGetFriendChat

