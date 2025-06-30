-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/friendchat/cgetfriendchat.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CGetFriendChat = require("localprotocols.def.friendchat.cgetfriendchat")
CGetFriendChat.Process = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CGetFriendChat Process")
  end
  ;
  (SqlConnection.GetMsg)(self.userId, self.beginId, self.endId)
end

return CGetFriendChat

