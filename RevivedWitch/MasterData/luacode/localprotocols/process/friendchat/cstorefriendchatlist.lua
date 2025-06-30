-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/friendchat/cstorefriendchatlist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStoreFriendChatList = require("localprotocols.def.friendchat.cstorefriendchatlist")
CStoreFriendChatList.Process = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CStoreFriendChatList Process")
  end
  ;
  (SqlConnection.StoreMsgList)(self.userId, self.msgs)
end

return CStoreFriendChatList

