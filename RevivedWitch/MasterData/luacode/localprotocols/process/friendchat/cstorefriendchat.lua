-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/friendchat/cstorefriendchat.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStoreFriendChat = require("localprotocols.def.friendchat.cstorefriendchat")
CStoreFriendChat.Process = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CStoreFriendChat Process")
  end
  ;
  (SqlConnection.StoreMsg)(self.userId, self.msg)
end

return CStoreFriendChat

