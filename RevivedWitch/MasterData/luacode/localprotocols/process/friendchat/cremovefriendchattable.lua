-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/friendchat/cremovefriendchattable.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CRemoveFriendChatTable = require("localprotocols.def.friendchat.cremovefriendchattable")
CRemoveFriendChatTable.Process = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CRemoveFriendChatTable Process")
  end
  ;
  (SqlConnection.RemoveFriendChatTable)(self.userId)
end

return CRemoveFriendChatTable

